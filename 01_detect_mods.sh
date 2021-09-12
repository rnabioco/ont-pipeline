#! /usr/bin/env bash

#BSUB -J ont-detect-mods
#BSUB -o logs/ont-detect-mods.%J.out
#BSUB -e logs/ont-detect-mods.%J.err
#BSUB -n 16
#BSUB -R "span[hosts=1]"

source activate tombo2

set -o nounset -o pipefail -o errexit -x

fast5_data="data/fast5_pass"
fastq_data="data/fastq_pass"
singles="data/fast5_pass_singles"

ref="$HOME/ref/genomes/sacCer1/sacCer1.fa"

export H5PY_DEFAULT_READONLY=1

tombo detect_modifications de_novo \
    --fast5-basedir $singles \
    --statistics-file-basename de_novo \
    --processes 16

