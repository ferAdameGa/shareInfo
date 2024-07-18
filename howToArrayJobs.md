
# Header

### Log output for all the jobs
```
#SBATCH --job-name=ARRAY
#SBATCH --output=ARRAY.log
```
Result: Just one file ARRAY.log (overwritten I think)
### Log output per job

```
#SBATCH --job-name=ARRAY
#SBATCH --output=ARRAY_%A-%a.log
```
Result: One ARRAY_JOB#-NUMBER#.log file per # job

### Rest of the header:
```
#SBATCH -c 5
#SBATCH --time=240:00:00
#SBATCH --mail-user=MAIL@ist.ac.at
#SBATCH --mail-type=ALL
```
Important stuff here on how many times to run!
```
#SBATCH --array=1-22
```
```
#SBATCH --mem=99G
#
#Do not requeue the job in the case it fails.
#SBATCH --no-requeue
#
#Do not export the local environment to the compute nodes
#SBATCH --export=NONE
#SBATCH --reservation=RESERVATION_NO
```

```
#SBATCH --array=1-4
#18
#IMPORTANT NUMBER OF FILES TO BE PROCESSED
#number of files in a directory: ls -1 | wc -l
#for this job: ls /nfs/scistore18/vicosgrp/madamega/artemiaImprinting/analysis/F1C1KS/*1.fastq -1 | wc -l = 11
```
# Run

## Run a set of numbers




## Run over files

### How many files are in folder:

> ls DIRECTORY -1 | wc -l
