NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 3
# Useful link: http://docs.ggplot2.org/current/scale_continuous.html
library(ggplot2, lib.loc = "//R01SFCHSM03.r01.med.va.gov/homedir$/vhasfczouy/My Documents/Coursera/library/")
png(filename = "plot3.png", height = 600, width = 1200)
NEI_Balt <- NEI[NEI$fips == "24510",] # Subset Baltimore out
        g <- ggplot(NEI_Balt, aes(x = year, y = Emissions, fill = type))
        g <- g + geom_bar(stat = "identity") + facet_grid(~ type)
        g <- g + ggtitle("Total PM2.5 Emissions in Baltimore City by different Types of Sources")
        g <- g + scale_y_continuous("Total Emissions") + scale_x_continuous("Year", breaks = c(1999, 2002, 2005, 2008)) 
        g <- g + theme(title = element_text(face="bold", size = 18), axis.title.x = element_text(face="bold", size = 16), axis.title.y = element_text(face="bold", size = 16))
        g
dev.off()