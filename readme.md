# iptables-boilerplate
rock solid default firewall-rules for webhosts

## What is this?
iptables-boilerplate is a set of predefined firewall rules that are typically used on "webhosts".
its not a set of rules, designed to secure your home or office-network or to setup a router or gatweay.
think of "lamp"-servers.

#### iptables-boilerplate is tested on
* Debian 6.0 / Squeeze (oldstable)
* Debian 7.0 / Wheezy (stable)
* Debian 8.0 / Jessie (testing)
* Ubuntu 10.04 LTS / Lucid
* Ubuntu 12.04 LTS / Precise
* Ubuntu 13.10 / Raring
* Ubuntu 14.04 LTS / Trusty

we will support every LTS (Ubuntu) and stable (Debian) version.

#### Features
* rock solid defaults
* easy extendable
* one-line opening ports
* one line whitelisting ips
* one line blacklisting ips
* extensively documented (inline comments)

## Installation

### Easy Install
On Ubuntu and Debain you can use `make` to install or uninstall.

Make sure `make` is installed:

    sudo apt-get install make

And follow these steps to install:

    git clone git://github.com/gagomap/iptables-boilerplate.git
    cd iptables-boilerplate
    sudo make
    sudo reboot

Must reboot to install ipset and blacklist

To uninstall run:

    sudo make uninstall

### On other systems 
View README at: 
```bash
https://github.com/bmaeser/iptables-boilerplate
```

## Configuration
View README at: 
```bash
https://github.com/bmaeser/iptables-boilerplate
```

## Usage
If you updated your runlevels, the firewall starts every time you boot your system.
However, you can manually start/stop/restart, e.g. to update changed settings.

    /etc/init.d/firewall (start|stop|restart|reload|force-reload|status)

* start: starts the firewall
* stop: stops the firewall
* restart, reload, force-reload: restarts the firewall (all three the same)
* status: print out the status of the firewall, shows all entries in iptables
* version: print out the version of iptables-boilerplate

## How to contribute
fork + hack + pull request please :-)

thx

## From gagomap: 
Adding auto install Ipset and my blacklist. Blacklist will auto update everyday (using /etc/crontab). 

```bash
https://github.com/gagomap/install_ipset
https://github.com/gagomap/ipset-blacklist
```

Support fail2ban and ddos-flate at boot.
Link:

```bash
https://github.com/jgmdev/ddos-deflate
```

## Licence
The MIT License (MIT)
Copyright © Bernhard Mäser(http://bmaeser.io) and contributors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the “Software”), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
