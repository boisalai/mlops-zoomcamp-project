<div align="center">
<h1>Used Car Price Prediction (MLOps Zoomcamp Project)</h1>

![](images/banner.png)

<img alt="any text you like" src="https://img.shields.io/badge/python-3.9-blue">
<img alt="any text you like" src="https://img.shields.io/badge/code%20style-black-black">
<a href="https://opensource.org/license/mit/">
<img alt="any text you like" src="https://img.shields.io/badge/License-MIT-yellow">
</a>

[Problem](#problem-statement) | [Dataset](#dataset) | [Architecture](#architecture) | [Instructions](#instructions) | [Best practices](#best%20practices) | [License](#license) | [Acknowledgments](#acknowledgments)

</div>

## Problem Statement

This project is the capstone associated with [MLOps Zoomcamp](https://github.com/DataTalksClub/mlops-zoomcamp), and it will undergo peer review and scoring.

The ultimate objective of this project is to create an end-to-end machine learning solution encompassing feature engineering, 
training, validation, tracking, model deployment, hosting for production, and adhering to general engineering best practices. 

The problem at hand is to model the selling price of used cars based on the features given in the datasets. 
It will be used by the client to predict the price of a car of their choice. 

## Dataset

I used [Kaggle's used car data set](https://www.kaggle.com/datasets/austinreese/craigslist-carstrucks-data) 
because it had a variety of categorical and numerical data and allows you to explore different ways of dealing
with missing data.

The Kaggle dataset "austinreese/craigslist-carstrucks-data" is a collection of data on used car prices in Austin,
Texas, scraped from Craigslist. The dataset contains information on various car models, years, and prices, as well
as additional features such as mileage, fuel type, and transmission type.

Here's a breakdown of the dataset's structure:

* The dataset contains 426,880 entries and 26 columns.
* The variables include:
  * "id": a unique identifier for each car listing
  * "manufacturer": the make of the vehicle
  * "model": the model of the vehicle
  * "year": the year of the vehicle
  * "price": the listing price of the vehicle
  * "odometer": the mileage on the vehicle
  * "fuel": the fuel method of the vehicle (e.g., gasoline, diesel, hybrid)
  * "transmission": the car's transmission type (e.g., automatic, manual)
  * "posting_date": the listing date of the vehicle on Craiglist

## Design & flow architecture

The architecture below depicts the system design:

To complete

## Instructions

For those who don't want to replicate the project in AWS (Option 2), I've added a section to run part of the project on your local machine (Option 1).

### Option 1: Setting up for local environment

I assume Anaconda, Docker, Docker-Compose, Git and Make are already installed. Otherwise, see
[here](https://github.com/DataTalksClub/mlops-zoomcamp/blob/main/01-intro/README.md#12-environment-preparation)
and [here](https://www.youtube.com/watch?v=F6DZdvbRZQQ&list=PL3MmuxUbc_hIUISrluw_A7wDSmfOhErJK&index=52) for instructions.

**Note**: I have tested the codes on M1 MacBook Pro. It can certainly be run on Linux and Windows with small modifications.

#### Step 1: Clone the repository

```bash
$ git clone https://github.com/boisalai/mlops-zoomcamp-project.git
$ cd mlops-zoomcamp-project
```

#### Step 2: Create and activate a new environment

If prompted to proceed with the installation (`Proceed ([y]/n)?`), type `y`.

```bash
$ conda create -n mlops-project python=3.9
$ conda activate mlops-project
```

:warning: **Apple Silicon and the Library Incompatibility Issue**

I encountered compatibility problems between "arm64" and "x86_64" Python dependencies on my MacBook Pro M1. 
Certain dependencies are not compatible with the ARM architecture, necessitating the creation of an environment using x86 builds.

To resolve this issue, I followed the instructions provided [here](https://conda-forge.org/docs/user/tipsandtricks.html) 
in the section titled Installing Apple Intel Packages on Apple Silicon. For Apple Silicon M1 or M2, execute the following commands:

```bash
$ CONDA_SUBDIR=osx-64 conda create -n mlops-project python=3.9
$ conda activate mlops-project
$ conda config --env --set subdir osx-64
```

You can proceed to the next steps as normal.

#### Step 3: Install requirements

Install all package dependencies with this command.

```bash
$ pip install -r requirements.txt
```

#### Step 4: Authentication to use the Kaggle's public API

The `kaggle.json` file is typically used to authenticate API requests to the Kaggle service. 
It contains the necessary credentials for the Kaggle API, allowing you to interact with Kaggle datasets, competitions, and other 
resources programmatically.

Navigate to https://www.kaggle.com. Go to the [Account tab of your user profile](https://www.kaggle.com/me/account) and select Create API Token. 
This will trigger the download of `kaggle.json`, a file containing your API credentials.

Move the `kaggle.json` file to one of these folders: `~/downloads/kaggle.json`, `~/.kaggle/kaggle.json` or `./kaggle.json`. 

The script code will look for the `kaggle.json` file to set the environment variables.

#### Step 5: Start Prefect

Start a local Prefect server by running the following.

```bash
$ prefect server start
```

You should see this.

```txt
 ___ ___ ___ ___ ___ ___ _____ 
| _ \ _ \ __| __| __/ __|_   _| 
|  _/   / _|| _|| _| (__  | |  
|_| |_|_\___|_| |___\___| |_|  

Configure Prefect to communicate with the server with:

    prefect config set PREFECT_API_URL=http://127.0.0.1:4200/api

View the API reference documentation at http://127.0.0.1:4200/docs

Check out the dashboard at http://127.0.0.1:4200
```

Open another terminal window and run the following commands to set the Prefect API URL.

```bash
$ conda activate mlops-project
$ prefect config set PREFECT_API_URL=http://localhost:4200/api
```

You should see this.

```txt
Set 'PREFECT_API_URL' to 'http://127.0.0.1:4200/api'.
Updated profile 'default'.
```

Open the Prefect Dashboard at http://127.0.0.1:4200. You should see this.

![s11](images/s11.png)

#### Step 6: Start MLflow UI

```bash
$ mlflow ui --backend-store-uri sqlite:///mlflow.db
```

Then, open the MLflow UI on http://127.0.0.1:5000/. You should see this.

![s12](images/s12.png)

#### Step 7: Train the model

In another terminal, run the following commands.

```bash
$ conda activate mlops-project
$ make train
```

This step involves the following tasks:

* Downloading the data from Kaggle.
* Performing feature engineering on the data.
* Preparing the datasets for training.
* Training the model using multiple hyperparameter combinations.
* Re-training the model using the best hyperparameters.
* Registering the model in the MLFlow staging area.
* All of these tasks are orchestrated using Prefect.
  
You should see something like this.

<table>
    <tr>
        <td>
            <b>Terminal<b><br>
            <img src="images/s13.png">
        </td>
        <td>
            <b>Prefect Dashboard<b><br>
            <img src="images/s14.png">
        </td>
        <td>
            <b>Prefect Dashboard<b><br>
            <img src="images/s15.png">
        </td>
    </tr>
</table>

#### Step 8: Test

```bash 
$ make test
```

TODO

#### Step 9: Deploy the model

```bash
$ make deploy 
```

TODO

### Option 2: Setting up for AWS cloud environment

Follow the steps 1 to 7 below.

#### Step 1: Create an AWS Account

Go to [AWS Management Console](https://aws.amazon.com/console/), click on **Create an AWS Account** and follow steps.
Select your **Default Region** (mine is `Canada (Central) ca-central-1`).

Go to **IAM** section. From the **IAM dashboard**, under **IAM resources**, click on Users. 

![s16](images/s16.png)

Click on **Add users** button, enter `mlops-project-user` as **User name**, click on **Next** button.
Click on **Next** button again, then on the **Create user** button.
Select `mlops-project-user`.

<table>
    <tr>
        <td>
            <img src="images/s17.png">
        </td>
        <td>
            <img src="images/s18.png">
        </td>
    </tr>
</table>

![s19](images/s19.png)

Click on **Security credentials** tab, and click on **Create access key** button.
Select **Command Line interface (CLI)**, check confirmation below, click **Next**, than click on **Create access key** button.
Take note of your **Access key** and **Secret access key**.

<table>
    <tr>
        <td>
            <img src="images/s20.png">
        </td>
        <td>
            <img src="images/s21.png">
        </td>
    </tr>
</table>

![s22](images/s22.png)


**Note**: Once the Access Key ID and Secret Access Key are created, you can download and save them in a safe place and
if you lost them, you cannot recover (or) download them again. You will need to create a new API key. The best practice
is to keep changing the API access key and recreating it. The older your API keys are, the more prone they are to malicious
attacks. So you should keep updating the API key and don't use the same API key for a long time.


<!--
Est-ce nécessaire considérant que aws-cli sera configuré?
In your terminal, run these commands with your Access and Secret key.

```bash
export AWS_ACCESS_KEY_ID=AK************IEVXQ
export AWS_SECRET_ACCESS_KEY=gbaIbK*********************iwN0dGfS
```
-->


If you have difficulties to create your secret key,
see this [video](https://www.youtube.com/watch?v=zRcLgT7Qnio&list=PL3MmuxUbc_hIUISrluw_A7wDSmfOhErJK&index=49) between 1:37 and 2:46.

#### Step 2: Install and configure aws-cli

Download and install [aws-cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
as a tool to use on your terminal.

Check installation.

```bash
$ which aws
/usr/local/bin/aws
$ aws --version
aws-cli/2.13.0 Python/3.11.4 Darwin/22.5.0 exe/x86_64 prompt/off
```

Configure `aws-cli` with your AWS secret keys.

```bash
$ aws configure
AWS Access Key ID [None]: xxx
AWS Secret Access Key [None]: xxx
Default region name [ca-central-1]: 
Default output format [None]:
```

Verify aws config.

```bash
$ aws sts get-caller-identity
{
    "UserId": "AIDATI4DXUWBLLACBFUEU",
    "Account": "225225188738",
    "Arn": "arn:aws:iam::225225188738:user/mlops-project-user"
}
```

Write down your **Arn**, you will need it later to configure your AWS S3 bucket.

If you have difficulties to configure `aws-cli`,
see this [video](https://www.youtube.com/watch?v=zRcLgT7Qnio&list=PL3MmuxUbc_hIUISrluw_A7wDSmfOhErJK&index=49) between 3:48 and 4:07.

#### Step 3: Install Terraform

See [here](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) to install Terraform on macOS, Windows or Linux.

For Homebrew on OS X, run the following commands.

```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

To update to the latest version of Terraform, first update Homebrew.

```bash
$ brew update
$ brew upgrade hashicorp/tap/terraform
Warning: hashicorp/tap/terraform 1.5.3 already installed
```

Verify the installation.

```bash
$ terraform --version
Terraform v1.5.3
on darwin_arm64
```

<!--
Dois-je exporter mes variables d'environement?
https://registry.terraform.io/providers/-/aws/latest/docs#environment-variables
-->

#### Step 4: Create S3 Bucket

Before running Terraform, we need to create an S3 bucket manually because Terraform won't create an S3 bucket for us automatically.

Log in to your [AWS Console](https://aws.amazon.com/console/), then go to **S3** section. 
I suppose you don't have any S3 Buckets available. In order to create an S3 bucket, we will click on **Create bucket**.

Enter `tf-state-mlops-zoomcamp` as **Bucket name** and click on **Create bucket**.

<table>
    <tr>
        <td>
            <img src="images/s23.png">
        </td>
        <td>
            <img src="images/s24.png">
        </td>
    </tr>
</table>

If you have difficulties to create AWS S3 Bucket,
see this [video](https://www.youtube.com/watch?v=-6scXrFcPNk&list=PL3MmuxUbc_hIUISrluw_A7wDSmfOhErJK&index=53) between 5:17 and 7:40.

Now, click on the newly created bucket, select the **Permissions** tab, and click on **Edit** under **Bucket policy** section.

Add the following bucket policy:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "<your_user_arn>"
            },
            "Action": "s3:ListBucket",
            "Resource": "<your_bucket_arn>"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "<your_user_arn>"
            },
            "Action": [
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Resource": "<your_bucket_arn>/*"
        }
    ]
}
```

Make sure to replace `<your_user_arn>` and `<your_bucket_arn>` with the appropriate values. 
You can get your **user arn** from the command line by running `aws sts get-caller-identity`. See above.

Your **Bucket ARN** can be found in the **Properties** tab of the S3 bucket.

![s25](images/s25.png)

You should have something like this.

![s26](images/s26.png)

Click on **Save changes** button.

See [Configure S3 bucket as Terraform backend, Step-by-Step](https://www.golinuxcloud.com/configure-s3-bucket-as-terraform-backend/) for more information.

#### Step 5: Configure and run Terraform**

You need to change the region for your default region (mine is `ca-central-1`) in the following files:

* `infrastructure/main.tf`, at line 7.
* `infrastructure/variables.tf`, at line 3.
* `infrastructure/modules/ecr/variables.tf`, at line 25.

As Ubuntu cloud images are uploaded and registered on the Amazon EC2 cloud, they are referred to as AMI (Amazon Machine Images). 
Each AMI is a machine template from which you can instantiate new servers. Each AMI has its own unique ID. In order to launch an 
instance on the EC2 cloud, you first need to locate its ID.
This [page](http://cloud-images.ubuntu.com/locator/ec2/) helps you quickly locate an AMI ID.
Change `ami`.

![s28](images/s28.png)

Next, run the `terraform init` command to initialize a working directory containing Terraform configuration files.

```bash
cd infrastructure
terraform init
```

You should see this.

![s27](images/s27.png)

For explanation on initializing Terraform configuration,
see this [video](https://www.youtube.com/watch?v=-6scXrFcPNk&list=PL3MmuxUbc_hIUISrluw_A7wDSmfOhErJK&index=53) between 27:06 and 29:00.

Execute the command `terraform plan` to check what change would be made (you should always do it).

```bash
terraform plan -var-file=vars/stg.tfvars
```

For more explanation on `terraform plan`,
see this [video](https://www.youtube.com/watch?v=-6scXrFcPNk&list=PL3MmuxUbc_hIUISrluw_A7wDSmfOhErJK&index=53) between 29:00 and 31:30.

If you are happy with the changes it is claiming to make, then execute `terraform apply` to commit and start the build.

```bash
terraform apply
```

For more explanation on `terraform apply`,
see this [video](https://www.youtube.com/watch?v=-6scXrFcPNk&list=PL3MmuxUbc_hIUISrluw_A7wDSmfOhErJK&index=53) between 31:30 and 34:26.

If we no longer require resources that we have created using the configuration
mentioned in the `main.tf` file, we can use the `terraform destroy` command
to delete all those resources.

```bash
terraform destroy
```


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
scp -i ~/.ssh/razer.pem ~/downloads/kaggle.json ubuntu@ec2-3-99-132-220.ca-central-1.compute.amazonaws.com:~/mlops-zoomcamp-project
```

# Je suis rendu ici...







```bash
# Configure your AWS acoount
aws configure
# Create key pair to connect AWS
aws ec2 create-key-pair --region eu-central-1 --key-name mlops --query 'KeyMaterial' --output text > ~/.ssh/mlops.pem
```





```bash
pip install -U pip --upgrade pip
pip install pipenv
git clone https://github.com/boisalai/mlops-zoomcamp-project.git
cd mlops-zoomcamp-project
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
python -m ipykernel install --user --display-name pipenv_test --name pipenv_test
jupyter notebook
```

## License

The code and checkpoints are licensed under [MIT License](https://opensource.org/license/mit/).

## Acknowledgments

I am deeply grateful for the effort this fantastic group of individuals has invested in ensuring our understanding of the different facets of MLOps.

* Alexey Grigorev
* Cristian Martinez (MLflow)
* Jeff Hale (Prefect)
* Bianca Hoch (Prefect)
* Emeli Dral (Evidently)
* Sejal Vaidya (IaC and Terraform)
