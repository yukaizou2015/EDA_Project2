NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 2 Total emissions from PM2.5 in Baltimore City have fluctuated from 2002 to 2005 but in general decreased from 1999 to 2008.
NEI_Balt <- NEI[NEI$fips == "24510",] # Subset Baltimore out
te2 <- with(NEI_Balt, tapply(Emissions, year, sum)) # Total emissions per year in Baltimore
barplot(te2, col = "darkgreen", main = "Total PM2.5 Emissions in Baltimore City", xlab = "Year", ylab = "Total Emissions", font.lab = 2)
dev.copy(png, file = "plot2.png")
dev.off()