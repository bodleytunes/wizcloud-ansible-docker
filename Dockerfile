# Multistage docker build
# this is our first build stage, it will not persist in the final image
FROM ubuntu as intermediate

# install git
RUN apt-get update && apt-get install -y git

# add credentials on build
ARG SSH_PRIVATE_KEY
RUN mkdir /root/.ssh/ && chmod 700 /root/.ssh/
RUN echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_ed25519 && chmod 600 /root/.ssh/id_ed25519

# keyscan otherwise host key checking fails
RUN ssh-keyscan -t rsa github.com > ~/.ssh/known_hosts
# dummy variable to force it to git clone every time.  This needs a re-think as doesn't sit right.
ARG CACHEBUST 
RUN git clone git@github.com:bodleytunes/wizzcloud-ansible-lab.git



# final resulting container, should not contain the ssh-key from above.
#FROM python:3.9-slim
FROM ubuntu:20.04

#RUN echo "${VAULT_PASSWORD}" > /root/.vault_password && chmod 600 /root/.vault_password
RUN apt-get update && apt-get install python3-pip openssh-client python3  -y

RUN pip3 install ansible

COPY --from=intermediate /wizzcloud-ansible-lab /wizzcloud-ansible-lab

WORKDIR /wizzcloud-ansible-lab

