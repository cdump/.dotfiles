#!/bin/bash

D=~/.local/share/fonts/nerd-fonts/

if [[ ! -d ${D}/DejaVuSansMono ]]; then
    cd ${D}
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/DejaVuSansMono.zip
    unzip -d DejaVuSansMono DejaVuSansMono.zip
    rm -f DejaVuSansMono.zip
fi;
