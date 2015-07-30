NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 1
te <- with(NEI, tapply(Emissions, year, sum)) # Total emissions per year
barplot(te)
dev.copy(png, file = "Question1.png")
dev.off()

# Question 2
NEI_Balt <- NEI[NEI$fips == "24510",] # Subset Baltimore out
te2 <- with(NEI_Balt, tapply(Emissions, year, sum)) # Total emissions per year in Baltimore
barplot(te2)
dev.copy(png, file = "Question2.png")
dev.off()