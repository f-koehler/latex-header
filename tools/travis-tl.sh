#!/bin/bash

if [[ -d ${HOME}/tl/bin/x86_64-linux ]]; then
    echo "directory \"${HOME}/tl/bin/x86_64-linux\" exists, prepending path ..."
    export PATH=${HOME}/tl/bin/x86_64-linux:${PATH}
fi

TLMGR=$(command -v tlmgr)
if [[ ! -z ${TLMGR} ]]; then
    echo "found local tlmgr \"${TLMGR}\", perform update ..."
    tlmgr update --all --self
    exit 0
fi

echo "local tlmgr is not present, perform minimal TeXLive install ..."

cd tools
[[ ! -e tl-installer.tar.gz ]] && wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz -O tl-installer.tar.gz
mkdir -p tl-installer ~/tl/temp
tar xzf tl-installer.tar.gz --strip-components=1 -C tl-installer
cd tl-installer
cat > travis.profile << EOF
selected_scheme scheme-minimal
TEXDIR ${HOME}/tl
TEXMFCONFIG ${HOME}/.texlive2016/texmf-config
TEXMFHOME ${HOME}/texmf
TEXMFLOCAL ${HOME}/tl/texmf-local
TEXMFSYSCONFIG ${HOME}/tl/texmf-config
TEXMFSYSVAR ${HOME}/tl/texmf-var
TEXMFVAR ${HOME}/.texlive2016/texmf-var
binary_x86_64-linux 1
collection-basic 1
in_place 0
option_adjustrepo 1
option_autobackup 1
option_backupdir tlpkg/backups
option_desktop_integration 0
option_doc 0
option_file_assocs 0
option_fmt 1
option_letter 0
option_menu_integration 0
option_path 0
option_post_code 1
option_src 1
option_sys_bin /usr/local/bin
option_sys_info /usr/local/share/info
option_sys_man /usr/local/share/man
option_w32_multi_user 0
option_write18_restricted 1
portable 0
EOF
./install-tl -profile travis.profile
