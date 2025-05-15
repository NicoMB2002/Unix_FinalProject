# This is the Step-By-Step to recreate this Project:

## Requirements
- A VPS (e.g., from LunaNode, DigitalOcean, etc.)
- A domain name (e.g., autodeploy-server.xyz)
- A GitHub repository for your website
- Basic experience with Linux shell


## First
First research your prefered VPS (Virtual Private Server) for your needs. For this type of project a very basic server should suffice.
Once a VPS is acquired it will serve as the place where everything will run.
Once You set that up, you can go ahead and install Nginx, which is the server to deploy your website to the internet. Nginx can serve
static and dynamic content, handling requests from web browsers and other clients. The VPS will keep it running 24/7 and make sure
it's available to access by everyone.

1. Choose and set up your VPS.
2. SSH into your VPS and install Nginx:

```
sudo apt update
sudo apt install nginx
```

3. Configure your Nginx server block:

```
server {
    listen 80;
    server_name insertTheDomainHere;

    root /var/www/html;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

4. Restart Nginx to apply changes:

```
sudo systemctl restart nginx
```

## Second

Ensure your server is secure by creating a firewall for it.

We used UFW:
```
sudo apt install ufw
sudo ufw allow OpenSSH
sudo ufw allow 'Nginx Full'
sudo ufw enable
```

Check firewall status:

```
sudo ufw status
```

## Third
Purchase/Use a domain name from a domain registrar of your choice (e.g., Namecheap, gandi , Porkbun). Once purchased, configure the DNS settings to point to your VPS’s IP address. This allows your website to be accessible using your custom domain instead of just an IP address.

*If you're using a service like Cloudflare, you can also take advantage of free DNS management, CDN features, and basic DDoS protection.*

## Forth
Connect and enable Auto-Pulling from GitHub Using SSH

1. Install Git and SSH

```
sudo apt update
sudo apt install git
sudo apt install ssh
```

2. Generate SSH Key

```
ssh-keygen -t ed25519 -C "insert github email here"
```

- Press **Enter** to accept the default path
- Leave the passphrase **blank**

3. Add SSH Key to GitHub

```
cat ~/.ssh/id_ed25519.pub
```

- Copy the output.
- Go to GitHub, **Settings**, **SSH and GPG Keys** and then **New SSH Key**
- Paste your key

## Fifth
To setup the Auto-Deployment feature, Create the following script (e.g., `deploy.sh`)

```
#!/bin/bash

DEST_DIR="$HOME/Downloads"
REPO_DIR="$DEST_DIR/Auto-Deploy-Test"
SCRIPT_PATH="$(realpath "$0")"
LOG_FILE="DEBUG_LOG.txt"

# Clone or update the repository
if [ ! -d "$REPO_DIR/.git" ]; then
    git clone https://github.com/SharkenFunGithub/Auto-Deploy-Test.git "$REPO_DIR"
    cd "$REPO_DIR"
    git remote set-url origin git@github.com:SharkenFunGithub/Auto-Deploy-Test.git
    echo "$(date) Repository cloned and SSH remote set." >> "$LOG_FILE"
else
    cd "$REPO_DIR" || exit 1
    git remote set-url origin git@github.com:SharkenFunGithub/Auto-Deploy-Test.git
    echo "Running git pull..." >> "$LOG_FILE"
    git pull >> "$LOG_FILE" 2>&1
    echo "$(date) Repository pulled." >> "$LOG_FILE"
fi

echo "$(date) This Website has been regularly updated to the latest version" >> update_log.txt

read -p "Do you want to set this script to auto-run every 2 minutes? (y/n): " answer

if [[ "$answer" =~ ^[Yy]$ ]]; then
    CRON_JOB="*/2 * * * * /bin/bash $SCRIPT_PATH"
    if ! crontab -l 2>/dev/null | grep -F "$SCRIPT_PATH" >/dev/null; then
        (crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -
        echo "Cron job added to run every 2 minutes. Type 'crontab -e' to edit the schedule."
    else
        echo "Cron job already exists."
    fi
else
    echo "Automation skipped."
fi
```

Make it executable:

```
chmod +x deploy.sh
```

Run it manually once:

```
./deploy.sh
```


## Optional – Email Notifications 

You can configure your script to send an email to administrators every time a deployment happens using `mail` or `sendmail`.
