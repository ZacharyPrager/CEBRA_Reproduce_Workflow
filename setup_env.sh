export PIP_CACHE_DIR="$SCRATCH_DIR/.pip_cache"

# making the environment directory 
if ! conda env list | awk '{print $1}' | grep -qx "$ENV_NAME"; then
  conda create -y -n "$ENV_NAME" "python=$PY_VER"
fi
set +u
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$ENV_NAME"
set -u

# the packages and installs
pip install --upgrade pip
pip install torch --index-url "$TORCH_INDEX" #specific torch version for the CUDA
pip install -r requirements.txt
if [ "${INSTALL_FULL:-0}" = "1" ]; then
  pip install -r requirements-full.txt || echo "WARN: topology packages failed to install; --full will skip topology"
fi

# exact environment for tracibility
mkdir -p env
pip freeze > env/pip_freeze.txt
conda env export --no-builds > env/environment_export.yml
python - <<'EOF' | tee env/versions.txt
import sys, torch, cebra, numpy, sklearn
print("python", sys.version.split()[0])
print("torch", torch.__version__, "cuda_build", torch.version.cuda)
print("cebra", cebra.__version__)
print("numpy", numpy.__version__, "sklearn", sklearn.__version__)
EOF

# data downloading
export CEBRA_DATADIR="$PWD/data"
python download_data.py | tee env/data_manifest.txt

curl -fL -o data/rat_demo_example_output.h5 \
  https://github.com/AdaptiveMotorControlLab/CEBRA-demos/raw/main/rat_demo_example_output.h5 \
  && sha256sum data/rat_demo_example_output.h5 | tee -a env/data_manifest.txt \
  || echo "WARN: precomputed .h5 download failed; Betti numbers will be skipped (everything else runs)"

echo "Setup complete. Next: run sbatch run_cebra.sbatch to start!!"
