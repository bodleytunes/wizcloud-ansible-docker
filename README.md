### How to run

* create ed25519 ssh key and copy pubkey to github

* pass the argument in of the ed25519 key location when running docker-compose


`docker-compose build --build-arg SSH_PRIVATE_KEY="$(cat ~/.ssh/id_ed25519)";`

or all in one (requires vault password as an argument)

`docker-compose build --build-arg SSH_PRIVATE_KEY="$(cat ~/.ssh/id_ed25519)" && docker-compose up`

