## Docker Server

Setup for a server hosting Docker service on Ubuntu 24.04 server freshly installed.

* * *

#### Change the user password

Change user password

```shell
passwd ${USER}
```

* * *

#### Prepare the environment

Configure APT sources

```shell
sudo add-apt-repository -y main && sudo add-apt-repository -y restricted && sudo add-apt-repository -y universe && sudo add-apt-repository -y multiverse
```

Keep system safe

```shell
sudo apt -y update && sudo apt -y upgrade && sudo apt -y dist-upgrade
sudo apt -y remove && sudo apt -y autoremove
sudo apt -y clean && sudo apt -y autoclean
```

Disable error reporting

```shell
sudo sed -i "s/enabled=1/enabled=0/" /etc/default/apport
```

Edit SSH settings

```shell
sudo sed -i "s/#Port 22/Port 49622/" /etc/ssh/sshd_config
sudo sed -i "s/#LoginGraceTime 2m/LoginGraceTime 2m/" /etc/ssh/sshd_config
sudo sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin no/" /etc/ssh/sshd_config
sudo sed -i "s/#StrictModes yes/StrictModes yes/" /etc/ssh/sshd_config
sudo systemctl restart sshd.service
```

Install prerequisite packages

```shell
sudo apt -y install apt-transport-https ca-certificates curl git make software-properties-common
```

Add the GPG key for the official Docker repository

```shell
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

Add the Docker repository to APT sources

```shell
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

Update the packages list

```shell
sudo apt -y update
```

Make sure you are about to install from the Docker repo instead of the default Ubuntu repo

```shell
apt-cache policy docker-ce
```

You’ll see output like this, although the version number for Docker may be different

```
docker-ce:
  Installed: (none)
  Candidate: 5:26.0.0-1~ubuntu.22.04~jammy
  Version table:
     5:26.0.0-1~ubuntu.22.04~jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:25.0.5-1~ubuntu.22.04~jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:25.0.4-1~ubuntu.22.04~jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:25.0.3-1~ubuntu.22.04~jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:25.0.2-1~ubuntu.22.04~jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:25.0.1-1~ubuntu.22.04~jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:25.0.0-1~ubuntu.22.04~jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:24.0.9-1~ubuntu.22.04~jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:24.0.8-1~ubuntu.22.04~jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:24.0.7-1~ubuntu.22.04~jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:24.0.6-1~ubuntu.22.04~jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:24.0.5-1~ubuntu.22.04~jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:24.0.4-1~ubuntu.22.04~jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:24.0.3-1~ubuntu.22.04~jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:24.0.2-1~ubuntu.22.04~jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:24.0.1-1~ubuntu.22.04~jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:24.0.0-1~ubuntu.22.04~jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:23.0.6-1~ubuntu.22.04~jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:23.0.5-1~ubuntu.22.04~jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:23.0.4-1~ubuntu.22.04~jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:23.0.3-1~ubuntu.22.04~jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:23.0.2-1~ubuntu.22.04~jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:23.0.1-1~ubuntu.22.04~jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:23.0.0-1~ubuntu.22.04~jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:20.10.24~3-0~ubuntu-jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:20.10.23~3-0~ubuntu-jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:20.10.22~3-0~ubuntu-jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:20.10.21~3-0~ubuntu-jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:20.10.20~3-0~ubuntu-jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:20.10.19~3-0~ubuntu-jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:20.10.18~3-0~ubuntu-jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:20.10.17~3-0~ubuntu-jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:20.10.16~3-0~ubuntu-jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:20.10.15~3-0~ubuntu-jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:20.10.14~3-0~ubuntu-jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:20.10.13~3-0~ubuntu-jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
```

Install Docker-CE

```shell
sudo apt -y install docker-ce docker-ce-cli docker-compose containerd.io
```

Docker should now be installed, the daemon started, and the process enabled to start on boot. Check that it’s running:

```shell
sudo systemctl status docker
```

The output should be similar to the following, showing that the service is active and running

```
● docker.service - Docker Application Container Engine
     Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2024-03-28 20:35:17 UTC; 26s ago
TriggeredBy: ● docker.socket
       Docs: https://docs.docker.com
   Main PID: 16525 (dockerd)
      Tasks: 10
     Memory: 29.1M
        CPU: 228ms
     CGroup: /system.slice/docker.service
             └─16525 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock

Mar 28 20:35:16 vps-0e937262 systemd[1]: Starting Docker Application Container Engine...
Mar 28 20:35:16 vps-0e937262 dockerd[16525]: time="2024-03-28T20:35:16.834939613Z" level=info msg="Starting up"
Mar 28 20:35:16 vps-0e937262 dockerd[16525]: time="2024-03-28T20:35:16.835714578Z" level=info msg="detected 127.0.0.53 nameserver, assuming systemd-resolved, so using resolv.conf: /run/systemd/re>
Mar 28 20:35:16 vps-0e937262 dockerd[16525]: time="2024-03-28T20:35:16.904785773Z" level=info msg="Loading containers: start."
Mar 28 20:35:17 vps-0e937262 dockerd[16525]: time="2024-03-28T20:35:17.131291057Z" level=info msg="Loading containers: done."
Mar 28 20:35:17 vps-0e937262 dockerd[16525]: time="2024-03-28T20:35:17.166051530Z" level=info msg="Docker daemon" commit=8b79278 containerd-snapshotter=false storage-driver=overlay2 version=26.0.0
Mar 28 20:35:17 vps-0e937262 dockerd[16525]: time="2024-03-28T20:35:17.166173949Z" level=info msg="Daemon has completed initialization"
Mar 28 20:35:17 vps-0e937262 dockerd[16525]: time="2024-03-28T20:35:17.188967870Z" level=info msg="API listen on /run/docker.sock"
Mar 28 20:35:17 vps-0e937262 systemd[1]: Started Docker Application Container Engine.
```

Add your username to the docker group

```shell
sudo usermod -aG docker ${USER}
```

To apply the new group membership, log out of the server and back in, or type the following

```shell
su - ${USER}
```

You will be prompted to enter your user’s password to continue. Confirm that your user is now added to the docker group by typing the following

```shell
groups
```

Reboot server

```shell
sudo reboot now
```

* * *

#### Automated Setup

If you prefer and in order to save time, you can use our deployment script which reproduces all the commands above.

```shell
cd /tmp/ && wget -O - https://raw.githubusercontent.com/neoslab/dockerserver/main/install.sh | bash
```

* * *

#### Conclusion

We can now uses Docker-CE to deploy our applications and scripts.