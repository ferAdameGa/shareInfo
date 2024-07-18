#!/bin/bash
#SBATCH --job-name=array_file
#SBATCH --output=array_file-%a.log
#Number of CPU cores to use within one node
#SBATCH -c 5
#
#Define the number of hours the job should run. 
#Maximum runtime is limited to 10 days, ie. 240 hours
#SBATCH --time=240:00:00

#SBATCH --mail-user=
#SBATCH --mail-type=ALL

Number=$(ls $PWD/chr-*.log -1 | wc -l)
echo 'Total number of runs: '$Number


if [[ "$SLURM_ARRAY_TASK_ID" == "" ]]; then
     # Relaunch this script as an array
     exec sbatch --array=1-${Number} $0
fi

unset SLURM_EXPORT_ENV

dir=$PWD/

file=$(ls ${dir}chr-*.log | sed -n ${SLURM_ARRAY_TASK_ID}p)
echo "File: "${file}
