## Introduction

This is a ruby rake script to demutiplex the Pacbio raw subread data by the barcodes used. Demultiplexing the subreads requires some input files. 
1) inputfofn - This input file should contain the absolute paths to the subreads.bam files from Pacbio Sequel data. For e.g
```
/Raw_reads/A11_1/m160821_044615_42165_c101089132550000001823241503091760_s1_p0.subreads.bam
/Raw_reads/A01_1/m160821_044615_42165_c101089132550000001823241503091760_s1_p0.subreads.bam
/Raw_reads/A02_1/m160821_044615_42165_c101089132550000001823241503091760_s1_p0.subreads.bam
```
2) barcodes.fasta - This input fasta format file should contain the barcodes. Forward barcode should follow the reverse barcode in the fasta file. For. e.g
	
```
>barcode1_F
ATAGACCCCA
>barcode1_R
AAGAGAATAT
>barcode2_F
GGATAGACCC
>barocde2_R
AGGAAAACA
and so on
```

After completion of analysis, the demultiplexed subreads are found in the  result folder. The demultiplex files will be named like demultiplex.0-1.fastq.gz, demultiplex.2-3.fastq.gz, demultiplex.4-5.fastq.gz and so on
demultiplex.0-1.fastq.gz will contain the subreads recognized by the forward and reverse barcodes from barcode1 (see example barcode.fasta)
demultiplex.0-1.fastq.gz will contain the subreads recognized by the forward and reverse barcodes from barcode2.(see example barcode.fasta)

The cluster used is SLURM here. If you use a different cluster, change the path to the cluster type in the lib/preset.xml file after the line containing cluster_manager.

## requirements

1) ruby rake
2) smrtlink v4.0.0

## usage:

1) ruby -f rakefile barcode=barcode.fasta inputfofn=inputfiles.fofn projectdir=Demultiplex	#by default the projectdir is 'Demultiplex'


