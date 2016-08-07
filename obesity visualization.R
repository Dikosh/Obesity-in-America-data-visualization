install.packages("rvest")
install.packages("scales")
library(rvest)
library(ggplot2)
library(dplyr)
library(scales)
#��������� ������ ��� ����������
#����� ������ � ���������
obesity <- read_html("https://en.wikipedia.org/wiki/Obesity_in_the_United_States")
obesity=obesity%>%
  html_nodes('table')%>%
  .[[1]]%>%
  html_table(fill=T)
html_
str(obesity)
# ������ ���� ��������, ����� ������� ������ ���������
for(i in 2:4){
  obesity[,i]=gsub('%','',obesity[,i])
  obesity[,i]=as.numeric(obesity[,i])
}
# ������ ������� � ���������
names(obesity)  
names(obesity) = make.names(names(obesity))
# MAP
states=map_data("state")
str(states)
plot(states)
obesity$region=tolower(obesity$State.and.District.of.Columbia) # tolower ������ ��� ���������� �������

states=merge(states,obesity,by="region",all.x=T)
#������������� ������
ggplot(states, aes(x = long, y = lat, group = group, fill = Obese.adults)) + 
  geom_polygon(color = "white") +
  scale_fill_gradient(name = "Percent", low = "#feceda", high = "#c81f49", guide = "colorbar", na.value="black", breaks = pretty_breaks(n = 5)) +
  labs(title="�������� ��������") +
  coord_map()
