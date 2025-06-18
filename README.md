# Kali-Linux-Tools
![final result](https://github.com/Benwick921/Kali-Linux-Tools/blob/main/i3-desktop-1.png)
![final result](https://github.com/Benwick921/Kali-Linux-Tools/blob/main/i3-desktop-2.png)

My personal set of Kali Linux tools installer

Donwnload the file and run with sudo.

```
sudo ./install-desktop-envinronment.sh [options] [userName]
```

```
sudo ./install-desktop-environment.sh -i benwick
```

```
sudo ./install-desktop-environment.sh -a benwick
```

# .bashrc

*If you dont want to use bash you must mess with your shell's config file. Every shell has it own config file and its own syntax, modufying it yuo can get the same reslt.*

In order to make `.bashrc` execute correctly remove `.bash_profile` or `.bash_login` files. Check if the curret shell is **bash** because other shells might not use `.profile` config file. You can check your shell with the following commands:

```
echo $0
```

or

```
echo $SHELL
```

If the shell is not **bash** it can be changed with the command:

```
chsh -s /bin/bash
```

or

```
chsh -s /usr/bin/bash
```

Now upon opening a new window the file `.bashrc` will be executed, if not log-out and log-in to you computer account or completely reboot it.

# TO DO

1. What manual update to do after the installation (also explained at the end of the script onsce it finish to install everything)
2. Addedd polybat specific Nerd Font installation to prevent rendering issues
3. Add standard polybar installation (just in case, can be usefull to enrich the shell)
4. Update polybar installation code to download file in `/tmp` or `/usr/tmp`
5. Eventually delete the downloaded files
