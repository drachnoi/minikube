resource "digitalocean_droplet" "minikube-1" {
  image = "ubuntu-18-04-x64"
  name = "minikube-1"
  region = "fra1"
  size = "s-4vcpu-8gb"
  private_networking = true
  ssh_keys = [
    var.ssh_fingerprint
  ]
  connection {
    user = "root"
    type = "ssh"
    private_key = file(var.pvt_key)
    host = self.ipv4_address
    timeout = "2m"
  }
  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt update",
      # install docker
      "sudo apt install docker.io -y",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      # install minikube
      "curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64",
      "sudo install minikube-linux-amd64 /usr/local/bin/minikube",
      # install kubectl
      "sudo snap install kubectl --classic",
      "minikube start --vm-driver none"
    ]
  }

  provisioner "local-exec" {
    command = "./setup-kubectl.sh ${self.ipv4_address}"
  }
}
