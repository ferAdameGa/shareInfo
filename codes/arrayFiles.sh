#!/bin/bash
#SBATCH --job-name=array_file
#SBATCH --output=array_file-%a.log
#        %A and %a are placeholders for the jobid and taskid, resp.
#
#Number of CPU cores to use within one node
#SBATCH -c 5
#
#Define the number of hours the job should run. 
#Maximum runtime is limited to 10 days, ie. 240 hours
#SBATCH --time=240:00:00

#SBATCH --mail-user=
#SBATCH --mail-type=ALL
#SBATCH --array=1-22
#18
#IMPORTANT NUMBER OF FILES TO BE PROCESSED
#number of files in a directory: ls -1 | wc -l
#for this job: ls DIRECTORY -1 | wc -l = 11

#Define the amount of RAM used by your job in GigaBytes
#In shared memory applications this is shared among multiple CPUs
#SBATCH --mem=5G
#
#Do not requeue the job in the case it fails.
#SBATCH --no-requeue
#
#Do not export the local environment to the compute nodes
#SBATCH --export=NONE
unset SLURM_EXPORT_ENV

dir=$PWD/

file=$(ls ${dir}chr-*.log | sed -n ${SLURM_ARRAY_TASK_ID}p)
echo "File: "${file}

