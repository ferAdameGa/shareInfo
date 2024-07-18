#!/bin/bash
#SBATCH --job-name test
#SBATCH --cpus-per-task 4
#SBATCH --time 00-05:00
#SBATCH --output Fromfile-%a.log

# Get first arg from command line or error with message
file=file.txt

# How many lines does that file have?
nline=$(wc -l $file | awk '{print $1}')

# Check to see if this is running as a task. If not, replace this process with a SLURM array, with one task per ID.
if [[ "$SLURM_ARRAY_TASK_ID" == "" ]]; then
     # Relaunch this script as an array
     exec sbatch --array=1-$nline $0
fi

# Extract line from file corresponding to the current task
# (i.e. first task gets first line, second task gets 
# second line, etc.)
VAR=$( sed -n ${SLURM_ARRAY_TASK_ID}p $file )

# Could also use readarray -O 1 -t VARS $ids_file, etc

echo $VAR
