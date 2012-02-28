#!/bin/bash
#$ -S /bin/bash
#$ -l h_vmem=8g,h_rt=24:00:00,num_proc=2

# Author: Damianos Karakos <damianos@jhu.edu>

input_grammar=$1
corpus=$2
output_grammar=$3
fast=$4
ngrams=$5

if [[ $fast -eq 1 ]]; then
	fast="-f"
else
	fast=""
fi

# extract the matching rules from the piece
$JOSHUA/scripts/training/scat $input_grammar | java -Xmx6g -Dfile.encoding=utf8 -cp $JOSHUA/lib/thrax.jar edu.jhu.thrax.util.TestSetFilter -v $fast -n $ngrams $corpus | $JOSHUA/scripts/training/remove-unary-abstract.pl | gzip -9 > $output_grammar

# clean up
rm -f $input_grammar
