# 1. Update OS and install dependencies
sudo yum update -y
sudo yum install -y git curl tar gzip
sudo dnf install libicu -y

# 2. Create directory
mkdir actions-runner && cd actions-runner

# 3. Download runner
curl -o actions-runner-linux-x64-2.336.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.336.0/actions-runner-linux-x64-2.336.0.tar.gz
tar xzf ./actions-runner-linux-x64-2.336.0.tar.gz

# 4. Configure runner (from GitHub UI)
./config.sh --url https://github.com/CloudTechDevOps/github-actions-tf --token BDB5WAUDP46LWV7D4GSS6KTKOB4G2 --labels amazonlinux,dev --name ec2-runner

# 5. Start runner
./run.sh 

# 6. Optional: install as service
sudo ./svc.sh install
sudo ./svc.sh start



#Note: to check inside te ec2 by runing this command ps -ef | grep Runner.Listener
