FROM fedora:latest
RUN dnf -y install git ansible
WORKDIR "/root"
RUN git clone https://github.com/noobient/killinuxfloor.git
WORKDIR "/root/killinuxfloor"
ENTRYPOINT ["ansible-playbook","install.yml"]
