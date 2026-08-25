#!/usr/bin/env python3
"""Write a portable kernelspec into an executed notebook.

The build executes notebooks against a kernel named ``gca`` that is registered
inside this repository's virtual environment. That name means nothing on another
machine, so anyone opening the committed notebook would be asked to pick a
kernel. Replacing it with the generic ``python3`` spec makes the notebooks open
cleanly in Jupyter, JupyterLab, VS Code, and nbviewer.
"""

import platform
import sys

import nbformat


def stamp(path: str) -> None:
    nb = nbformat.read(path, as_version=4)
    nb.metadata["kernelspec"] = {
        "display_name": "Python 3",
        "language": "python",
        "name": "python3",
    }
    nb.metadata["language_info"] = {
        "name": "python",
        "version": platform.python_version(),
        "mimetype": "text/x-python",
        "file_extension": ".py",
        "pygments_lexer": "ipython3",
        "nbconvert_exporter": "python",
        "codemirror_mode": {"name": "ipython", "version": 3},
    }
    nbformat.validate(nb)
    nbformat.write(nb, path)
    print(f"[kernelspec] stamped {path}")


if __name__ == "__main__":
    for target in sys.argv[1:]:
        stamp(target)
