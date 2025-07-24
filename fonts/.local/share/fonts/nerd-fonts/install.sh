#!/bin/bash

D=~/.local/share/fonts/nerd-fonts/

if [[ ! -d ${D}/DejaVuSansMono ]]; then
    cd ${D}
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/DejaVuSansMono.zip
    unzip -d DejaVuSansMono DejaVuSansMono.zip
    rm -f DejaVuSansMono.zip
fi;
