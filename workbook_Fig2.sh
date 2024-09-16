##Workbook for Brann et al. 2024 Horizontal Gene (Transposon) Transfer

##Manual curation was completed inline with Goubert et al. Field Guide to Manual Curation of Transposable elements

##Schistosoma / trematde  phylogeny and terminal branch lengths
#reciprologs was ran on the cambridge computing cluster with the longest isoforms of every gene
#Note, we had to run these on the himem cluster (more GB of RAM than usual) to prevent errors
sbatch -p icelake-himem  --time=12:00:00 --mail-type=FAIL --ntasks 76 --cpus-per-task 1 --wrap "./reciprologs.py -p 304 iso_1L_schistosoma_bovis.TD2_PRJEB44434.WBPS18.protein.fa iso_1L_schistosoma_haematobium.TD2_PRJEB44434.WBPS18.protein.fa iso_1L_schistosoma_mansoni.PRJEA36577.WBPS18.protein.fa iso_1L_schistosoma_rodhaini.TD2_PRJEB44434.WBPS18.protein.fa iso_1L_schistosoma_curassoni.PRJEB44434.WBPS18.protein.fa iso_1L_schistosoma_intercalatum.TD1_PRJEB44434.WBPS18.protein.fa iso_1L_schistosoma_margrebowiei.PRJEB44434.WBPS18.protein.fa iso_1L_schistosoma_spindale.PRJEB44434.WBPS18.protein.fa iso_1L_schistosoma_guineensis.PRJEB44434.WBPS18.protein.fa iso_1L_schistosoma_japonicum.PRJNA520774.WBPS18.protein.fa iso_1L_schistosoma_mattheei.PRJEB44434.WBPS18.protein.fa iso_1L_schistosoma_turkestanicum.PRJEB44434.WBPS18.protein.fa iso_1L_trichobilharzia_regenti.PRJEB44434.WBPS18.protein.fa blastp -o combi_out"




##Output of this first bit is just lists of reciprocal orthologs
##Combined downstream analysis - provides you with a list of reciprocal genes
./align_wrapper.sh calls ./align_sequences_v2.sh per row.list (which is the list of reciprologs)
./align_sequences_v2.sh aligns all reciprologs (in a given row.list)
./cmd_concat.sh, which calls ./align_concat.sh with every genome sampled individually (using their genomic / genic identfier), this results in concatenated amino acid alignments per species
#We then combine the alignments into a single fasta, which is each genome and all reciprologs within it concatenated into a single sequence


##Terminal Branch Lengths
Generated with the same process as figure one, using schisto_termlength.py to pull out the respective lengths

##Analysis of Snails - per species
#n(>2,900bp) was calculated 
awk '{if($12-$11>2900){print$0}}' RMaskerOutput | wc -l 
awk '{print$12-$11}' RMaskerOutput | sort -k1n | tail -1

##Distance matrix
cat schisto_TEs.fa snail_TEs.fa > all_TEs.fa
mafft --auto --adjustdirection all_TEs.fa > all_TEs.aln
distmat -nucmethod 1 all_TEs.aln
#This is in then used in R to produce a heatmap
#Annotations were added after assembly of the figure, as was slicing the heatmap in half





