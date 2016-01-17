# symmetrical-journey
Deploy [goapp](https://github.com/askoudros/goapp) with vagrant, github and chef_zero.

## Prerequisites
Install [Vagrant](https://www.vagrantup.com/downloads.html)

### Tested On
 - Vagrant 1.7.4
 - Vagrant 1.8.1

## Begin
    clone this repo git@github.com:askoudros/symmetrical-journey.git
    execute ./vagrant_init

The script will take about 3-4 minutes to create all three virtual machines. Once the provision is complete it will query localhost:8484 to test the reverse proxy setup. The Vagrantfile has more details on port forwarding.

## How it works
I created two chef roles to build this environment a web role to do loadbalancing and a app role to manage the application. I created a custom cookbook called goapp to manage the application and custom nginx configuration. More details in the respective places.

### Web Role
Uses nginx::default and goapp::nginx to setup the node.

### App Role
Uses golang cookbook and goapp::default to setup the node and to manage deploymentw for the application it uses chefs deploy_revision.

### Vagrant
The vagrant configuration builds each server using the chef_zero provisioner.

### End 
    execute ./vagrant_destroy

