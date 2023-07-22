resource "google_compute_firewall" "web" {
  name    = "${var.prefix}-firewall-web"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports = [
      var.service_port,
    ]
  }
  source_ranges = [var.bastion_instance_access_cidr]
  target_tags   = ["dpt-gcp-web"]
  priority      = 1000
}

resource "google_compute_firewall" "web_ssh" {
  name    = "${var.prefix}-firewall-web-ssh"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports = [
      22,
    ]
  }
  source_ranges = [var.web_instance_access_cidr]
  target_tags   = ["dpt-gcp-web-ssh"]
  priority      = 1000
}

resource "google_compute_firewall" "ssh" {
  name    = "${var.prefix}-firewall-ssh"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports = [
      22,
    ]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["dpt-gcp-ssh"]
  priority      = 1000
}

resource "google_compute_instance" "compute_instance" {
  name         = "${var.prefix}-compute-instance"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.boot_disk
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }

  tags = ["dpt-gcp-web", "dpt-gcp-web-ssh"]

  metadata = {
    ssh-keys               = "${var.ssh_user}:${tls_private_key.ssh.public_key_openssh}"
    block-project-ssh-keys = true
  }

  metadata_startup_script = templatefile("./template/install.sh", {
    service_port = var.service_port
  })
}

#bastion static ip
resource "google_compute_address" "static" {
  name       = "bastion-public-address"
  project    = var.project
  region     = var.region
  depends_on = [google_compute_firewall.ssh]
}

#bastion os
resource "google_compute_instance" "compute_bastion" {
  name         = "${var.prefix}-compute-bastion"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.boot_disk
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }
  metadata = {
    ssh-keys               = "${var.ssh_user}:${tls_private_key.ssh.public_key_openssh}"
    block-project-ssh-keys = true
  }
  tags = ["dpt-gcp-ssh"]

  provisioner "file" {
    source      = ".ssh/google_compute_engine"
    destination = "/home/${var.ssh_user}/google_compute_engine"

    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = tls_private_key.ssh.private_key_pem
      agent       = "false"
      host        = google_compute_address.static.address
    }
  }

  metadata_startup_script = "chmod 0400 /home/${var.ssh_user}/google_compute_engine"

  depends_on = [tls_private_key.ssh]
}