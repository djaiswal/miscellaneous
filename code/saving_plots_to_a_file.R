


# Assume that we have a main directory (miscellaneous - name of the git repository) 
# absolute path ""C:/Users/Public/Documents/gitprojects/miscellaneous"
# Inside the man direcotry we have three subdirectory
# 1. code
# 2. data
# 3. results
# 4. figures
# The names of the subdirectories are self explanatory. 
# This file (you are currently reading) is stored in the subdirectory code


# Finding location of the current r script
library(this.path) 
current_directory_of_plotting_script <- this.path::this.dir()


# We have a data file in the subdirectory data. 
# The name of the data file is input.csv and it contains two columns X and Y.

# To read this file we can use current_directory_of_plotting_script and relative paths as below
inputfile <- paste(current_directory_of_plotting_script,"/../data/input.csv", sep="")
inputdata <- read.csv(inputfile)

# We want to do some analyses and create a new variable (z) that is multiplication of x and y.
# we can do this as below
inputdata$z = inputdata$x*inputdata$y

# visualize data frame inputdata (not is has three variables x, y, z)
# We want to save new data frame (with variable z) in a new file output.csv 
# and save output.csv in the folder results.
outputfile <- paste(current_directory_of_plotting_script,"/../results/output.csv", sep="")
write.csv(inputdata, file=outputfile, row.names = FALSE)

## I want to make a plot of new variable z versus x
plot(inputdata$y ~ inputdata$x) # This will show a plot in Rstudio 

# If I want to store the same figure in a file, I need to change the display.
# The complete list is here (https://stat.ethz.ch/R-manual/R-devel/library/grDevices/html/Devices.html)

# To save plot as a jpeg file in the subfolder figures
plotfilename <- paste(current_directory_of_plotting_script,"/../figures/plot1.jpeg", sep="")

#step 1 open the jpeg graphical device
jpeg(filename = plotfilename)
#step 2 plot
plot(inputdata$z ~ inputdata$x) # This will show a plot in Rstudio 
# step 3 close the graphical device
dev.off()

# You can change color, dimension and many features of the plot
# for all option type $jpeg and you will see all options on R help


# I like to ggplot to save figures in a file. By default it looks very nice
library(ggplot2)
ggplot_figure <- ggplot(data=inputdata) + geom_path(aes(x = x, y= z))
plot(ggplot_figure)

# To save this plot inside figures folder, I can use ggsave function (file extension can be pdf, jpeg,..)
plotfilename <- plotfilename <- paste(current_directory_of_plotting_script,"/../figures/plot2.pdf", sep="")
ggsave(file=plotfilename, plot=ggplot_figure)

#No need to use dev.off here
# type ? ggaave to see a whole list of options to make the graphics pretty

