<div align="center">
<h1>Used Car Price Prediction (MLOps Zoomcamp Project)</h1>

![](images/banner.png)
<img alt="any text you like" src="https://img.shields.io/badge/any%20text-you%20like-blue">

<img alt="any text you like" src="https://img.shields.io/badge/python-3.9-blue">
<img alt="any text you like" src="https://img.shields.io/badge/code%20style-black-black">
<a target="_blank" href="https://colab.research.google.com/github/GoogleCloudPlatform/vertex-ai-samples/blob/main/notebooks/official/model_monitoring/model_monitoring.ipynb">
  <img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open In Colab"/>
</a>


[TLDR](#TLDR) | [Problem](#Problem) | [Instructions](#Instructions) | [Best%20practices](#Best%20practices) [License](#License) | [Acknowledgments](#Acknowledgments)



</div>


## TLDR

## Problem

## Architecture

## Instructions

### Setting up for local environment

I assume Anaconda, Docker, Docker-Compose and make are already installed. Otherwise, see
[here](https://github.com/DataTalksClub/mlops-zoomcamp/blob/main/01-intro/README.md#12-environment-preparation)
and [here](https://www.youtube.com/watch?v=F6DZdvbRZQQ&list=PL3MmuxUbc_hIUISrluw_A7wDSmfOhErJK&index=52) for instructions.

**Note**: I have tested the codes on M1 MacBook Pro. It can certainly be run on Linux and Windows with small modifications.

1. Clone the repository, and navigate to the downloaded folder.


```bash
$ git clone https://github.com/boisalai/mlops-zoomcamp-project.git
$ cd mlops-zoomcamm-project
```

2. Create and activate a new environment named `mlops-project` with Python 3.9. If prompted to proceed with the installation (`Proceed ([y]/n)?`), type `y`.

Normally, we should run these commands:

```bash
$ conda create -n mlops-project python=3.9
$ conda activate mlops-project
```

But with my MacBook Pro M1, I have incompatibility issues between "arm64" and "x86_64" Python dependencies.
To solve this problem, I followed the instructions given 
[here](https://towardsdatascience.com/python-conda-environments-for-both-arm64-and-x86-64-on-m1-apple-silicon-147b943ffa55).

If you have an M1/M2 MacBook like me, you should add the following code to `~/.zshrc` or `~/.bashrc`.

```bash
## Create x86 conda environment
create_x86_conda_environment () {
  # example usage: create_x86_conda_environment myenv_x86 python=3.9
  CONDA_SUBDIR=osx-64 conda create -n $@
  conda activate $1
}
# Create ARM conda environment
create_ARM_conda_environment () {
# example usage: create_ARM_conda_environment myenv_x86 python=3.9
  CONDA_SUBDIR=osx-arm64 conda create -n $@
  conda activate $1
}
```

Then run `source ~/.zshrc` or `source ~/.bashrc` to apply the changes immediately without having to restart the shell.

Then, run the following commands.

```bash
$ create_x86_conda_environment mlops-project python=3.9
```

You can proceed to the following steps as normal.


<!-->
3. Install the prerequisites for building the psycopg2 package from source on Ubuntu:

```bash
sudo apt install libpq-dev python3-dev
```
-->

3. Install requirements for the environment.

```bash
$ pip install -r requirements.txt
```

4. Authenticate with Kaggle using `kaggle.json`.

The `kaggle.json` file is typically used to authenticate API requests to the Kaggle service. 
It contains the necessary credentials for the Kaggle API, allowing you to interact with Kaggle datasets, competitions, and other 
resources programmatically.

Navigate to https://www.kaggle.com. Then go to the [Account tab of your user profile](https://www.kaggle.com/me/account) and select Create API Token. 
This will trigger the download of `kaggle.json`, a file containing your API credentials.

Move the `kaggle.json` file to `~/downloads/kaggle.json`, `~/.kaggle/kaggle.json`, or `./kaggle.json`. 

The script code will look for the `kaggle.json` file to set the environment variables.

5. Start Prefect.

```bash
$ prefect orion start
```

In another terminal, run the following command.

```bash
$ cd mlops-zoomcamp-project
$ conda activate mlops-project
$ prefect config set PREFECT_API_URL=http://localhost:4200/api
```

Than, open the Prefect Orion UI on http://127.0.0.1:4200/.

6. Start MLflow UI.

```bash
$ mlflow ui --backend-store-uri sqlite:///mlflow.db
```

Then, open the MLflow UI on http://127.0.0.1:5000/. 

7. Train the model.

In fact, this step will download the data from Kaggle, feature enginerring it, prepare the datasets,
Train the model with multiple hyperparameter combinations, 
re-train the model with the best hyperparameters, 
register the model into MLFlow staging area.
All off this is orchestrated with Prefect.

In another terminal, run the following command.

```bash
$ cd mlops-zoomcamp-project
$ conda activate mlops-project
$ make train
```

You should see this.

8. Test the model.

```bash 
$ make test
```

9. Deploy the model to production

```bash
$ make deploy 
```




### Setting up for AWS cloud environment

Follow the steps 1 to 7 below.

#### Step 1: Create an AWS Account

Go to [AWS Management Console](https://aws.amazon.com/console/), click on **Create an AWS Account** and follow steps.

Select your **Default Region** (mine is `Canada (Central) ca-central-1`).

### Step 2: Create a new instance

From your **AWS Console**, select **EC2** and then click on **Launch instance**.

Create a new instance with the name **mlops-project**.

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
Than change the permissions to protect the file against the accidental overwriting, removing, renaming or moving files.

```bash
$ mv ~/downloads/razer.pem ~/.ssh
$ chmod 400 ~/.ssh/razer.pem 
```

Increase **Configure storage** to 30 GiB.

![MLOps](images/s05.png)

Finally, click the **Launch instance** button.

You should see something like this.

![MLOps](images/s06.png)

Take note of the **Public IPv4 address** (mine is `3.99.132.220`).

### Step 3: Connect local machine to the EC2 instance

Connect to this instance with the following commands.
Don't forget to replace the public IP with your own (mine is `3.99.132.220`).

```bash
$ ssh -i ~/.ssh/razer.pem ubuntu@3.99.132.220
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
Host mlops-project
    HostName 3.99.132.220
    User ubuntu
    IdentityFile ~/.ssh/razer.pem
    StrictHostKeyChecking no
```

Now, we can connect to our instance with this command.

```bash
# To connect to our instance. 
$ ssh mlops-project
```

Note that every time we stop and restart the instance, we will have to change the public IP address.

### Step 4: Install required packages on the instance

Run the folowing commands on your instance to install MiniConda, Docker and Docker Compose, 
and create a conda environment.

```bash
$ sudo apt update && sudo apt install make
$ git clone https://github.com/boisalai/mlops-zoomcamp-project.git
$ cd mlops-zoomcamp-project
$ make init
```

Log out (with `logout` command) and log back (with `ssh mlops-project` command) in so that your group membership is re-evaluated
and changes to take effect.

```bash
$ logout
Connection to 3.99.132.220 closed.
$ ssh mlops-project
``````

Run the following command on your instance and docker should work fine.

```bash
$ docker run hello-world
``` 

Run the following commands on your instance to activate the conda environment and install the required packages into it.

```bash
$ cd ~/mlops-zoomcamp-project
$ conda create -n mlops-project python==3.9
$ conda activate mlops-project
$ pip install -r requirements.txt
```

### Step 5: Connect Visual Studio Code to your instance

Now, we want access to this remote computer from our Visual Studio Code (VS Code).

Open VS Code from your local machine. 
In VS Code, find and install the **Remote - SSH** extension. 
Then go to the **Command Palette** (`Shift+Cmd+P`), 
select **Remote-SSH: Connect to Host**​, 
select the configured SSH host `mlops-project`,
open `mlops-zoomcamp-project` folder and click on **OK**.

We should see this.

![s08](images/s08.png)

### Step 6: Use Jupyter Notebook from remote machine

On your remote instance, run the following command to start Jupyter notebook.

```bash
$ conda activate mlops-project 
$ jupyter notebook
```

In VS Code connected to your instance, open a terminal.
From the menu, use the **Terminal > New Terminal** or **View > Terminal** menu commands.
Select **PORTS**, click on **Forward a Port** and open the port `8888`.

![s09](images/s09.png)

Copy and paste one of the URLs (I have http://localhost:8888/?token=c8de56fa...) to the web browser, 
you should see that Jupyter notebook is alive.

![s10](images/s10.png)

### Step 7: Authenticating with Kaggle using `kaggle.json`

With Jupyter, open the `notebooks/used-car-price-prediction.ipynb` notebook.

Navigate to https://www.kaggle.com. 
Then go to the [Account tab of your user profile](https://www.kaggle.com/me/account) and click on **Create New Token** button. 
This will trigger the download of `kaggle.json`, a file containing your API credentials.

You need to copy this key on your instance. 

To do so, drag the `kaggle.json` file you downloaded on your local machine 
to the `~/mlops-zoomcamp-project` in the VS Code connected to the instance.

Or just run the following command after changing the **Public IPv4 DNS** (mine is `ec2-3-99-132-220.ca-central-1.compute.amazonaws.com`).

```bash
$ scp -i ~/.ssh/razer.pem ~/downloads/kaggle.json ubuntu@ec2-3-99-132-220.ca-central-1.compute.amazonaws.com:~/mlops-zoomcamp-project
```

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

## License

The code and checkpoints are licensed under [MIT License](https://opensource.org/license/mit/).

## Acknowledgments

