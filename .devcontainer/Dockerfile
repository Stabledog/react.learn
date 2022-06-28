ARG vscode_uid=1000

# See the 'make-base-image-*.sh' scripts to answer 'where does this devimage come from?'
FROM react-devimage

RUN apt-get update && apt-get install -y curl python3.10


RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh > /root/nvm-install.sh && bash /root/nvm-install.sh

RUN apt-get install -y vim git bash-completion

#RUN curl -L -o- https://github.com/jgm/pandoc/releases/download/2.18/pandoc-2.18-1-amd64.deb > /tmp/pandoc.deb
#RUN sudo dpkg -i /tmp/pandoc.deb

COPY ./ /devcontainer/

RUN /usr/bin/bash -c "echo UID=$UID $(ls -al /) $(env)"
RUN mkdir /projects && touch /.dockerenv


RUN /devcontainer/bin/user-build.sh --uid ${vscode_uid}

RUN su -p vscode /bin/bash -c 'unset NVM_DIR; HOME=/home/vscode; curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh > /home/vscode/nvm-install.sh && bash /home/vscode/nvm-install.sh'

RUN su -p vscode /bin/bash -c 'HOME=/home/vscode;NVM_DIR=$HOME/.nvm; source $NVM_DIR/nvm.sh; nvm install 16 && npm install -g npm@8.13.1'

