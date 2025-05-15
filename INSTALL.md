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
Setup the auto-deployment script (to be edited)

## Optional – Email Notifications 

You can configure your script to send an email to administrators every time a deployment happens using `mail` or `sendmail`.
