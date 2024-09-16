##Workbook for Brann et al. 2024 Horizontal Gene (Transposon) Transfer

# #156082 - Perere-3
# #EB7131 - Sr3

#RepeatMasker using flags "-no_is -gff -s -a -lib" and the TE library for S. mansoni 

##Domain vizualisation of each Perere-3 and Sr3 - Panel A
getorf -minsize 500 $i ${i}.orf; done
#This was then used with InterProScan5 web portal (https://www.ebi.ac.uk/interpro/search/sequence/) to identify  L1-EN - cd09076, RT POL - PS50878 and DUF-6451 - PF20049	coordinates
#Coordinates were then used with a bedtools getfasta to extract the specific regions corresponding to the relevant domain
#Pairs of domain sequences originating from Perere-3 and Sr3 were aligned and percentage identity calculated using Jalview's Pairwise Alignment
mafft --reorder --adjustdirection

##Tree of full length copies - Panel B 
grep "Perere-3\|Sr3" RMaskerOutput | awk '{OFS="\t"}{if($12-$11>3200){print$0}}' > FL_copies
bedtools getfasta -bed FL_copies -fi mansoni_genome
##Addition of outgroup 
cat FL_copies Ancohuma > FL_copies_woutgroup
iqtree --seqtype DNA -T AUTO --alrt 1000 --root-seq FILENAME,SR2#LINE_RTE

##Tree map - Panel C
#TE_list.txt = list of TEs in the genome (the unique names)
#Also have to specify genome within treemap_gen.sh
awk '{print$11}' RMaskerOutput | sort -u > TE_list.txt
./treemap_gen.sh TE_list.txt | awk '{print$1}' > treemap_out.txt
./processing.py treemap_out.txt > treemap_toviz.txt
##Where columns represents the name of the element,number of elements, number of bases of the element
##These are then visualised with David Wilkin's Treemapify in R
#https://cran.r-project.org/web/packages/treemapify/vignettes/introduction-to-treemapify.html

##Complete / Incomplete - Panel D
./pfam_query.sh 
#to generate a domain.matrix, which is then analysed by pfam_parse.py to combine domains with respective coordinates
./dom_parse.py Perere-3_Sr3.gff_wdom Perere-3_Sr3.gff > Perere-3_Sr3_wdom.gff
#takes the output of the above and the original annotation file to generate intact gff with an appended "complete" or "incomplete"
##Using the .align file generated from the -a flag of the above RM run
grep "m\_\|imura" ../../../V10_RM/TE_RM/SmansoniV10.fa.align | grep -A1 "Perere-3\|Sr3" | grep -v -- "^--$" > align.reform.txt
./align_append.py align.reform.txt Perere-3_Sr3_wdom.gff

##Terminal Branch Length - Panel E
#For each transposable element (where TE = $line)
grep $line SmansoniV10.fa.out.gff | awk '{if($5-$4>500){print$0}}' | bedtools getfasta -fi schistosoma_mansoni.PRJEA36577.WBPS18.genomic.fa -bed - > ${line}.fa
mafft --auto ${line}.fa > ${line}.aln
trimal -in ${line}.aln -gt 0.01 -keepheader > ${line}.trim.aln
sed 's/:/_/g' ${line}.trim.aln > ${line}.trim.aln.sub
FastTree -nt -gamma < ${line}.trim.aln.sub > ${line}.tree
./termlength.py ${line}.tree > ${line}.tbl
#We then appended things such as number of 0s, and family which can be found by:
awk '{if($1="0.0"){print$2}' | awk -F".tbl" '{print$1}' | sort " uniq -c













