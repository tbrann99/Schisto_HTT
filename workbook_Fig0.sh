##Workbook for Brann et al. 2024 Horizontal Gene (Transposon) Transfer

#Relaxed BlastN from Galbraith et al. 2020
Galbraith, J.D., Ludington, A.J., Suh, A., Sanders, K.L. and Adelson, D.L., 2020. New environment, new invaders—repeated horizontal transfer of LINEs to sea snakes. Genome Biology and Evolution, 12(12), pp.2370-2383.

BLASTN -reward 3 -penalty -4 -xdrop_ungap 80 -xdrop_gap 130 -xdrop_gap_final 150 -word_size 14 -dust yes -gapopen 30 -gapextend 6 -outfmt 6 -evalue 1e-5 -query Smansoni_Perere-3_Sr3.fa -subject other genomes

#Other genomes tested were:
Schistosoma mansoni GCA_000237925.5
Trichobilharzia regenti GCA_944472135.2
Heterobilharzia americana GCA_944470555.2
Fasciola hepatica GCA_948099385.1
Clonorchis sinensis GCA_003604175.2
Bulinus truncatus GCA_021962125.1
Biomphalaria straminea GCA_021533235.1
Lymnaea stagnalis GCA_900036025.1
Homo sapien GCF_000001405.40

##Results were stratified into Perere-3, Sr3 and Other
grep Perere-3 $file | awk '{print$4}' | awk 'a+=$1; END{print a}' | tail -1 | awk '{print$1}'
grep Perere-3 $file | awk '{print$4}' | wc -l | awk '{print$1}'

grep Sr3 $file | awk '{print$4}' | awk 'a+=$1; END{print a}' | tail -1 | awk '{print$1}'
grep Sr3 $file | awk '{print$4}' | wc -l | awk '{print$1}'

grep -v Perere-3 $file | grep -v Sr3 | awk '{print$4}' | awk 'a+=$1; END{print a}' | tail -1 | awk '{print$1}'
grep -v Perere-3 $file | grep -v Sr3 | awk '{print$4}' | wc -l | awk '{print$1}'

