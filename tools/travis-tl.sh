#!/bin/bash
cd tools
[[ ! -e tl-installer.tar.gz ]] && wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz -O tl-installer.tar.gz
mkdir -p tl-installer ~/tl/temp
tar xzf tl-installer.tar.gz --strip-components=1 -C tl-installer
cd tl-installer
cat > travis.profile << EOF
selected_scheme scheme-minimal
TEXDIR ${HOME}/tl
TEXMFCONFIG ${HOME}/.texlive2015/texmf-config
TEXMFHOME ${HOME}/texmf
TEXMFLOCAL ${HOME}/tl/texmf-local
TEXMFSYSCONFIG ${HOME}/tl/texmf-config
TEXMFSYSVAR ${HOME}/tl/texmf-var
TEXMFVAR ${HOME}/.texlive2015/texmf-var
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
