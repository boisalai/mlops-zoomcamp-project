hello:
	echo "Hello, World"

init:
	echo "Install Miniconda"
	wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.12.0-Linux-x86_64.sh
	bash Miniconda3-py39_4.12.0-Linux-x86_64.sh -b -p
	echo "Install Docker"
	sudo apt update
	sudo apt install docker.io
	echo "Download Docker Compose and made it executable"
	# See https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04#step-1-installing-docker-compose
	sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
	docker-compose --version
