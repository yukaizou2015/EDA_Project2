NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 6
NEI_BL <- NEI[NEI$fips == "24510" | NEI$fips == "06037",] # Subset Baltimore and LA out
SCC_MC <- SCC[SCC$SCC.Level.Three == "Motorcycles (MC)", ]
# Query from NEI inner join SCC_Coal on SCC is equal
join_string3 <- "select NEI_BL.SCC, NEI_BL.fips, NEI_BL.Emissions, NEI_BL.year, SCC_MC.SCC,
                                SCC_MC.[EI.Sector], SCC_MC.[SCC.Level.Three] from NEI_BL inner join SCC_MC on
                                NEI_BL.SCC = SCC_MC.SCC"
Query6 <- sqldf(join_string3, stringsAsFactors = FALSE)
g <- ggplot(data = Query6, aes(x = year, y = Emissions))
g <- g + geom_bar(aes(fill = fips), stat = "identity", position = position_dodge())
g <- g + scale_fill_discrete(name="Location", labels = c("Baltimore City", "Los Angeles County"))
g
dev.copy(png, file = "plot6.png")
dev.off()