library(jsonlite)

youtube_chanels <- list(
  "Suppoman" = " https://www.youtube.com/channel/UCCmJln4C_CszIusbJ_MHmfQ", 
  "datadash" =  "https://www.youtube.com/channel/UCCatR7nWbYrkVXdxXb4cGXw", 
  "boxmining" = "https://www.youtube.com/channel/UCxODjeUwZHk3p-7TU-IsDOA"
)
my_list <- sapply(strsplit(unname(unlist(youtube_chanels)), 'channel/'), "[[", 2)

get_names <- function(ch_id){
  
  adat <-fromJSON(paste0("https://www.googleapis.com/youtube/v3/search?key=AIzaSyDpC0t4WEA6DOLJqssDyHvEZodxWmgXEFQ&channelId=",ch_id,"&part=snippet,id&order=date&maxResults=50"))
  return(as.character(adat$items$snippet$title))
}

a<- unlist(lapply(my_list, get_names))
