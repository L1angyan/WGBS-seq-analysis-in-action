fastqc S1-2-Mu_R1.fq.gz S1-2-Mu_R2.fq.gz -o ./ -t 8
fastqc S1-2-Wt_R1.fq.gz S1-2-Wt_R2.fq.gz -o ./ -t 8
# After QC, there is no need for filtering reads

bismark_genome_preparation --parallel 8 --path_to_aligner ~/software/bowtie2-2.3.5.1-linux-x86_64 --verbose ~/b73V4/
# index
# There is an reference genome in ~/b73V4/

bismark --genome ~/b73V4/ --non_directional -1 S1-2-Mu_R1.fq.gz -2 S1-2-Mu_R2.fq.gz -p 2 -o ./
bismark --genome ~/b73V4/ --non_directional -1 S1-2-Wt_R1.fq.gz -2 S1-2-Wt_R2.fq.gz -p 2 -o ./
# mapping
# non_directional library

for i in *.sam.gz;do 
name=${i%.sam*}
gunzip $i
samtools view -@ 2 -b ${name}.sam > ${name}.bam
done
#unzip
#trans sam2bam
