# symmetrical-journey
Deploy [goapp](https://github.com/askoudros/goapp) with vagrant, github and chef_zero.

## Begin
    clone this repo git@github.com:askoudros/symmetrical-journey.git
    execute ./vagrant_init

The script will take about 3-4 minutes to create all three virtual machines. At the end it will query the web01.vagrant to test the reverse proxy is setup.

## How it works
I created two chef roles to build this environment a web role to do loadbalancing and a app role to manage the application. I created a custom cookbook called goapp to manage the application and custom nginx configuration.

### Web Role
Uses nginx cookbook and goapp::nginx to setup the node.

### App Role
Uses golang cookbook and goapp::default to setup the node and to deploy the application it uses chefs deploy_revision.

### Vagrant
The vagrant configuration builds each server using the chef provisioner.

### End 
    execute ./vagrant_destroy

