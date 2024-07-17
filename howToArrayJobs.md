
# Header

### Log output for all the jobs
```
#SBATCH --job-name=ARRAY
#SBATCH --output=ARRAY.log
```
### Log output per job

```
#SBATCH --job-name=ARRAY
#SBATCH --output=ARRAY.log
```
```
#        %A and %a are placeholders for the jobid and taskid, resp.
#
#Number of CPU cores to use within one node
#SBATCH -c 5
#
#Define the number of hours the job should run. 
#Maximum runtime is limited to 10 days, ie. 240 hours
#SBATCH --time=240:00:00

#SBATCH --mail-user=madamega@ist.ac.at
#SBATCH --mail-type=ALL
#SBATCH --array=1-4
#18
#IMPORTANT NUMBER OF FILES TO BE PROCESSED
#number of files in a directory: ls -1 | wc -l
#for this job: ls /nfs/scistore18/vicosgrp/madamega/artemiaImprinting/analysis/F1C1KS/*1.fastq -1 | wc -l = 11

#Define the amount of RAM used by your job in GigaBytes
#In shared memory applications this is shared among multiple CPUs
#SBATCH --mem=99G
#
#Do not requeue the job in the case it fails.
#SBATCH --no-requeue
#
#Do not export the local environment to the compute nodes
#SBATCH --export=NONE
#SBATCH --reservation=
```
# Run

## Run a set of number 




## Run over all files

