Vagrant Box fot testing DSA features
==================================

Puppet is used to setup and launch all the needed components to run the servioticy API


##Steps:
1. Place 'dsa.standalone.Ubuntu.14.04.3.tar.gz' in 'puppet/files/dsa'
2. run 'vagrant up **provision**' 
3. run 'vagrant ssh' to log into the machine
4. run 'vagrant halt' to stop the VM
5. run 'vagrant destroy' to delete the VM and its associated image


**IMPORTANT!**: provision needs to be run to get the kernel modules updated and installed on every boot
