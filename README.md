# CEBRA_Reproduce_Workflow
Reproduces the first experiment of the CEBRA demo **["Encoding of space, hippocampus (CA1)"](https://cebra.ai/docs/demo_notebooks/Demo_hippocampus.html)** (notebook cells 1–30) as a batch job on Georgia Tech's PACE ICE cluster (AI Makerspace).
---
Run everything on the **login node**. This is because we are running a job that is not interactive. Running **sbatch** inside a compute node will crash and not work

## Inference Workflow & Job Scripts

### Step 1: Enter ICE-Cluster
Replace <username> with your username
```bash
ssh <username>@login-ice.pace.gatech.edu
```

### Step 2: Getting the workflow
Go into your scratch folder and clone the repo in order to obtain the code / workflow. Then enter its directory.
```bash
cd ~/scratch
git clone https://github.com/ZacharyPrager/CEBRA_Reproduce_Workflow.git reproduce_workflow
cd reproduce_workflow
```
### Step 3: Setting up your environment
Once finished, you will see `Setup Complete`. 
```bash
bash setup_env.sh
```
### Step 4: Running the job
Once the sbatch script is finished you will see `Submitted batch job <JOB-ID>`.
```bash
sbatch run_cebra.sbatch
```
### Step 5: Watching the job
Run this code to "watch" as the job completes. You will see the state as it changes and a short summary 
```bash
python3 watch_job.py <JOB-ID>
```
### Step 6: Job validation
You should see `SUMMARY: 7/7 CHECKS PASSED`
```bash
cat outputs/run_<JOB-ID>/validation.txt
```
### Step 7: Saving the job's resource stats 
Run after the job finishes. Saves run time, memory use and exit state to `outputs/run_<JOB-ID>/slurm_accounting.txt`.
```bash
bash collect_evidence.sh <JOB-ID>
```
## Visualization Outputs
Inside `outputs/run_<JOB-ID>/figures/` you will find all the interactive simulations and data visualized. The interactive ones are with the `.html` extension. You can view these using Georgia Tech's ICE Cluster OnDemand platform. The link is found here (https://gatech.service-now.com/home?id=kb_article_view&sysparm_article=KB0042133).

## Environment & Setup

### `setup_env.sh` does the following things:
1. Creates the directories `data/`,`env/`,`logs/`,`outputs/`. 
2. Loads the `conda` module and creates the `cebra` environment
3. Installs the `CEBRA`,`matplotlib`,`PyTorch` dependencies
4. Records the version dependencies in `env/pip_freeze.txt`,`env/environment_export.yml` and `env/versions.txt`.
5. Downloads the dataset and records its SHA-256 hash in `env/data_manifest.txt`.

### Packages Breakdown
1. Python version 3.11 installed with `setup_env.sh`
2. CEBRA version 0.6.1 (with datasets and integrations) installed with `requirements.txt`
3. PyTorch 2.14.0, CUDA 13.0 build (`+cu130`), installed with `setup_env.sh`. This build only runs on newer NVIDIA GPUs (A100, H100, L40S), so `run_cebra.sbatch` requests an H100.
4. 4. matplotlib version >= 3.8 installed with `requirements.txt`

**See `env/pip_freeze.txt` to view every package's exact version**

## Model, Data & Artifact Traceability
## Execution Evidence & Logs
## Validation of Results
