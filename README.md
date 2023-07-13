<!--
<p align="center" width="100%"><img src="assets/pic.png" alt="Pic" style="width: 50%;  display: block; margin: auto;"></p>
-->

# Project

## Setup

follow the instructions in this [video](https://www.youtube.com/watch?v=IXSiYkP23zo&list=PL3MmuxUbc_hIUISrluw_A7wDSmfOhErJK)
to prepare the environment or follow the steps 1 and 2 below.

### Step 1: Create an AWS Account

Go to [AWS Management Console](https://aws.amazon.com/console/), click on **Create an AWS Account** and follow steps.

Select your **Default Region** (mine is `Canada (Central) ca-central-1`).

From your **AWS Console**, select **EC2** and then click on **Launch instance**.

### Step 2: Create a new instance

Create a new instance `mlops-project` with **Ubuntu**, **64-bit (x86)** architecture.

Select **t2.xlarge** instance type.


Click on **Create new key pair**.

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