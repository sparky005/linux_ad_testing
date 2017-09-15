# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
config.vm.define "centos" do |centos|
  config.vm.provider :virtualbox do |vb|
    vb.gui = false
    vb.memory = 512
    vb.cpus = 2
  end

  centos.vm.box = "centos/7"
  centos.vm.hostname = "vagrant-awx-test"
  centos.vm.network "private_network", ip: "192.168.56.5",
    virtualbox__intnet: true
  centos.vm.network "public_network"
  centos.vm.provision "shell", path: "scripts/setup.sh"
end
    config.vm.define "windows-domain-controller" do |dc|
    dc.vm.box = "windows-2016-amd64"
    dc.vm.hostname = "dc"

    # use the plaintext WinRM transport and force it to use basic authentication.
    # NB this is needed because the default negotiate transport stops working
    #    after the domain controller is installed.
    #    see https://groups.google.com/forum/#!topic/vagrant-up/sZantuCM0q4
    dc.winrm.transport = :plaintext
    dc.winrm.basic_auth_only = true

    dc.vm.provider :virtualbox do |v, override|
        v.linked_clone = true
        v.cpus = 2
        v.memory = 2048
        v.customize ["modifyvm", :id, "--vram", 64]
        v.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
        v.customize ["storageattach", :id,
                        "--storagectl", "IDE Controller",
                        "--device", "0",
                        "--port", "1",
                        "--type", "dvddrive",
                        "--medium", "emptydrive"]
    end

    dc.vm.network "private_network", ip: "192.168.56.2",
        virtualbox__intnet: true
    dc.vm.network "public_network"

    dc.vm.provision "shell", inline: "Uninstall-WindowsFeature Windows-Defender-Features" # because defender slows things down a lot.
    dc.vm.provision "reload"
    dc.vm.provision "shell", inline: "$env:chocolateyVersion='0.10.5'; iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex", name: "Install Chocolatey"
    dc.vm.provision "shell", path: "provision/ps.ps1", args: "provision-base.ps1"
    dc.vm.provision "reload"
    dc.vm.provision "shell", path: "provision/ps.ps1", args: "domain-controller.ps1"
    dc.vm.provision "reload"
    dc.vm.provision "shell", path: "provision/ps.ps1", args: "domain-controller-configure.ps1"
    dc.vm.provision "shell", path: "provision/ps.ps1", args: "ad-explorer.ps1"
    dc.vm.provision "shell", path: "provision/ps.ps1", args: "ca.ps1"
    dc.vm.provision "reload"
    dc.vm.provision "shell", path: "provision/ps.ps1", args: "summary.ps1"
end


end
