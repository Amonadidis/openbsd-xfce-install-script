# openbsd-xfce-install-script
The script installs and configures xfce, slim, slim-themes and consolekit2 on a freshly installed OpenBSD 6.3.
The installation of xfce-extras, paper-gtk-theme and paper-icon-theme is optional.
## Usage
Copy the script via **scp** to the OpenBSD machine.
```zsh
# scp xfce-install.sh root@openbsdmachine:/root/
```
Run the script on the OpenBSD machine and remove it at the end.
There is an option to use a different package mirror.
Go to https://www.openbsd.org/ftp.html and choose the URL you want and enter the URL.
```zsh
# cd /root/
# ./xfce-install.sh
# rm xfce-install.sh
```
