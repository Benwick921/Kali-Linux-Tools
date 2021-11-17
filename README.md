# Kali-Linux-Tools
My personal set of Kali Linux tools installer

Donwnload the file and run with sudo.

```
sudo ./install-my-software.sh [options] [userName]
```

```
sudo ./install-my-software.sh -i benwick
```

```
sudo ./install-my-software.sh -a benwick
```

# .bashrc
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
