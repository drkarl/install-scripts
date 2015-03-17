#Basic git configuration

# Set the environment variables or edit the screen before running
read -p "Git name: " GIT_USERNAME
read -p "Git mail: " GIT_USER_EMAIL

git config --global user.name $GIT_USERNAME
git config --global user.email $GIT_USER_EMAIL
