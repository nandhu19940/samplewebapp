Learning phase of Devops.

Learned following concepts as part of CI/CD using Jenkins & Github
1. Created repository using github.
2. Installed Jenkins in docker container.
3. Up & running of Jenkins container in docker.
4. Accessed local host of the Jenkins UI by https://localhost:8080
5. Created build job using freestyle project and selected SCM by providing this github repo url, made this repo as public one to make sure it is accessible by easy means without tokens by Jenkins.
6. Selected build steps as "Execute shell" to use linux.
7. Now I took sample web application code from my local laptop & uploaded to this repo.

First in freestyle project I have added below echo command to see everything working as in order.

echo "Build Started"
echo "Checking files..."
echo "All checks passed"
echo "Build Successful"

Console output looks like this below if you have successfull run.

Started by user *********
Running as SYSTEM
Building in workspace /var/jenkins_home/workspace/nan-build-trail
[nan-build-trail] $ /bin/sh -xe /tmp/jenkins...sh
+ echo Build Started
Build Started
+ echo Checking files...
Checking files...
+ echo All checks passed
All checks passed
+ echo Build Successful
Build Successful
Finished: SUCCESS

Intentional Failure — Fail Fast Behaviour

Modified the build to read a file that doesn't exist (/tmp/mywebsite/index.html). Jenkins stopped
immediately at the failing step and never ran subsequent steps — this is Fail Fast behaviour.
+ cat /tmp/mywebsite/index.html
cat: /tmp/mywebsite/index.html: No such file or directory
Build step 'Execute shell' marked build as failure
Finished: FAILURE

Fixed Build — Creating File Before Reading It

mkdir -p /tmp/mywebsite
echo "<h1>My Website</h1>" > /tmp/mywebsite/index.html
cat /tmp/mywebsite/index.html
mkdir -p creates the directory quietly — the -p flag prevents errors if the directory already exists, which
matters on subsequent build runs.

The full picture:
index.html → GitHub Repo → Jenkins watches it → Build triggers automatically
   
