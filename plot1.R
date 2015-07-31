NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 1: Total emissions have decreased in the United States from 1999 to 2008
te <- with(NEI, tapply(Emissions, year, sum)) # Total emissions per year
barplot(te, main = "Total PM2.5 Emissions from All Sources", yaxt = "n",
        col = "darkblue", xlab = "Year", ylab = "Total Emissions (in million)", font.lab = 2)
axis(2, at = seq(0, 7e6, by = 1e6), labels = seq(0, 7, step = 1))
dev.copy(png, file = "plot1.png")
dev.off()