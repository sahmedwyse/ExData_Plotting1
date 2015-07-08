#--------------------------------------------------------------------
# plot2:  Generate plot2
#         Shafiq Ahmed, 7/8/2015
#--------------------------------------------------------------------
plot2 <- function()
{
    #----------------------------------------------------------------(same for all cases)
    # Loading data. Using skip and nrow to read specific lines
    #----------------------------------------------------------------
    inputfile  <- "household_power_consumption.txt"
    if (!file.exists(inputfile))
        inputfile = "exdata-data-household_power_consumption/household_power_consumption.txt"
    if (!file.exists(inputfile))
        return(print("Input file not found. Exited function."))
    
    header <- read.table(inputfile, header=TRUE, sep=";", nrow=1)
    dataset <- read.table(inputfile, header=FALSE, sep=";", skip=66637, nrow=(69517-66637))
    colnames(dataset) <- colnames(header)
    #----------------------------------------------------------------
    
    library("lattice")
    len <- nrow(dataset)
    dataset$Time <- c(1:len)                                                    # To fix duplicity problem of Time
                                                                                # Custom tick marks on x-axis
    scalelist <- list(y=list(rot=90), x=list(at=c(1, len/2, len), label=c("Thu", "Fri", "Sat")))    
    
    png(file="plot2.png", width=480, height=480, bg="transparent")              # (1) device is png file
    myplot <- xyplot(Global_active_power~Time, dataset, 
                     xlab="", ylab="Global Active Power (kilowatts)", type="l", 
                     col="black",
                     scales=scalelist)
    print(myplot)                                                               # Must print for a lattice case.
    # dev.copy(png, file="plot2.png", width=480, height=480)                    # Alternative approach if we do not do (1) above.
    dev.off()                                                                   # Turn off device to complete writing
    print("--->--->---> Please check plot2.png in working directory.")
}
