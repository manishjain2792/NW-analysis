library('tools')
library('igraph')
library('Matrix')
library('blockmodeling')
directory <- readline(prompt="Enter The Folder Location: ")
filenames <- list.files(path=directory,pattern="*.net")
setwd(file.path(paste(directory)))
man<-typeof(filenames)
len=length(filenames)

prompt <- "Select the metrics you want to calculate (space-separated list) \n
1.Degree Centrality\n2.Avg Clusturing Coefficient\n3.Diameter\n4.Avg Degree\n5.Modularity\n6.Density\n7.Average separation\n"
EXP <- as.integer(strsplit(readline(prompt), " ")[[1]])
file1=paste("Network_Family","-metrics",".csv",sep="")

ptr <- filenames[1]
temp<- file_path_sans_ext(ptr)

name <- paste(directory,ptr,sep="")
#print(name)
x <- read.graph(name,format="pajek")


degree<-centralization.degree(x)$centralization

clustcoeff <-transitivity(x)

diameter<-diameter(x)

avg_degree<-mean(degree(x))

wtc <- walktrap.community(x)
modularity<- modularity(x, membership(wtc))

density<-graph.density(x)

avg_path_length<-average.path.length(x)

write.csv(cbind(temp,degree,clustcoeff,diameter,avg_degree,modularity,density,avg_path_length), 
          file1, 
          col.names=c('File Name','degree centralization','cluster','diameter','Average Degree','modularity','density','Average Seperation'))

for(i in 2:len)
{
  
  ptr <- filenames[i]  
  temp<- file_path_sans_ext(ptr)
  #   if(file.exists(ptr))
  #   {
  #     setwd(file.path(paste(directory)))
  #   }
  #   else
  #   {
  #     dir.create(file.path(paste(directory)))
  #     setwd(file.path(paste(directory)))
  #   }
  name <- paste(directory,ptr,sep="")
  #print(name)
  x <- read.graph(name,format="pajek")
  
  degree<-centralization.degree(x)$centralization
  
  clustcoeff <-transitivity(x)
  
  diameter<-diameter(x)
  
  avg_degree<-mean(degree(x))
  
  wtc <- walktrap.community(x)
  modularity<- modularity(x, membership(wtc))
  
  density<-graph.density(x)
  
  avg_path_length<-average.path.length(x)
  
  
  #file1=paste(temp,"-metrics",".csv",sep="")
  write.table(cbind(temp,degree,clustcoeff,diameter,avg_degree,modularity,density,avg_path_length), 
              file1,col.names= FALSE,append=TRUE,sep="," )
  
}
file <- read.csv(file1)
small <- subset(file,,c(2,EXP+2))
write.csv(small,file1)
