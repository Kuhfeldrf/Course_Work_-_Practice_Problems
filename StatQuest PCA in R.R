#https://www.youtube.com/watch?v=0Jp4gsfOLMs&list=PLblh5JKOoLUICTaGLRoHQDuF_7q2GfuJF&index=33
#https://github.com/StatQuest/pca_demo/blob/master/pca_demo.R
data.matrix <- matrix(nrow=100, ncol=10)
colnames(data.matrix) <- c(
  paste("wt", 1:5, sep=""),
  paste("ko", 1:5, sep=""))

rownames(data.matrix) <- paste("gene", 1:100, sep="")
for (i in 1:100) {
  wt.values <- rpois(5, lambda=sample(x=10:1000, size=1))
  ko.values <- rpois(5, lambda=sample(x=10:1000, size=1))
  
  data.matrix[i,] <- c(wt.values, ko.values)
}
head(data.matrix)
dim(data.matrix)
pca <- prcomp(t(data.matrix), scale=TRUE)
pca

#Plotting pc1 and pc2
plot(pca$x[,1], pca$x[,2])

#make a scree plot
pca.var <-pca$sdev^2
pca.var.per <-round(pca.var/sum(pca.var)*100,1)
barplot(pca.var.per, main = "Scree Plot", xlab="principle component", ylab ="% var.")

## now make a fancy looking plot that shows the PCs and the variation:
library(ggplot2)

pca.data<-data.frame(Sample=rownames(pca$x),
                    X=pca$x[,1],
                    Y=pca$x[,2])
pca.data
ggplot(data=pca.data, aes(x=X, y=Y, label=Sample)) +
  geom_text() +
  xlab(paste("PC1 - ", pca.var.per[1], "%", sep="")) +
  ylab(paste("PC2 - ", pca.var.per[2], "%", sep="")) +
  theme_bw() +
  ggtitle("My PCA Graph")

## get the name of the top 10 measurements (genes) that contribute
## most to pc1.
loading_scores <-pca$rotation[,1]
gene_scores <- abs(loading_scores)
gene_score_ranked <- sort(gene_scores, decreasing = TRUE)
top_10_genes <-names(gene_score_ranked[1:10])
top_10_genes
pca$rotation[top_10_genes,1]
