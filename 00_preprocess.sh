#! /usr/bin/env bash

#BSUB -J ont-preprocess
#BSUB -o logs/ont-preprocess.%J.out
#BSUB -e logs/ont-preprocess.%J.err
#BSUB -n 16
#BSUB -R "span[hosts=1]"

source activate tombo2

set -o nounset -o pipefail -o errexit -x

fast5_data="data/fast5_pass"
fastq_data="data/fastq_pass"
singles="data/fast5_pass_singles"

ref="$HOME/ref/genomes/sacCer1/sacCer1.fa"

export H5PY_DEFAULT_READONLY=1

multi_to_single_fast5 --input_path $fast5_data \
  --save_path $singles \
  --threads 16

tombo preprocess annotate_raw_with_fastqs \
    --overwrite --fast5-basedir $singles \
    --processes 16 \
    --fastq-filenames $fastq_data/*.fastq

tombo resquiggle $singles $ref \
    --processes 16 \
    --num-most-common-errors 5 \
    --ignore-read-locks

