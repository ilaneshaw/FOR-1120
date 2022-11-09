
### THIS DOCUMENT CAN BE USED TO RANDOMLY ASSIGN STUDENTS A QUADRAT NUMBER AND TWO BACKUPS ###

#as input, it expects 
#1) a csv file where the first column is a list of all the student names in the format "LastName, FirstName", with no header
#2) a kml file of quadrats, each with a unique Name

#input studentList
studentList <- read.csv(paste0(getwd(), "/studentList.csv"), header = FALSE)
colnames(studentList) <- c("Nom", "Prenom")
noStudents <- length(studentList$Nom)
noQuadratsNeeded <- noStudents*3

#input quadrat file
library(sf)
quadrats <- read_sf(paste0(getwd(), "/Quadrat.kml"))
listFID <- quadrats$Name

#make 3 random samples of quadrats, without replacement
sampledQuadrats <- sample(listFID, size = noQuadratsNeeded, replace = FALSE)
sampledQuadrats <- split(sampledQuadrats,   ceiling(seq_along(sampledQuadrats) / noStudents))
names(sampledQuadrats) <- c("FID", "Alt1", "Alt2")

#make final table and save it
sampledQuadrats <- as.data.frame(do.call(cbind, sampledQuadrats))
repartitionPlacettes <- as.data.frame(cbind(studentList, sampledQuadrats))
write.csv(repartitionPlacettes, paste0(getwd(), "/repartitionPlacettes"), row.names = FALSE)

