### How to run

* create ed25519 ssh key and copy pubkey to github

* pass the argument in of the ed25519 key location when running docker-compose


`docker-compose build --build-arg SSH_PRIVATE_KEY="$(cat ~/.ssh/id_ed25519)";`

or all in one (requires vault password as an argument)

`docker-compose build --build-arg SSH_PRIVATE_KEY="$(cat ~/.ssh/id_ed25519)" && docker-compose up`

to force clone every run (pass in random dummy variable at the point of git clone)

`docker-compose build --build-arg SSH_PRIVATE_KEY="$(cat ~/.ssh/id_ed25519)" --build-arg CACHEBUST=$(date +%s)  && docker-compose up`



##### Extra tidbits of info:
###### How to tag and push to harbor registry

###### Insecure registry (not for prod)
/etc/docker/daemon.json
```
{
  "insecure-registries" : ["reg.wizznet.co.uk:80"]
}
```
Restart docker service
`systemctl restart docker`
Login
`docker login -u jon reg.wizznet.co.uk:80`


###### Tag
`docker tag reg.wizznet.co.uk:80/wizznet/wizcloud-ansible-deployer reg.wizznet.co.uk:80/wizznet/wizcloud-ansible-deployer:v1.0.0`

###### Push
`docker push reg.wizznet.co.uk:80/wizznet/wizcloud-ansible-deployer:v1.0.0`

###### Push and be tagged as latest
`docker push reg.wizznet.co.uk:80/wizznet/wizcloud-ansible-deployer`

###### docker-compose push
`docker-compose push`