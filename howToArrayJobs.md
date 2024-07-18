# Why?
```
Please do not submit many jobs using a for loop through a Bash script, python etc. This procedure will provoke, indeed, continuous calls to the slurm daemon causing network and socket errors. We strongly suggest to submit instead a single array job

...

In case your analysis involves a job, maybe with little resource requirements, which has to be repeated multiple times, maybe with different input data, or different parameters, an array job will be useful. This allows to submit with little effort collections of similar jobs quickly and easily. The job will be executed independently but in parallel, as far as the available resources allow for it. Job arrays with millions of tasks can be submitted in milliseconds. All jobs must have the same initial options (e.g. size, time limit, etc.)
```

# Header

### Log output for all runs
```
#SBATCH --job-name=ARRAY
#SBATCH --output=array.log
```
Result: Just one file ARRAY.log (overwritten)

Example output based on modified [code](codes/arrayJob.sh):

![image](https://github.com/user-attachments/assets/991a51b6-062e-4dc7-a72e-dbd1c2104917)

Notice not all numbers are printed in the log file but all of them ran.

### Log output per run
%A and %a are placeholders for the jobid and taskid
```
#SBATCH --job-name=ARRAY
#SBATCH --output=array_%A-%a.log
```
Result: One ARRAY_[Job]-[Run].log file per run

Example:

![image](https://github.com/user-attachments/assets/2342903c-e3b2-48a5-8537-39b0d1e83868)

#### Recommended:
```
#SBATCH --job-name=ARRAY
#SBATCH --output=array-%a.log
```
Result: One ARRAY-[Run].log file per run

Example:

![image](https://github.com/user-attachments/assets/21e8d789-d4ed-489f-9ffd-ef71c460432c)

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
# Run

## Run a set of numbers

Inclusive range

Example [code](codes/runPythonArray.sh) run [python code](codes/array.py) from chromosome 1 to 22:

```
#SBATCH --job-name=array
#SBATCH --output=logs/array-%a.log

...

#SBATCH --array=1-22

...
unset SLURM_EXPORT_ENV
CHR=${SLURM_ARRAY_TASK_ID}
echo 'Working on chromosome: '${CHR}

python array.py ${CHR}
```

## Run over files

### How many files are in folder:

> ls DIRECTORY -1 | wc -l

Make sure #SBATCH --array=1-# matches the number of files!

Example run over output logs from previous example [code](codes/arrayFiles.sh)

```
unset SLURM_EXPORT_ENV

dir=$PWD/

file=$(ls ${dir}chr-*.log | sed -n ${SLURM_ARRAY_TASK_ID}p)
echo "File: "${file}
```

### Automate run all files

Example run over output logs from previous example [code](codes/arrayFilesAutomate.sh)

```
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
```
NOTE: runs are not performed in order, aka output files will have different numbers/names than that of the input files

![image](https://github.com/user-attachments/assets/35f7fcfa-82cb-4b77-8904-daf83735563d)


## Run over list on txt file

Example [code](codes/arrayFromFile.sh) print each line of [file](codes/file.txt)
```
file=file.txt

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

echo $VAR
```
