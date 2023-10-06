echo "Updating and upgrading Server"
sudo apt-get update && sudo apt-get upgrade -y

echo "Downloading and Importing Nodesource GPG key"
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

echo "Create deb repository"
NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

echo "Choosing Version"
NODE_MAJOR=20

echo "updating and installing Node"
sudo apt-get update
sudo apt-get install nodejs -y

echo "Check Node Version"
node --version && npm --version

echo "Python is Next"
echo "Updating and Upgrading Server"
sudo apt update && sudo apt upgrade -y
