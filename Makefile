hello:
	echo "Hello, World"

install:
	echo "Create a conda environment and initialize"
	export CONDA_ALWAYS_YES="true"
	conda create -n mlops-project python==3.9
	# conda init bash

	conda activate mlops-project
	echo "Install dependencies"
	pip install -r requirements.txt

init:
	echo "Install Miniconda"
	rm -rf /home/ubuntu/miniconda3
	wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.12.0-Linux-x86_64.sh
	bash Miniconda3-py39_4.12.0-Linux-x86_64.sh -b -p
	rm Miniconda3-py39_4.12.0-Linux-x86_64.sh
	# /home/ubuntu/miniconda3/bin/conda init
	
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

	
