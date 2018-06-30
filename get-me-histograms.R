#echo "id,date,hour,command1,command2,command3,command4,command5" >raw.csv
#awk '{$1=$1}1' OFS="," < input.txt > raw.csv 

library(dplyr)

setwd('/home/gil_diy/myGitRepositories/stats-my-workflow')
input_rawdf = read.csv("raw.csv")
input <- mutate(input_rawdf, date_command = paste(date, command1)) 

groups <-input %>%
  group_by(date_command) %>%
  summarise(usageCount = length(date_command)) 

list_words = lapply(groups$date_command, function(word){strsplit(word, " ")[[1]][2]})
numberOfBars = length(list_words)

barplot(groups$usageCount, main="Commands distribution", xlab="Number of Gears", xlim=c(0,133))
# ,names.arg = list_words, las=2

horizontal_axis = 133
x_vector = seq(1,horizontal_axis ,by = (horizontal_axis / numberOfBars))

text(x_vector, groups$usageCount, list_words)