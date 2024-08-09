#!/bin/bash
#
#SBATCH --job-name=arrayList
#SBATCH --output=logs/list%a.log
#          %A-%a are placeholders for the jobid and taskid, resp.
#
#Number of CPU cores to use within one node
#SBATCH -c 10
#
#
#Define the number of hours the job should run. 
#Maximum runtime is limited to 10 days, ie. 240 hours
#SBATCH --time=240:00:00

#SBATCH --mail-user=madamega@ist.ac.at
#SBATCH --mail-type=ALL

#SBATCH --array=1-3

#Define the amount of RAM used by your job in GigaBytes
#In shared memory applications this is shared among multiple CPUs #SBATCH --mem=20G #SBATCH --mem-per-cpu=100G
#SBATCH --mem=100G
#
#Do not requeue the job in the case it fails.
#SBATCH --no-requeue
#
#Do not export the local environment to the compute nodes

unset SLURM_EXPORT_ENV


NUM=${SLURM_ARRAY_TASK_ID}
NO=("0.5" "1" "1.5")

echo 'Working on job : '${NUM}
echo 'List: '${NO[${NUM}-1]}