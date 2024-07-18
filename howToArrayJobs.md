
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

Example [code](codes/) run [python code](codes/) from chromosome 1 to 22:


```
#SBATCH --job-name=X_matrix
#SBATCH --output=logs/x_matrix-%a.log

...

#SBATCH --array=1-22

...

source /mnt/nfs/clustersw/Debian/bullseye/anaconda3/2023.04/activate_anaconda3_2023.04.txt
conda activate env2

unset SLURM_EXPORT_ENV
CHR=${SLURM_ARRAY_TASK_ID}
echo 'Working on chromosome: '${CHR}

python array.py ${CHR}
```

## Run over files

### How many files are in folder:

> ls DIRECTORY -1 | wc -l

Make sure #SBATCH --array=1-# matches the number of files!

Example:


## Run over list on  txt file

