# NEVERMIND 

![image](https://github.com/user-attachments/assets/3d028a56-2bef-47b0-ac33-7e48d83a78c8)


## Load anaconda to the cluster

> module load anaconda3/2023.04
>source /mnt/nfs/clustersw/Debian/bullseye/anaconda3/2023.04/activate_anaconda3_2023.04.txt

[Conda info](https://conda.io/projects/conda/en/latest/user-guide/getting-started.html#managing-python)

## Environments

Defined spaces of work with their own packages and pre-sets

## Create a new environment

> conda create -n EnvName

#### Create with packages pre-loaded

> conda create -n EnvName python numpy pandas

## List environments

> conda info --envs

## Activate environment

> conda activate EnvName

## Deactivate environment

> conda deactivate

Note: Once activated your terminal would serve as inside said environment so if you want to run anything else it's recommende to exit the environment before running.

Example: Conda activated in environment base (default)

![image](https://github.com/user-attachments/assets/e7354215-5007-4cc4-af30-c0c69a433b07)


## Install Packages

> conda install packageName

> conda install --name EnvName packageName

> conda install anaconda::packageName

Note: Generally packages have instructions on their doc pages on how to install in conda

## Spyder

IDE for python, I recommend cause I like it :3 

It lets you see the variables and plot the figures in a different window
![image](https://github.com/user-attachments/assets/d30ead65-a814-4694-9c7a-dd56ae719b48)


### Install in conda

> conda install -c conda-forge spyder

### Alternative if the last command did not work

Create specific environment 

> conda create -c conda-forge -n spyder-env spy
> conda activate spyder-env
> conda install -c conda-forge pandas-plink

### Run spyder on cluster

> source /mnt/nfs/clustersw/Debian/bullseye/anaconda3/2023.04/activate_anaconda3_2023.04.txt
> conda activate spyder-env
> spyder

## Solve QStandardPaths: XDG_RUNTIME_DIR not set 
(Home path)

1. Create private folder with permissions 700 (right click permissions if on MobaXterm)
2. Modify bashrc file with:
```
export XDG_RUNTIME_DIR=/nfs/scistore17/robingrp/madamega/QStandardPath/
export RUNLEVEL=3
```
3. Run bashrc:
> source .bashrc
4. Run spyder again

[Reference](https://stackoverflow.com/questions/59790350/qstandardpaths-xdg-runtime-dir-not-set-defaulting-to-tmp-runtime-aadithyasb)

## Modify ~/.bashrc
1. go to home path: /nfs/scistore#/grp/UsrName/
2. Make hidden files visible
3. Comment since: "conda initialize"

