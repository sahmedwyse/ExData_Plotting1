#--------------------------------------------------------------------
# plot4:  Generate plot4
#--------------------------------------------------------------------
plot4 <- function()
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
    
    png(file="plot4.png", width=480, height=480, bg="transparent")              # Device is png file. (1)

    
    p1 <- xyplot(Global_active_power~Time, dataset, xlab=" ", ylab="Global Active Power", type="l", col="black", scales=scalelist)
    
    p2 <- xyplot(Voltage~Time, dataset, xlab="datetime", ylab="Voltage", type="l", col="black", scales=scalelist)
    
    p3 <- xyplot(Sub_metering_1 + Sub_metering_2 + Sub_metering_3~Time, 
           dataset, xlab=" ", ylab="Energy sub metering", type="l", 
           col=c("black", "red", "blue"),
           auto.key=list(corner=c(1,1), lines=T, points=F, border=T), scales=scalelist)
    
    p4 <- xyplot(Global_reactive_power~Time, dataset, xlab="datetime",  type="l", col="black", scales=scalelist)
    
    print(p1, position=c(0,.5,.5,1), more=TRUE)
    print(p2, position=c(.5,.5,1,1), more=TRUE)
    print(p3, position=c(0,0,.5,.5), more=TRUE)
    print(p4, position=c(.5,0,1,.5), more=FALSE)
    
    dev.off()
    print("--->--->---> Please check plot4.png in working directory.")
}
