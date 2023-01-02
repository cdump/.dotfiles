#!/bin/sh

D=".local/share/fonts/nerd-fonts/DejaVu Sans Mono"
mkdir -p "${D}"
wget -P "${D}" "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu Sans Mono Nerd Font Complete Mono.ttf"
wget -P "${D}" "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Italic/complete/DejaVu Sans Mono Oblique Nerd Font Complete Mono.ttf"
wget -P "${D}" "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Bold/complete/DejaVu Sans Mono Bold Nerd Font Complete Mono.ttf"
wget -P "${D}" "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Bold-Italic/complete/DejaVu Sans Mono Bold Oblique Nerd Font Complete Mono.ttf"

# D=".local/share/fonts/nerd-fonts/Hack"
# mkdir "${D}"
# wget -P "${D}" "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack Regular Nerd Font Complete Mono.ttf"
# wget -P "${D}" "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Italic/complete/Hack Italic Nerd Font Complete Mono.ttf"
# wget -P "${D}" "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Bold/complete/Hack Bold Nerd Font Complete Mono.ttf"
# wget -P "${D}" "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/BoldItalic/complete/Hack Bold Italic Nerd Font Complete Mono.ttf"
