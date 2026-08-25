#!/usr/bin/env bash
# Rebuild every notebook from its jupytext source and execute it end to end.
# Usage: ./tools/build.sh [project-directory ...]   (defaults to all projects)
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

export JUPYTER_CONFIG_DIR="$ROOT/.jupyter-tmp/config"
export JUPYTER_DATA_DIR="$ROOT/.jupyter-tmp/data"
export JUPYTER_RUNTIME_DIR="$ROOT/.jupyter-tmp/runtime"
export MPLCONFIGDIR="$ROOT/.jupyter-tmp/mpl"
export IPYTHONDIR="$ROOT/.jupyter-tmp/ipython"
mkdir -p "$JUPYTER_CONFIG_DIR" "$JUPYTER_DATA_DIR" "$JUPYTER_RUNTIME_DIR" "$MPLCONFIGDIR" "$IPYTHONDIR"

VENV="$ROOT/.venv"
if [ ! -x "$VENV/bin/python" ]; then
  echo "Creating virtual environment..."
  python3 -m venv "$VENV"
  "$VENV/bin/pip" install --quiet --upgrade pip
  "$VENV/bin/pip" install --quiet -r "$ROOT/requirements.txt"
  "$VENV/bin/python" -m ipykernel install --sys-prefix --name gca --display-name "GCA portfolio"
fi

notebook_name() {
  # Kept as a case statement rather than an associative array so the script
  # runs on the bash 3.2 that ships with macOS.
  case "$1" in
    01-grammys-website-analytics) echo "grammys-website-split-analysis" ;;
    02-olympic-medalists)         echo "olympic-medalists-analysis" ;;
    03-mars-weather)              echo "identifying-the-planet" ;;
    04-dc-national-parks)         echo "dc-national-parks-analysis" ;;
    *) echo "unknown project: $1" >&2; return 1 ;;
  esac
}

if [ "$#" -gt 0 ]; then
  projects="$*"
else
  projects="01-grammys-website-analytics 02-olympic-medalists 03-mars-weather 04-dc-national-parks"
fi

for project in $projects; do
  name="$(notebook_name "$project")"
  echo "==> $project"
  (
    cd "$project"
    "$VENV/bin/jupytext" --to notebook --output "$name.ipynb" _src.py
    "$VENV/bin/jupyter" nbconvert --to notebook --execute --inplace \
      --ExecutePreprocessor.kernel_name=gca \
      --ExecutePreprocessor.timeout=600 "$name.ipynb"
    # Stamp a portable kernelspec. Without it, Jupyter and VS Code prompt for a
    # kernel when someone opens the notebook, and the "gca" kernel registered
    # inside this venv does not exist on anyone else's machine.
    "$VENV/bin/python" "$ROOT/tools/stamp_kernelspec.py" "$name.ipynb"
  )
done

echo "Done."
