#--------------------------------------------------------------------
# plot1:  Generate plot1
#--------------------------------------------------------------------
plot1 <- function()
{
    #----------------------------------------------------------------(same for all cases)
    # Loading data. Using skip and nrow to read specific lines
    #----------------------------------------------------------------
    inputfile  <- "household_power_consumption.txt"
    if (!file.exists(inputfile))
        inputfile = "exdata-data-household_power_consumption/household_power_consumption.txt"
    if (!file.exists(inputfile))
        return(print("Input file not found. Exited function."))

    header  <- read.table(inputfile, header=TRUE, sep=";", nrow=1)
    dataset <- read.table(inputfile, header=FALSE, sep=";", skip=66637, nrow=(69517-66637))
    colnames(dataset) <- colnames(header)
    #----------------------------------------------------------------

    gblap <- dataset[,3]
    png(file="plot1.png", width=480, height=480, bg="transparent")
    myplot <- hist(gblap, col="red", breaks=12, xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power")
    dev.off()
    print("--->--->---> Please check plot1.png in working directory.")
}
