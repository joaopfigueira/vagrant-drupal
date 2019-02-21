# Vagrant Drupal

## Vagrant solution for a Drupal 8 installation on Debian 9

## Requirements
Before you use Vagrat Drupal, you need to have Virtualbox and Vagrant installed. It is possible to use other virtualization providers, like VMware, but only Virtualbox was used and tested.

Virtualbox and Vagrant are free and available for OS X, Linux and Windows. Download them from here:
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant ](https://www.vagrantup.com/downloads.html)

## Installation
You can install Vagrant Drupal using Git:
```
$ git clone https://github.com/joaopfigueira/vagrant-drupal.git
```
Or:
Go to https://github.com/joaopfigueira/vagrant-drupal and download the repository as a ZIP file.

## Usage
Boot up box:
```
$ vagrant up
```

SSH into box:
```
$ vagrant ssh
```

Shutdown box:
```
$ vagrant halt
```

Shutdown and delete box:
```
$ vagrant destroy
```
