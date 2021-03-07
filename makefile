SSHKEY := $(shell cat ~/.ssh/id_ed25519)
DATE := $(shell date +%s)


start:
		docker-compose -f docker-compose up
 
 
build:
		docker-compose -f docker-compose.yml build --build-arg SSH_PRIVATE_KEY="$(SSHKEY)" --build-arg CACHEBUST="$(DATE)" 

