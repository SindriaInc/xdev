# Xdev Docs

## Requirements

### Windows

[Docker Desktop for Windows](https://docs.docker.com/docker-for-windows/install/)


### OSX

[Docker Desktop for Mac](https://docs.docker.com/docker-for-mac/install/)


### Ubuntu

#### Install Docker

1) `sudo apt update`
   

2) `sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release`
   

3) `curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg`
   

4) `echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null`


5) `sudo apt update`


6) `sudo apt install -y docker-ce docker-ce-cli containerd.io`


7) `sudo usermod -a -G docker <user>`


8) `sudo systemctl start docker`
   

9) `sudo systemctl enable docker`


### Fedora

#### Install Docker

1) `sudo dnf -y install dnf-plugins-core`


2) `sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo`
   

3) `sudo dnf install -y docker-ce docker-ce-cli containerd.io`


4) `sudo usermod -a -G docker <user>`


5) `sudo systemctl start docker`
   

6) `sudo systemctl enable docker`


### Linux

#### Install Docker Compose

1) `sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose`


2) `sudo chmod +x /usr/local/bin/docker-compose`

## Links

- [Docker Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
- [Docker Fedora](https://docs.docker.com/engine/install/fedora/)
- [Docker Compose](https://docs.docker.com/compose/install/)