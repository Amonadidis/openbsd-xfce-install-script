#!/bin/ksh

echo "Enter a package mirror path or press enter for deafult: [http://ftp.openbsd.org/pub/OpenBSD]"
read packagepath
if [[ -z "$packagepath" ]] ;then
  echo "Set package path to: http://ftp.openbsd.org/pub/OpenBSD"
  echo "http://ftp.openbsd.org/pub/OpenBSD" >> /etc/installurl
else
  echo "Set package path to: $packagepath"
  echo "$packagepath" >> /etc/installurl
fi

echo "Do you want to install xfce extras (y/n)?"
read extras
if [ "$extras" != "${extras#[Yy]}" ] ;then
    echo "Add packages: xfce, xfce-extras, consolekit2, slim, slim-themes"
    pkg_add xfce xfce-extras consolekit2 slim slim-themes
else
    echo "Add packages: xfce, consolekit2, slim, slim-themes"
    pkg_add xfce consolekit2 slim slim-themes
fi

echo "Do you want to install paper gtk theme and paper icon theme (y/n)?"
read paper
if [ "$paper" != "${paper#[Yy]}" ] ;then
    echo "Add packages: paper-gtk-theme paper-icon-theme"
    pkg_add paper-gtk-theme paper-icon-theme
fi

echo "Enter a username to configure the /home/*username*/.xinitrc file:"
read homeuser

touch /etc/rc.conf.local /etc/rc.local /root/.xinitrc /home/$homeuser/.xinitrc

echo "Configure /root/.xinitrc and /home/$homeuser/.xinitrc."
echo "exec /usr/local/bin/ck-launch-session /usr/local/bin/startxfce4" >> /root/.xinitrc
echo "exec /usr/local/bin/ck-launch-session /usr/local/bin/startxfce4" >> /home/$homeuser/.xinitrc

echo "Configure /etc/rc.conf.local and /etc/rc.local."
echo 'pkg_scripts="messagebus avahi_daemon"' >> /etc/rc.conf.local
echo "/etc/rc.d/slim start" >> /etc/rc.local

echo "Change slim default theme to openbsd simple theme."
sed -i 's/current_theme       default/current_theme       openbsd-simple/g' /etc/slim.conf

cho "Do you want to reboot (y/n)?"
read restart
if [ "$restart" != "${restart#[Yy]}" ] ;then
    echo "Start system reboot."
    reboot
fi
