hello:
	echo "Hello, World"

mamba: 
	cd /mlops-zoomcamp-project
	mamba create --name mlops-project python=3.10.9
	mamba activate mlops-project
	pip install -r requirements.txt

init:
	# echo "Install Miniconda"
	# rm -rf /home/ubuntu/miniconda3
	# wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.12.0-Linux-x86_64.sh
	# bash Miniconda3-py39_4.12.0-Linux-x86_64.sh -b -p
	# rm Miniconda3-py39_4.12.0-Linux-x86_64.sh
	
	echo "Install Mamba"
	# Install mamba instead of conda, because it's faster 
	# https://mamba.readthedocs.io/en/latest/installation.html
	rm -rf /home/ubuntu/miniconda3
	wget "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh"
	bash Mambaforge-$(uname)-$(uname -m).sh
	rm Mambaforge-$(uname)-$(uname -m).sh

	echo "Install Docker"
	sudo apt install docker.io
	
	echo "Download Docker Compose and made it executable"
	# See https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04#step-1-installing-docker-compose
	sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
	docker-compose --version
	which docker-compose

	echo "Add your user to the docker group"
	# See https://docs.docker.com/engine/install/linux-postinstall/
	sudo groupadd docker
	sudo usermod -aG docker ${USER}

	
