#echo "id,date,hour,command1,command2,command3,command4,command5" >raw.csv
#awk '{$1=$1}1' OFS="," < input.txt > raw.csv 

library(dplyr)
library(ggplot2)

setwd('/home/gil_diy/myGitRepositories/stats-my-workflow')
input_rawdf = read.csv("raw-data-sample.csv")
input <- mutate(input_rawdf, date_command = paste(date, command1))

groups <-input %>%
  group_by(date_command) %>%
  summarise(usageCount = length(date_command)) 

list_words = lapply(groups$date_command, function(word){strsplit(word, " ")[[1]][2]})
numberOfBars = length(list_words)

df_groups <- as.data.frame(groups)[1:30,]
# Option #1: using barplot function
# ==================================
#barplot(groups$usageCount, main="Commands distribution", xlab="Number of Gears", xlim=c(0,133))
# ,names.arg = list_words, las=2
#
#horizontal_axis = 133
#x_vector = seq(1,horizontal_axis ,by = (horizontal_axis / numberOfBars))
#text(x_vector, groups$usageCount, list_words)


# Option #2: using ggplot function
# ==================================
ggplot(data=df_groups, aes(x=date_command, y=usageCount)) +
  geom_bar(stat="identity", fill="steelblue")+
  geom_text(aes(label=usageCount), vjust=-0.3, size=3.5)+
  theme_minimal()
