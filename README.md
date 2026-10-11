# CEBRA_Reproduce_Workflow

## Step 1
```bash
ssh <username>@login-ice.pace.gatech.edu
```
## Step 2
```bash
cd ~/scratch
git clone https://github.com/ZacharyPrager/CEBRA_Reproduce_Workflow.git reproduce_workflow
cd reproduce_workflow
```
## Step 3
```bash
bash setup_env.sh
```
## Step 4
```bash
sbatch run_cebra.sbatch
```
## Step 5
```bash
python3 watch_job.py <JOB-ID>
```
## Step 6
```bash
cat outputs/run_<JOB-ID>/validation.txt
```
## Step 7
```bash
bash collect_evidence.sh <JOB-ID>
```
