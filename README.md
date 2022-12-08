# CI/CD with Jenkins
This is a CI and CD Pipeline using Jenkins, in which inside using some other tools such as Terraform and Packer. The cloud provider used here is Amazon Web Services. 
<br>
## Note
This pipeline will run and clean up all the resources which created during the process in a single process. If you want not to clean the resources after build finished, you can remove some unnecessary code inside the jenkinsfile.

## Scenarios
---
1. When the pipeline starts the development environment, pipeline will inform the build process started through Slack notification, and continue to build an image of the application using Dockerfile.
2. After application successfully build, pipeline will archive the file of application and saved them inside the pipeline process number.
3. Next, the image which recently created will be pushed into docker repository, and here required login account of DockerHub.
4. Now, we try to run the container locally inside our development environment where the image retrieved from DockerHub, and remove the container once it's successfully deployed.
5. In this step, we will provide an AMI for ready-to-use which will be used later. In this AMI, every dependencies of local configuration will be set up in order to run the application, and this AMI will be used later to build an instance or server.
6. Next, we will validate and plan out the terraform configuration files in order to ensure everything is running well.
7. Now, Slack will send notification to ask our permission whether continue build our infrastructure/resources and deploy our application or to abort the pipeline. If any configuration error during the build process, we will remove the resources, thus the resource will not be in waste since it might charge an invoice.
8. In this step, after infrastructure and application are already being deployed, this will remove all of those right after being run successfully. This step could be removed, if you want to keep the infrastructure up.
9. In the last step, this will remove resource for AMI which created before. This step could be removed, if you to keep the AMI saved. After the last step finished, slack will inform us the build status of pipeline.
---
### **REMEMBER**
*Step 1-4 and Step 5-6 are running parallelly to reduce build time and also both are not depending one another. So, step 7 have to wait until parallel build has been finished before continued*
<br>

## Prerequisites
---
Here are some of tools required to be installed :
1. Jenkins [[How to install Jenkins on Ubuntu 22.04](https://www.digitalocean.com/community/tutorials/how-to-install-jenkins-on-ubuntu-22-04)]
2. Terraform [[How to install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)]
3. Packer [[How to install Packer](https://developer.hashicorp.com/packer/downloads?host=www.packer.io)]

Please reference to another article, if link above were not suitable or unavailable.
<br>
After Jenkins installed, we have to make sure some are following plugins already installed :
1. Docker plugin, Docker Pipeline, and Docker Commons Plugin
2. Amazon Web Services SDK :: All 
3. Global Slack Notifier Plugin and Slack Notification Plugin
4. PyEnv Pipeline

Next, we need to add some credentials :
1. Docker Hub Account (with Kind "Username with Password")
<br> Here is add username and password of our DockerHub Account.
2. Slack Token (with Kind "Secret Text")
<br> This credential is added to connect Jenkins and Slack.
3. AWS Account (with Kind "Username with Password")
<br> In this credential, we can use IAM User for username (access key) and password (secret access key).
4. AWS Access Key (with Kind "Secret Text")
<br> This access key could retrieved from IAM User.
5. AWS Secret Access Key (with Kind "Secret Text")
<br> This secret access key could retrieved from IAM User.

The name of credentials in this Jenkinsfile project : <br>
- Docker Hub Account -> DockerHub
- AWS Account -> AwsAccount
- AWS Access Key ID -> AWS_ACCESS_KEY_ID
- AWS Secret Access Key ID -> AWS_SECRET_ACCESS_KEY 

Here is quick steps to add credential in Jenkins : <br>
```
Manage Jenkins -> Manage Credentials -> System -> Global Credentials -> Add Credentials
```
<br>

Next, we need to configure slack in jenkins : <br>
```
Manage Jenkins -> Configure System -> Slack configuration
```
## How to run the project
---
### ***CAUTION, THIS PROJECT COULD MAKE AN INVOICE ON YOUR AWS ACCOUNT***
Make sure we already follow the prerequisites before. Now, let's jump into our project : 
<br>
```
1. Open Jenkins dashboard and click new item.
2. Next, we give a name for our project and choose it as pipeline project.
3. We can add a description.
4. Now, if we scroll down, we can found pipeline, and choose pipeline from SCM.
5. Next, choose SCM from git, then enter the URL of your GitHub repository, make sure your branch name that will be used to run.
6. Lastly, input the path directory which our jenkinsfile stored. In this project, jenkinsfile is stored in files directory, so it would be "files/Jenkinsfile".
```
<br>

Remember, jenkins is case sensitive, ensure our credentials name which mentioned before are written properly.