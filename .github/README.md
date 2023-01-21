<!-- DAKU BANNER -->
<div align="center">
   <a href="#--------">
      <img src="assets/images/daku-banner.png" alt="Home Preview">
   </a>
</div>

<!-- TOC -->
<p align="center">
<a href="#snowflake-information"><img width="150px" style="padding: 0 10px;" src="assets/images/button-info.png"></a>
<a href="#hammer_and_wrench-setup"><img width="150px" style="padding: 0 10px;" src="assets/images/button-setup.png"></a>
</p>

<!-- RICE PREVIEW -->
<div align="center">
   <a href="#--------">
      <img src="assets/images/daku.png" alt="Rice Preview">
   </a>
</div>

<br>

# :snowflake: Information

Daku is a pen testing Linux configuration with dark colors.

> **Note**: This project is currently on development.

<div>
<img src="https://raw.githubusercontent.com/awesomeWM/apidoc/gh-pages/images/AUTOGEN_wibox_logo_logo_and_name.svg" align=right />

<table align=left><tr><td>
<b>- Operating System: </b><br />
<b>- Display Manager: </b><br />
<b>- Window Manager: </b><br />
<b>- Application Launcher: </b><br />
<b>- Compositor: </b><br />
<b>- Terminal: </b><br />
<b>- Shell: </b><br />
<b>- Editor: </b><br />
<b>- Audio: </b><br />
<b>- Wallpaper: </b><br />
</table>

<table><tr><td>
<a href="https://www.kali.org/">Kali Linux</a><br />
<a href="https://github.com/canonical/lightdm">LightDM</a><br />
<a href="https://awesomewm.org">AwesomeWM</a><br />
<a href="https://github.com/davatorium/rofi">Rofi</a><br />
<a href="https://github.com/yshui/picom">Picom</a><br />
<a href="https://github.com/kovidgoyal/kitty">Kitty</a><br />
<a href="https://www.zsh.org">Zsh</a><br />
<a href="https://code.visualstudio.com/">VSCode</a><br />
<a href="https://www.freedesktop.org/wiki/Software/PulseAudio/Download/">Pulseaudio</a><br />
<a href="https://github.com/derf/feh">Feh</a><br />
</table>
</div>

# :hammer_and_wrench: Setup

Clone or download the project and navigate into it:

```
cd ~; git clone https://github.com/pwnlog/Daku && cd Daku && chmod +x install.sh
```

> **Warning**: If you're copying these files from a Windows system do make sure that is formatted for Unix:

```
find . -type f -print0 | xargs -0 dos2unix
```

Install Daku using the automated installation script:

```
./install.sh
```

> **Note**: This script has only been tested in Kali Linux 2022.4.

Reboot the system:

```
reboot
```

Select `awesome` as your window manager and log in:

![lightdm-awesome](assets/images/lightdm-awesome.png)

Congratulations, now you have Daku installed in your system:

![daku](assets/images/daku-welcome.png)

# :hearts: Development

While this configuration is pretty awesome, it's still far from over.

Thanks for viewing this project,<br>
~ pwnlog =)