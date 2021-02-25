# this is our first build stage, it will not persist in the final image
FROM ubuntu as intermediate

# install git
RUN apt-get update && apt-get install -y git

# add credentials on build
ARG SSH_PRIVATE_KEY
RUN mkdir /root/.ssh/ && chmod 700 /root/.ssh/
RUN echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_ed25519 && chmod 600 /root/.ssh/id_ed25519
RUN ssh-keyscan -t rsa github.com > ~/.ssh/known_hosts
RUN git clone git@github.com:bodleytunes/wizzcloud-ansible-lab.git




FROM python:3.8-slim

RUN apt-get update && apt-get install python3-pip  -y

#COPY ./requirements.txt requirements.txt
RUN pip3 install ansible

COPY --from=intermediate /wizzcloud-ansible-lab /wizzcloud-ansible-lab

WORKDIR /wizzcloud-ansible-lab

#RUN ansible-playbook -i inventory.ini day0.yml