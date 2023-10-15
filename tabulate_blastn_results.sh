#!/bin/bash
grep "SEQ" show-diff_clade5ref_clade1query |awk '$4>$3 {print $1, $3,$4,$5}' OFS="\t" > seq_clade5ref.bed
grep "INV" show-diff_clade5ref_clade1query |awk '$4>$3 {print $1, $3,$4,$5}' OFS="\t" > inv_clade5ref.bed
grep "JMP" show-diff_clade5ref_clade1query |awk '$4>$3 {print $1, $3,$4,$5}' OFS="\t" > jmp_clade5ref.bed


awk '{print $4}' seq_clade5ref.bed > length_SEQ_clade5ref.txt
awk '{print $4}' jmp_clade5ref.bed > length_JMP_clade5ref.txt
awk '{print $4}' inv_clade5ref.bed > length_INV_clade5ref.txt


bedtools getfasta -fi /home/pavitra/Documents/candida/all_clade_genomes/clade5ref_GCA_016809505.1_ASM1680950v1_genomic.fna -bed seq_clade5ref.bed -fo seq.fa.out
bedtools getfasta -fi /home/pavitra/Documents/candida/all_clade_genomes/clade5ref_GCA_016809505.1_ASM1680950v1_genomic.fna -bed inv_clade5ref.bed -fo inv.fa.out
bedtools getfasta -fi /home/pavitra/Documents/candida/all_clade_genomes/clade5ref_GCA_016809505.1_ASM1680950v1_genomic.fna -bed jmp_clade5ref.bed -fo jmp.fa.out

grep ">" seq.fa.out> seq_coord.txt
grep ">" inv.fa.out>inv_coord.txt
grep ">" jmp.fa.out>jmp_coord.txt

blastn -query seq.fa.out -subject /home/pavitra/Documents/candida/all_clade_genomes/clade1_query_GCA_016772135.1_ASM1677213v1_genomic.fna -outfmt 7|grep "hits"|awk '{print $2}' > from_seq_clade1query.txt
blastn -query seq.fa.out -subject /home/pavitra/Documents/candida/all_clade_genomes/clade2_ref_GCA_003013715.2_ASM301371v2_genomic.fna -outfmt 7|grep "hits"|awk '{print $2}' > from_seq_clade2query.txt
blastn -query seq.fa.out -subject /home/pavitra/Documents/candida/all_clade_genomes/clade3_query_canadian_GCA_016772215.1_ASM1677221v1_genomic.fna -outfmt 7|grep "hits"|awk '{print $2}' > from_seq_clade3query.txt
blastn -query seq.fa.out -subject /home/pavitra/Documents/candida/all_clade_genomes/clade4_query_venezuelan_GCA_008275145.1_ASM827514v1_genomic.fna -outfmt 7|grep "hits"|awk '{print $2}' > from_seq_clade4query.txt
blastn -query seq.fa.out -subject /home/pavitra/Documents/candida/all_clade_genomes/clade5ref_GCA_016809505.1_ASM1680950v1_genomic.fna -outfmt 7|grep "hits"|awk '{print $2}' > from_seq_clade5query.txt



paste seq_coord.txt length_SEQ_clade5ref.txt from_seq_clade1query.txt from_seq_clade2query.txt from_seq_clade3query.txt from_seq_clade4query.txt from_seq_clade5query.txt > seq_table.tsv


blastn -query jmp.fa.out -subject /home/pavitra/Documents/candida/all_clade_genomes/clade1_query_GCA_016772135.1_ASM1677213v1_genomic.fna -outfmt 7|grep "hits"|awk '{print $2}' > from_jmp_clade1query.txt
blastn -query jmp.fa.out -subject /home/pavitra/Documents/candida/all_clade_genomes/clade2_ref_GCA_003013715.2_ASM301371v2_genomic.fna -outfmt 7|grep "hits"|awk '{print $2}' > from_jmp_clade2query.txt
blastn -query jmp.fa.out -subject /home/pavitra/Documents/candida/all_clade_genomes/clade3_query_canadian_GCA_016772215.1_ASM1677221v1_genomic.fna -outfmt 7|grep "hits"|awk '{print $2}' > from_jmp_clade3query.txt
blastn -query jmp.fa.out -subject /home/pavitra/Documents/candida/all_clade_genomes/clade4_query_venezuelan_GCA_008275145.1_ASM827514v1_genomic.fna -outfmt 7|grep "hits"|awk '{print $2}' > from_jmp_clade4query.txt
blastn -query jmp.fa.out -subject /home/pavitra/Documents/candida/all_clade_genomes/clade5ref_GCA_016809505.1_ASM1680950v1_genomic.fna -outfmt 7|grep "hits"|awk '{print $2}' > from_jmp_clade5query.txt

paste jmp_coord.txt length_JMP_clade5ref.txt from_jmp_clade1query.txt from_jmp_clade2query.txt from_jmp_clade3query.txt from_jmp_clade4query.txt from_jmp_clade5query.txt > jmp_table.tsv


blastn -query inv.fa.out -subject /home/pavitra/Documents/candida/all_clade_genomes/clade1_query_GCA_016772135.1_ASM1677213v1_genomic.fna -outfmt 7|grep "hits"|awk '{print $2}' > from_inv_clade1query.txt
blastn -query inv.fa.out -subject /home/pavitra/Documents/candida/all_clade_genomes/clade2_ref_GCA_003013715.2_ASM301371v2_genomic.fna -outfmt 7|grep "hits"|awk '{print $2}' > from_inv_clade2query.txt
blastn -query inv.fa.out -subject /home/pavitra/Documents/candida/all_clade_genomes/clade3_query_canadian_GCA_016772215.1_ASM1677221v1_genomic.fna -outfmt 7|grep "hits"|awk '{print $2}' > from_inv_clade3query.txt
blastn -query inv.fa.out -subject /home/pavitra/Documents/candida/all_clade_genomes/clade4_query_venezuelan_GCA_008275145.1_ASM827514v1_genomic.fna -outfmt 7|grep "hits"|awk '{print $2}' > from_inv_clade4query.txt
blastn -query inv.fa.out -subject /home/pavitra/Documents/candida/all_clade_genomes/clade5ref_GCA_016809505.1_ASM1680950v1_genomic.fna -outfmt 7|grep "hits"|awk '{print $2}' > from_inv_clade5query.txt

paste inv_coord.txt length_INV_clade5ref.txt from_inv_clade1query.txt from_inv_clade2query.txt from_inv_clade3query.txt from_inv_clade4query.txt from_inv_clade5query.txt > inv_table.tsv
ex - seq_table.tsv < header_seq.txt
ex - jmp_table.tsv < header_jmp.txt
ex - inv_table.tsv < header_inv.txt


