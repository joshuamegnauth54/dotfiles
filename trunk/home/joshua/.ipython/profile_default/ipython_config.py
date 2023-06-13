from traitlets.config.loader import Config
from traitlets.config import get_config

c: Config = get_config()

# Dracula theme
c.TerminalInteractiveShell.highlighting_style = "dracula"
c.TerminalInteractiveShell.true_color = True

# Looks better with dark backgrounds.
c.InteractiveShell.colors = "linux"
c.TerminalInteractiveShell.colors = "linux"

# Pretty docstrings. Requires docrepr
try:
    import docrepr

    c.InteractiveShell.sphinxify_docstring = True
    c.TerminalInteractiveShell.sphinxify_docstring = True
except ImportError:
    pass

# Reformat code using black
c.TerminalInteractiveShell.autoformatter = "black"

# vi mode
c.TerminalInteractiveShell.editing_mode = "vi"
