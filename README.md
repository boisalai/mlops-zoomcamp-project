<!--
<p align="center" width="100%"><img src="assets/pic.png" alt="Pic" style="width: 50%;  display: block; margin: auto;"></p>
-->

# Project

## Setup

Follow the instructions in this [video](https://www.youtube.com/watch?v=IXSiYkP23zo&list=PL3MmuxUbc_hIUISrluw_A7wDSmfOhErJK)
to prepare the environment or follow the steps 1 and 2 below.

### Step 1: Create an AWS Account

Go to [AWS Management Console](https://aws.amazon.com/console/), click on **Create an AWS Account** and follow steps.

Select your **Default Region** (mine is `Canada (Central) ca-central-1`).

### Step 2: Create a new instance

From your **AWS Console**, select **EC2** and then click on **Launch instance**.

Create a new instance with the name **mlops-zoomcamp**.

![MLOps](images/s01.png)

Select:

* **Amazon Machine Image (AMI)**: Ubuntu Server 22.04 LTS (HVM), SSD Volume Type
* **Architecture**: 64-bit (x86)

![MLOps](images/s02.png)

Choose **Instance type**: t2.xlarge.

![MLOps](images/s03.png)

Click on **Create new key pair** with:

* **Key pair name**: razer
* **Key pair type**: RSA
* **Private key file format**: .pem

![MLOps](images/s04.png)

Click on **Create key pair** button, than move the downloaded `razer.pem`  file to the `~/.ssh` folder on your local machine.

Increase **Configure storage** to 30 Gb.

![MLOps](images/s05.png)

Finally, click the **Launch instance** button.

You should see something like this.

![MLOps](images/s06.png)

Take note of the **Public IPv4 address** (mine is `99.79.47.77`).

### Step 3: Connect local machine to the EC2 instance

Connect to this instance with the following commands.
Don't forget to replace the public IP with your own (mine is `99.79.47.77`).

```bash
$ chmod 400 ~/.ssh/razer.pem 
$ ssh -i ~/.ssh/razer.pem ubuntu@99.79.47.77
```

You should see this.

![MLOps](images/s07.png)

We are now connected to the remote service.

Enter `logout` to close the connection.

```bash
$ logout
```

You don't need to run the previous command every time. Just create a config file `~/.ssh/config` like this.

```bash
Host mlops-zoomcamp
    HostName 99.79.47.77
    User ubuntu
    IdentityFile ~/.ssh/razer.pem
    StrictHostKeyChecking no
```

Now, we can connect to our instance with this command.

```bash
# To connect to our instance. 
$ ssh mlops-zoomcamp
# To exit SSH connection.
$ logout
```

Note that every time we stop and restart the instance, we will have to change the public IP address.

### Step 4: Install required packages on the instance

Run the folowing commands on your instance to install MiniConda, Docker and Docker Compose.

```bash
$ sudo apt update
$ sudo apt install make
$ git clone https://github.com/boisalai/mlops-zoomcamp-project.git
$ cd mlops-zoomcamp-project
$ make init
```

Log out (with `logout` command) and log back (with `ssh mlops-zoomcamp` command) in so that your group membership is re-evaluated.

Run the following command on your instance and docker should work fine.

```bash
$ docker run hello-world
``` 

### Step 5: Connect Visual Studio Code to your instance

Now, we want access to this remote computer from our Visual Studio Code (VS Code).

Open VS Code from your local machine. 
In VS Code, find and install the **Remote - SSH** extension. 
Then go to the **Command Palette** (`Shift+Cmd+P`), select **Remote-SSH: Connect to Host…**​, 
select the configured SSH host `mlops-zoomcamp` and 
open `mlops-zoomcamp-project` folder.

We should see this.

![s08](images/s08.png)

### Step 6: Use Jupyter Notebook from remote machine

On the remote instance, run the following commands.

```bash
$ cd ~/mlops-zoomcamp-project/notebooks
$ jupyter notebook
```

In VS Code, open terminal, select **PORTS**, open the port `8888`.

![MLOps](images/s11.png)

Now, if we go to http://localhost:8888/tree, we should see that jupyter notebook is alive.

# Je suis rendu ici...







```bash
# Configure your AWS acoount
aws configure
# Create key pair to connect AWS
aws ec2 create-key-pair --region eu-central-1 --key-name mlops --query 'KeyMaterial' --output text > ~/.ssh/mlops.pem
```





```bash
$ pip install -U pip --upgrade pip
$ pip install pipenv
$ git clone https://github.com/boisalai/mlops-zoomcamp-project.git
$ cd mlops-zoomcamp-project
```

Install from Pipfile and activate the Pipenv shell:

```bash
$ pipenv install
$ pipenv shell
$ python --version
Python 3.9.17
```

Connect the environment to a kernel and start jupyter:

```bash
$ python -m ipykernel install --user --display-name pipenv_test --name pipenv_test
$ jupyter notebook
```