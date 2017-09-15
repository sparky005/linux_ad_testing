Domain controller stuff lovingly stolen from https://github.com/rgl/windows-domain-controller-vagrant 

Instructions:
Use packer to build the centos image (so you dont have to rebuild awx every time)
```packer build centos7-awx.json```
Spin up the vagrant
```vagrant up ```
????
profit!
