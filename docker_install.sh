#/bin/sh

# Update APT packages
apt-get update

# Setup repo to use HTTPS
apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Make keyring
mkdir -m 0755 -p /etc/apt/keyrings

# Add Docker GPG Key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up the repo
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Change permissions on keyring
chmod a+r /etc/apt/keyrings/docker.gpg

# Add Repo
apt-get update

# Set version
VERSION_STRING=5:20.10.23~3-0~ubuntu-bionic
apt-get install docker-ce=$VERSION_STRING docker-ce-cli=$VERSION_STRING containerd.io docker-buildx-plugin docker-compose-plugin

# Install Docker Compose
wget https://github.com/docker/compose/releases/download/v2.16.0/docker-compose-linux-x86_64
mv docker-compose-linux-x86_64 docker-compose
chmod +x docker-compose
mv docker-compose /usr/local/bin/
