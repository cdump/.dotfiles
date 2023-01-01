import curses

import ranger.ext.keybinding_parser as ranger_kb
import ranger.gui.ui as ranger_ui

# workaround for https://github.com/ranger/ranger/issues/1026
# https://stackoverflow.com/questions/57742590/differentiate-between-j-and-enter-in-curses/57742710#57742710

assert ranger_kb.special_keys['cr'] == ord("\n")
ranger_kb.special_keys['cr'] = ord("\r"),

assert ranger_kb.special_keys['enter'] == ord("\n")
ranger_kb.special_keys['enter'] = ord("\r"),

assert ranger_kb.special_keys['return'] == ord("\n")
ranger_kb.special_keys['return'] = ord("\r"),


original_setup_curses = ranger_ui.UI.setup_curses

def patched_setup_curses(self):
    original_setup_curses(self)
    curses.nonl()

ranger_ui.UI.setup_curses = patched_setup_curses
