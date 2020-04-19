
Awesome WM Configuration
========================

Personal configuration for Awesome WM (Window Manager).

Installation
------------

To install, follow the steps:

1. Install dependencies. In Arch Linux, this would be:

   .. code:: bash

       sudo pacman --sync --refresh --noconfirm awesome lain xcompmgr pa-applet \
           network-manager-applet scrot blueman xfce4-power-manager xorg-xbacklight firefox

2. Clone repository into Awesome configuration folder:

   .. code:: bash

       git clone https://github.com/jonathf/awesome ~/.config/awesome

3. (Optional) Add LightDM and Slick-greeter. On Arch Linux:

   .. code:: bash

       sudo pacman --sync --refresh --noconfirm lightdm-slick-greeter
       sudo cp ~/.config/awesome/{background.png,slick-greeter.conf}
       /etc/lightdm
       sudo chmod 644 /etc/lightdm/{background.png,slick-greeter.conf}
