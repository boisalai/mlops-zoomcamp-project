#!/bin/bash

# Terminate script on any error and log all output to file.
set -e
USER=ubuntu
exec > /home/$USER/setup.log
exec 2>&1

# Change directory.
cd /home/$USER
current_date_time=$(date)
echo "Current date and time: $current_date_time" | sudo tee /home/$USER/setup.log

# Install Miniconda silently.
# sudo wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh
# sudo -u $USER bash /tmp/miniconda.sh -b -p /home/$USER/miniconda
# sudo -u $USER /home/$USER/miniconda/bin/conda init bash
# . "/home/$USER/miniconda/etc/profile.d/conda.sh"
# export PATH="/home/$USER/miniconda/bin:$PATH"

echo "Install Mambaforge silently."
# See https://github.com/fastai/fastsetup/blob/master/setup-conda.sh
curl -LO --no-progress-meter https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh
sudo -u $USER bash Mambaforge-*.sh -b
sudo -u $USER rm -rf Mambaforge-*.sh
sudo -u $USER /home/$USER/mambaforge/bin/conda init bash
. "/home/ubuntu/mambaforge/etc/profile.d/conda.sh"

# Useful for debugging any issues with conda.
sudo -u $USER conda info -a | sudo tee /home/$USER/setup.log

# echo "Install miniconda."
# Je crois que cette section ne sert à rien.
# conda install -yq mamba
# conda install -yq -c conda-forge mamba

echo "Install Docker."
sudo apt update
sudo apt -y install docker.io

echo "Download Docker Compose and made it executable."
# See https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04#step-1-installing-docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "Add your user to the docker group."
# See https://docs.docker.com/engine/install/linux-postinstall/
sudo usermod -aG docker $USER

echo "Install Make."
sudo apt -y install make

echo "Clone the project."
git clone https://github.com/boisalai/mlops-zoomcamp-project.git
cd mlops-zoomcamp-project

echo "Create conda environment."
conda create -n mlops-zoomcamp python=3.9
conda activate mlops-zoomcamp

echo "Install required dependencies."
pip install -r requirements.txt
# mamba install --file requirements.txt