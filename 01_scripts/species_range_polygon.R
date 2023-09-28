#Using the R package robis to query the Ocean Biodiversity Information System (OBIS) dataset to retrieve occurrence records of marine organisms. https://obis.org/
#The OBIS database holds more than 135 000 marine species. We can access the database using the package robis. The package allows for downloading data using the species name and filtering for "flags," which are implemented after a QC algorithm in the data.OBIS harvests occurrence records from thousands of datasets and makes them available as a single integrated dataset

remotes::install_github("iobis/robis")
library(robis)
library(tidyverse)
library(writexl)

#Reading the file with the priority species that it is saved in the project folder.  
sps <- read.csv("FACT_DaViT_Species_20230412.csv")

#Creating a list where each element contains a species name (a row of the data frame). This is useful to itearate over each element of the list using the apply family fucntions. 

spsList <- split(sps$scientificname, seq(nrow(sps)))

#Changing name to ease indexing steps

names(spsList) <- sps$scientificname.

#Retriving occurrence data for each species in the list. Here, we can index the number of species we want to download data for. The occurrence function from the package robis uses taxonomic information including scientific name to retrieve the occurrence records from the OBIS dataset. 

spsOcurren <- lapply(spsList, occurrence)

#The data downloaded is 4.4GB and the file is saved to the data folder in the project. There is no record for 5 sps and others have a small number of observations.  For 148 sps the code ran overnight without errors.
#It is in a list format. Writing data, in txt, csv or Excel file formats, is the best solution if you want to open these files with other analysis software, such as Excel. However this solution doesn’t preserve data structures, such as column data types (numeric, character or factor). In order to do that, the data should be written out in R data format (http://www.sthda.com/english/wiki/saving-data-into-r-data-format-rds-and-rdata). I will save the file as R data format and as a csv file. 

saveRDS(spsOcurren, "spsOcurren.rds")

#Saving as an Excel file 

write_xlsx(spsOcurren, "spsOcurren.xlsx")

##### 
#installing packages for markdown document
install.packages("rmarkdown")
install.packages("trackdown")

# to be able to create PDF documents we need a LaTeX distribution installed. One
# is not installed by default with rmarkdown.One that works well across OSs is
# tinytex but it needs a second step to complete the installation. First install
# tinytex as usual
install.packages("tinytex")

# now run the internal tinytex installer. This can take some time to install
tinytex::install_tinytex()
sf_grid_more10 <- st_read ("sf_grid_more10.shp")
