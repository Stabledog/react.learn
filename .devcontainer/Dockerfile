ARG vscode_uid=1000

# See the 'make-base-image-*.sh' scripts to answer 'where does this devimage come from?'
FROM react-devimage

RUN apt update && apt-get install -y sudo curl locales python3.10
RUN locale-gen en_US.UTF-8

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh > /root/nvm-install.sh && bash /root/nvm-install.sh

RUN apt-get install -y vim git bash-completion

RUN curl -L -o- https://github.com/jgm/pandoc/releases/download/2.18/pandoc-2.18-1-amd64.deb > /tmp/pandoc.deb
RUN sudo dpkg -i /tmp/pandoc.deb

COPY ./ /devcontainer/

RUN /usr/bin/bash -c "echo UID=$UID $(ls -al /) $(env)"
RUN mkdir /projects && touch /.dockerenv


RUN /devcontainer/bin/user-build.sh --uid ${vscode_uid}

RUN su - vscode /bin/bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh > /home/vscode/nvm-install.sh && bash /home/vscode/nvm-install.sh'

RUN su - vscode /bin/bash -c 'NVM_DIR=$HOME/.nvm; source $NVM_DIR/nvm.sh; nvm install 18 && npm install -g npm@8.13.1'

