NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 1
te <- with(NEI, tapply(Emissions, year, sum)) # Total emissions per year
barplot(te)
dev.copy(png, file = "plot1.png")
dev.off()