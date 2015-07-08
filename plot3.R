#--------------------------------------------------------------------
# plot3:  Generate plot3
#--------------------------------------------------------------------
plot3 <- function()
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
    
    png(file="plot3.png", width=480, height=480, bg="transparent")              # Device is png file
    myplot <- 
    xyplot(Sub_metering_1 + Sub_metering_2 + Sub_metering_3~Time,               # List observations with '+', not as c()
           dataset,   
           xlab="", ylab="Energy sub metering", type="l", 
           col=c("black", "red", "blue"),                                       # Vector of colors
           auto.key=list(corner=c(1,1), lines=T, points=F, border=T),
           scales=scalelist)
    print(myplot)                                                               # Must print for a lattice case.
    dev.off()                                                                   # Turn off device to complete writing
    print("--->--->---> Please check plot3.png in working directory.")
}
