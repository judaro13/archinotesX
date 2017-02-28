https://github.com/dcos/dcos-vagrant/tree/v0.7.0

# Archlinux Local Instalation
### Default System Installs

Is needed in your system
  - Git
  - Mysqldb
  - Postgresql
  - Vagrant
  - docker and docker-compose

Last version of
  - net-tools
  - virtualbox
  - virtualbox-guest-iso

Can be installed with pacman command

### Install DCOS Local on vagrant
Install vagrant from git repository
```sh
$ git clone https://github.com/dcos/dcos-vagrant
$ cd dcos-vagrant
$ cp VagrantConfig-1m-1a-1p.yaml VagrantConfig.yaml
```
download DCOS on the main dir of dcos-vagrant
```sh
$ curl -O https://downloads.dcos.io/dcos/stable/dcos_generate_config.sh
```

Install vagrant-hostmanager plugin
```sh
$ vagrant plugin install vagrant-hostmanager
```
Edit the used memory at VagrantConfig.yaml or it will use a lot of memory and you will get frozen
Edit etc/config-1.8.yaml adding
> oauth_enabled: false

Start cluster with(this will take a while)
```sh
$ vagrant up
```
Through to the browser go to http://m1.dcos/ and check

### Install dcos client
Download the dcos client
```sh
$ curl -O https://downloads.dcos.io/binaries/cli/linux/x86-64/dcos-1.8/dcos
$ sudo mv dcos /usr/local/bin &&
$ sudo chmod +x /usr/local/bin/dcos
```
Create an alias for easy usage adding to your bashrc or bashprofile file at your home
> alias dcos='/usr/local/bin/dcos'

Apply changes with
```sh
$ source .bashrc
```
Point the CLI to your dcos master node (in our local)
```sh
$ dcos config set core.dcos_url http://m1.dcos
```
Remember:
master - Master node that runs the DC/OS core components (e.g. m1)
agent-private - Agent node that runs the Mesos agent with the * role (e.g. a1)
agent-public - Agent node that runs the Mesos agent with the slave_public role (e.g. p1)
boot - Bootstrap node that runs the installer (e.g. boot)

Important: The CLI must be installed on a system that is external to your DC/OS cluster.

### Install kafka

[sudo] pip install virtualenv

dcos package install --package-version=0.9.4.0 kafka --options=kafka-minimal.json

https://github.com/mesosphere/dcos-kafka-service/blob/master/docs/install-and-customize.md
