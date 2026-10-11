# CEBRA_Reproduce_Workflow

## Step 1: Enter ICE-Clustor
```bash
ssh <username>@login-ice.pace.gatech.edu
```
## Step 2: Getting the workflow
```bash
cd ~/scratch
git clone https://github.com/ZacharyPrager/CEBRA_Reproduce_Workflow.git reproduce_workflow
cd reproduce_workflow
```
## Step 3: Setting up your environment
```bash
bash setup_env.sh
```
## Step 4: Running the job
```bash
sbatch run_cebra.sbatch
```
## Step 5: Watching the job
```bash
python3 watch_job.py <JOB-ID>
```
## Step 6: Job validation
```bash
cat outputs/run_<JOB-ID>/validation.txt
```
## Step 7: Saving the job's resource stats 
```bash
bash collect_evidence.sh <JOB-ID>
```
