# CEBRA_Reproduce_Workflow
Reproduces the first experiment of the CEBRA demo **["Encoding of space, hippocampus (CA1)"](https://cebra.ai/docs/demo_notebooks/Demo_hippocampus.html)** (notebook cells 1–30) as a batch job on Georgia Tech's PACE ICE cluster (AI Makerspace).
---
Run everything on the **login node**. This is because we are running a job that is not interactive. Running **sbatch** inside a compute node will crash and not work

### Step 1: Enter ICE-Clustor
Replace <username> with your username
```bash
ssh <username>@login-ice.pace.gatech.edu
```
## Workflow

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
