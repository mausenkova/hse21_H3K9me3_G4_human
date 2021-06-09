library("ggplot2")
library("dplyr")

setwd("C:/Users/Mary/Desktop/дз/Майнор/файлы с сервера/Проект")
###

NAME <- 'GSM3003539.merged'
#NAME <- 'H3K9me3_H1.ENCFF697NMG.hg19'
#NAME <- 'H3K9me3_H1.ENCFF587TWB.hg19'
OUT_DIR<-'C:/Users/Mary/Desktop/дз/Майнор/файлы с сервера/Проект/Results'
###

bed_df <- read.delim(paste0(NAME, '.bed'), as.is = TRUE, header = FALSE)
#colnames(bed_df) <- c('chrom', 'start', 'end', 'name', 'score')
colnames(bed_df) <- c('chrom', 'start', 'end')
bed_df$len <- bed_df$end - bed_df$start
head(bed_df)

bed_df %>% 
  arrange(-len) %>%
  head()

ggplot(bed_df) +
  aes(x = len) +
  geom_histogram() +
  ggtitle(NAME, subtitle = sprintf('Number of peaks = %s', nrow(bed_df))) +
  theme_bw()
ggsave(paste0('len_hist.', NAME, '.pdf'), path = OUT_DIR)
