hello:
	echo "Hello, World"

init:
	echo "Install Miniconda."
	wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.12.0-Linux-x86_64.sh
	bash Miniconda3-py39_4.12.0-Linux-x86_64.sh
	echo "Install Docker."
	sudo apt update
	sudo apt install docker.io