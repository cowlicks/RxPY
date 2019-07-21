from rope.base.project import Project
from rope.base import libutils
from rope.refactor.rename import Rename

rx_proj = Project('.')
rx_mod = rx_proj.find_module('rx')
to_rx3_changes = Rename(rx_proj, rx_mod).get_changes('rx3')
rx_proj.do(to_rx3_changes)
rx_proj.close()
