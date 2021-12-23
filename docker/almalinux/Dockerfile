FROM almalinux:latest
RUN dnf -y install git epel-release
RUN dnf -y install ansible
WORKDIR "/root"
RUN git clone --recurse-submodules https://github.com/noobient/killinuxfloor.git
WORKDIR "/root/killinuxfloor"
#ENTRYPOINT ["ansible-playbook"]
