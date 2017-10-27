#!/bin/bash
source smrtlink-4.0.0.190159
cd ${1}/tasks/
for pbcore in pbcoretools.tasks.bam2bam_barcode-*; do
  cd $pbcore
     bam2fastq -o demultiplex --split-barcodes subreads_barcoded.subreads.bam
  cd ..
done

cd ../..

# now collecting the demultiplexed subreads
mkdir -p ${1}/result
for barcode in ${1}/tasks/pbcoretools.tasks.bam2bam_barcode-1/*.fastq.gz; do
        barcode_base=$(basename $barcode | sed 's/.gz$//')
        barcode_base_gz=$(basename $barcode)
        echo $barcode_base $barcode_base_gz
        if [ -e ${1}/result/${barcode_base} ]; then rm ${1}/result/${barcode_base}; fi
        for task_barcode in ${1}/tasks/pbcoretools.tasks.bam2bam_barcode-*/${barcode_base_gz}; do
                gunzip -c ${task_barcode} >> ${1}/result/${barcode_base}
        done
        echo "Done $barcode_base"
        echo "Gzipping ${1}/result/${barcode_base}"
        gzip ${1}/result/${barcode_base}
done

rm ${1}/tasks/pbcoretools.tasks.bam2bam_barcode-*/*.fastq.gz
