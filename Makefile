
hello:
	echo "Hello, World"

train:
	echo "Train model"
	python src/test3.py --max_evals=2

conda: 
	cd /mlops-zoomcamp-project
	conda create --name mlops-project python=3.9
	mamba activate mlops-project
	pip install -r requirements.txt

init-macos:
	echo "Hello macOS"
	#echo "Install Anaconda3"
	# Install mamba instead of conda, because it's faster 
	wget "https://repo.anaconda.com/archive/Anaconda3-2023.03-1-MacOSX-arm64.sh"
	bash Anaconda3-2023.03-1-MacOSX-arm64.sh
	rm Anaconda3-2023.03-1-MacOSX-arm64.sh

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

init-ubuntu:
	# echo "Install Anaconda"
	# rm -rf /home/ubuntu/miniconda3
	# wget https://repo.anaconda.com/archive/Anaconda3-2022.05-Linux-x86_64.sh
	# bash Anaconda3-2022.05-Linux-x86_64.sh -b -p
	# rm Anaconda3-2022.05-Linux-x86_64.sh

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

	
