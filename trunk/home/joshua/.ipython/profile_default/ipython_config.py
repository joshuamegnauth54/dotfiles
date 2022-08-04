c = get_config()

# Dracula theme
c.TerminalInteractiveShell.highlighting_style = "dracula"
c.TerminalInteractiveShell.true_color = True

# Looks better with dark backgrounds.
c.InteractiveShell.colors = "linux"
c.TerminalInteractiveShell.colors = "linux"

# Pretty docstrings
c.InteractiveShell.sphinxify_docstring = True
c.TerminalInteractiveShell.sphinxify_docstring = True

# Reformat code using black
c.TerminalInteractiveShell.autoformatter = "black"

# vi mode
c.TerminalInteractiveShell.editing_mode = "vi"
