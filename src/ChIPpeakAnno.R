library(ggplot2)
library(dplyr)
library(tidyr)  
library(tibble) 
###

# https://bioconductor.org/packages/release/bioc/vignettes/ChIPpeakAnno/inst/doc/quickStart.html
 BiocManager::install("ChIPpeakAnno")
 BiocManager::install("org.Hs.eg.db")


library(ChIPpeakAnno)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(org.Hs.eg.db)


###
 OUT_DIR<-'C:/Users/Mary/Desktop/дз/Майнор/файлы с сервера/Проект/Results/'
 DATA_DIR<- 'C:/Users/Mary/Desktop/дз/Майнор/файлы с сервера/Проект/'
 
 NAME <- 'H3K9me3_H1.intersect_with_G4'
###

peaks <- toGRanges(paste0(DATA_DIR, NAME,'.bed'), format="BED")
peaks[1:2]

annoData <- toGRanges(TxDb.Hsapiens.UCSC.hg19.knownGene)
annoData[1:2]


anno <- annotatePeakInBatch(peaks, AnnotationData=annoData, 
                            output="overlapping", 
                            FeatureLocForDistance="TSS",
                            bindingRegion=c(-2000, 300))
data.frame(anno) %>% head()

anno$symbol <- xget(anno$feature, org.Hs.egSYMBOL)
data.frame(anno) %>% head()

anno_df <- data.frame(anno)
write.table(anno_df, file=paste0(DATA_DIR, NAME, '.genes.txt'),
            col.names = TRUE, row.names = FALSE, sep = '\t', quote = FALSE)

uniq_genes_df <- unique(anno_df['symbol'])
write.table(uniq_genes_df, file=paste0(DATA_DIR, NAME, '.genes_uniq.txt'),
            col.names = FALSE, row.names = FALSE, sep = '\t', quote = FALSE)

