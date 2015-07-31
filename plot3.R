NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 3
library(ggplot2, lib.loc = "//R01SFCHSM03.r01.med.va.gov/homedir$/vhasfczouy/My Documents/Coursera/library/")
qplot(x = year, y = Emissions, geom = "bar", stat = "identity", data = NEI_Balt, facets = . ~ type, fill = type)
dev.copy(png, file = "plot3.png")
dev.off()