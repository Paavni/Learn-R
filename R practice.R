library(RTextTools)
library(tm)
library(qdap)
library(tau)
setwd("C:/Users/parattan/")
train  = read.table("Train.tsv", header = TRUE, sep = '\t', 
                    stringsAsFactors = TRUE, strip.white  = TRUE, quote = "", fill = TRUE, na.strings = " ")
train[train==""]  = NA
strsplit(as.character(train$EnglishTranslatedComment), " ")
labels = train$TargetAreaPath
dataset = train[,-1]
dataset = dataset[,c(-12,-13)]
rownames(dataset) = dataset[,1]
dataset = dataset[,-1]
tokens = cbind(tokenize(gsub("[[:punct:]]", "", as.character(dataset[,11]))))
tokens_minus_stopwords = removeWords(tokens, stopwords('english'))
freq  = table(tokens_minus_stopwords)
freq_sort = sort(freq, decreasing = TRUE)
#######################################
dataset_comment = cbind(train[,2],as.character(dataset[,11]))
colnames(dataset_comment) = c("BugID", "Comment")
rownames(dataset_comment) = dataset_comment[,1]
dataset_tm = Corpus(DataframeSource(dataset_comment[,2,drop = FALSE]))
output_tm = inspect(TermDocumentMatrix(dataset_tm, control = list(removePunctuation = TRUE, wordLengths = c(0,Inf))))