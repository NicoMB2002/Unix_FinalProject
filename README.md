# AutoDeploy-Server

![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg)

**AutoDeploy-Server** is a reliable auto-deployment system for Linux web servers.  
It automatically updates the live website every time a commit is pushed to the Git repository.

In addition to automated deployment, it monitors the server’s status to ensure consistent performance.  
The system supports:
- Automatic website deployment via Git
- Log generation
- Email notifications in case of backup failures

---

## Table of Contents

- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

---

## Usage
1. Clone the repository to your server
```
git clone https://github.com/your-username/AutoDeploy-Server.git
cd AutoDeploy-Server
```
2. Install the necessary dependencies
  Make sure you have ``bash``, ``git``, ``nginx`` and ``sendmail`` (or an equivalent mail service) installed.
  You can install them using your system's package manager if they are missing:
```
sudo apt update
sudo apt install git bash sendmail nginx 
```
3. Configure your project settings:
  Update the configuration files (coming soon) to match your server setup, including:
  - Git repository URL
  - Deployment directory
  - Email settings for notifications
4. Start the AutoDeploy server:
  Run the main deployment script (bash script will be provided soon) to begin
  monitoring the Git repository and automating deployments:
```
./autodeploy.sh
```

## Contributing


Steps:

Fork the repository.

Create a new branch:

```
git checkout -b feature-branch
```
Make any changes or additions you'd like to add.

Push your branch:

```
git push origin feature-branch
```
Open a Pull Request.

##  License
This project is licensed under the [Creative Commons Attribution-ShareAlike 4.0 International License (CC BY-SA 4.0)](https://creativecommons.org/licenses/by-sa/4.0/).
