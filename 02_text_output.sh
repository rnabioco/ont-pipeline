#! /usr/bin/env bash

#BSUB -J ont-test-ouput
#BSUB -o logs/ont-text-output.%J.out
#BSUB -e logs/ont-text-output.%J.err
#BSUB -n 16
#BSUB -R "span[hosts=1]"

source activate tombo2

# set -o nounset -o pipefail -o errexit -x
set -o nounset -o pipefail -x

fast5_data="data/fast5_pass"
fastq_data="data/fastq_pass"
singles="data/fast5_pass_singles"

ref="$HOME/ref/genomes/sacCer1/sacCer1.fa"

export H5PY_DEFAULT_READONLY=1

cmds="coverage valid_coverage fraction dampened_fraction signal signal_sd dwell difference statistic"
mkdir browser_files

for cmd in $cmds; do
    tombo text_output browser_files \
        --fast5-basedir $singles \
        --file-type $cmd \
        --browser-file-basename "browser_files"
done

