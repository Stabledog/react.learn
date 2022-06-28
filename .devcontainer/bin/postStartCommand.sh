#!/bin/bash
# postStartCommand.sh

echo postStartCommand:
echo "USER=${USER}"
echo "HOST_USER=${HOST_USER}"
echo "PWD=$(pwd -P)"
echo "UID=$UID"
echo "Envronment follows:"
env

[[ -d /projects ]] && ln -sf /projects ~/

[[ -d /host_home/bin ]] && ln -sf /host_home/bin ~/bin

# Append our shell init stuff:
grep -Eq 'host_home' ~/.bashrc || {
    cat >> ~/.bashrc <<-EOF
    [[ -f \${HOME}/bin/bashrc-common ]] && source \${HOME}/bin/bashrc-common # Added by postStartCommand.sh
EOF
}

[[ -f /host_home/.local/bin/cdpp/setup.sh ]] && {
    bash /host_home/.local/bin/cdpp/setup.sh
    echo 'alias d=dirs' >> ~/.cdpprc
}
ln -sf /workspace/.devcontainer/tox-index ~/.tox-index

[[ -f /host_home/.local/bin/localhist/setup.sh ]] && bash /host_home/.local/bin/localhist/setup.sh

[[ -f /host_home/bin/inputrc ]] && ln -sf /host_home/bin/inputrc ~/.inputrc

[[ -d /host_home/.vim ]] && ln -sf /host_home/.vim ~/
mkdir -p ~/.vimtmp


