library(jsonlite)
library(data.table)
youtube_chanels <- list(
  "Suppoman" = "https://www.youtube.com/channel/UCCmJln4C_CszIusbJ_MHmfQ", 
  "datadash" =  "https://www.youtube.com/channel/UCCatR7nWbYrkVXdxXb4cGXw", 
  "boxmining" = "https://www.youtube.com/channel/UCxODjeUwZHk3p-7TU-IsDOA", 
  "crypto_daily"= "https://www.youtube.com/channel/UC67AEEecqFEc92nVvcqKdhA", 
  "Jerry Banfield"="https://www.youtube.com/channel/UCtJpm41R6jC3HuboTIkn7ew",
  "crypto investor"="https://www.youtube.com/channel/UCTKyJALgd09WxZBuWVbZzXQ",
  "Cedrich Dahl"="https://www.youtube.com/channel/UCUoE4kAxLnLByLko06EaaOQ",
  "The Crypto Chick"="https://www.youtube.com/channel/UCKCpBWfTJsZQe21Hk31rQzQ",
  "newsbtc"="https://www.youtube.com/channel/UC9v9erBEru5y4c3FA0wehEw",
  "Dollar vigilante"="https://www.youtube.com/channel/UCpf2Lxgf10AjzBT4GIIgDJw"
)
my_list <- sapply(strsplit(unname(unlist(youtube_chanels)), 'channel/'), "[[", 2)

#ch_id<- my_list[1]
get_names <- function(ch_id){
  
  adat <-fromJSON(paste0("https://www.googleapis.com/youtube/v3/search?key=AIzaSyDpC0t4WEA6DOLJqssDyHvEZodxWmgXEFQ&channelId=",ch_id,"&part=snippet,id&order=date&maxResults=5"))
  d <- data.table('chanel'=adat$items$snippet$channelTitle, "title" = as.character(adat$items$snippet$title), 
             'video_link'= paste0('https://www.youtube.com/watch?v=', adat$items$id$videoId), 
             "published"=as.Date(adat$items$snippet$publishedAt ))
  return(d)
}

adat <-rbindlist(lapply(my_list, get_names))

unname(unlist(youtube_chanels))
unique(adat$chanel)

fileConn<-file("~/youtube_post.txt", "w")
writeLines("", fileConn)
close(fileConn)


fileConn<-file("~/youtube_post.txt", "wa")
writeLines(paste0("<center><h1> Dear friends, I am happy to share with you my daily post  </h1></center>"), fileConn)
writeLines(paste0("<center><h1> of my favorite youtube chanels and they last 5 videos </h1></center>"), fileConn)
writeLines(paste0("<center><h3> My favorite chanels are the following </h3></center>"), fileConn)

for(i in 1:length(unique(adat$chanel))){
  writeLines(paste0("<center> [",unique(adat$chanel)[i],"](",unname(unlist(youtube_chanels))[i],"/",")  </center>"), fileConn)
  
  
}

writeLines(paste0("<center><h1> They have a big impact of many cryptotrader, please injoy they videos </h1></center>"), fileConn)
writeLines(paste0("<hr>"), fileConn)
writeLines(paste0("\n"), fileConn)


for(i in 1:length(unique(adat$chanel))){
  writeLines(paste0("<center> [",unique(adat$chanel)[i],"](",unname(unlist(youtube_chanels))[i],"/",")  </center>"), fileConn)
  t <- adat[unique(adat$chanel)[i]==chanel,]
  for(j in 1:nrow(t)){
    writeLines(paste0("<center><h3>",t[j,]$title,"</h3></center>"), fileConn)
    writeLines(paste0("<center><h5>",t[j,]$published,"</h5></center>"), fileConn)
    writeLines(paste0("<center><h5>",t[j,]$video_link,"</h5></center>"), fileConn)
  }
  
}



close(fileConn)





