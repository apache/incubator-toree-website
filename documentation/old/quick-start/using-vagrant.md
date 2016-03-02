---
layout: docpage
title: Using Vagrant
type: doc
section: quick-start
weight: 0
tagline: Apache Project !
---

A Vagrantfile is provided to easily setup a development environment. You will 
need to install [Virtualbox 4.3.12+](https://www.virtualbox.org/wiki/Downloads) 
and [Vagrant 1.6.2+](https://www.vagrantup.com/downloads.html).

First, make sure that the Vagrant box is up and running. From the root of the project, bring up the vagrant box:

    vagrant up
    
Second, set `USE_VAGRANT`

    export USE_VAGRANT=true

Third, run any `make` target as usual and it will run within vagrant. To quickly test the kernel, all you need to do is:

    make dev
    
This will build, package an start a notebook. You can now find the notebook frontend by going to http://192.168.44.44:8888.
