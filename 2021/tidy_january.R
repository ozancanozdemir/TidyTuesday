library(tidytuesdayR) # Get tidy tuesday data
tidytuesdayR::tt_load('2021-01-19') #get the data


#read the data manually

gender <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-01-19/gender.csv')
crops <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-01-19/crops.csv')
households <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-01-19/households.csv')

#data manipulation
head(households)
hh<-as.data.frame(households) #change class
rownames(hh)<-households$County

head(hh) #check the data
hh<-hh[,-1] #remove first column


## k-means clustering

#required packages 

library(factoextra)
library(ggthemes)

#elbow plot  
fviz_nbclust(hh, kmeans, method = "wss") #2 cluster is enough

final <- kmeans(hh, 2,nstart=25)
print(final) 

#kenya is the outlier and violates the result. That's why we remove it.

hh<-hh[-1,]

fviz_nbclust(hh, kmeans, method = "wss") #4  cluster is enough

final <- kmeans(hh, 4,nstart=25)
print(final) 

fviz_cluster(final, data = hh)+theme_fivethirtyeight()+theme(rect = element_rect(fill = "White",linetype = 0, colour = NA))+labs(title="Cluster of Counties in Kenya based on Household",caption="Visualization: Ozancan Ozdemir (@OzancanOzdemir) | Data: Kenya Population and Housing Census 2019")
