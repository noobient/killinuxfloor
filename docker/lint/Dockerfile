FROM fedora:37
RUN dnf -y install git python3-pip
RUN python3 -m pip install --user --no-warn-script-location ansible ansible-core ansible-lint
WORKDIR "/repo"
