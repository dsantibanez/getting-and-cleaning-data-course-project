##load data.table library
library(data.table)

##read in R all the files needed for the project
x_test<-read.table("./UCI HAR Dataset/test/X_test.txt", header=F)
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt", header=F)
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt", header=F)
x_train<-read.table("./UCI HAR Dataset/train/X_train.txt", header=F)
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt", header=F)
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt", header=F)
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt", header=F)
features<-read.table("./UCI HAR Dataset/features.txt", header=F)

##calculate the dimension of them in order to see the way they match to create one unique data frame. Self use.
dim(x_test)
dim(y_test)
dim(subject_test)
dim(x_train)
dim(y_train)
dim(subject_train)
dim(features)
dim(activity_labels)

##add columns from severa data frames to get the unique one requested
y_x_train<-cbind(y_train,x_train)
y_x_test<-cbind(y_test,x_test)
subject_y_x_train<-cbind(subject_train,y_x_train)
subject_y_x_test<-cbind(subject_test,y_x_test)

##rename column names to be human easily understandable
colnames(subject_y_x_train)[1] <- "subject"
colnames(subject_y_x_train)[2] <- "activity"
colnames(subject_y_x_test)[1] <- "subject"
colnames(subject_y_x_test)[2] <- "activity"

##add into one data frame all rows from all previous data frames created
table_train_test<-rbind(subject_y_x_train,subject_y_x_test)

##subset the data frame to get only the columns requested in the project 
##(explanation in the codebook/README)
table_mean_std<-table_train_test[,c("subject","activity","V1","V2","V3","V4","V5","V6","V41","V42","V43","V44","V45","V46","V81","V82","V83","V84","V85","V86","V121","V122","V123","V124","V125","V126","V161","V162","V163","V164","V165","V166","V201","V202","V214","V215","V227","V228","V240","V241","V254","V255","V266","V267","V268","V269","V270","V271","V294","V295","V296","V345","V346","V347","V348","V349","V350","V373","V374","V375","V424","V425","V426","V427","V428","V429","V452","V453","V454","V503","V504","V513","V516","V517","V526","V529","V530","V539","V542","V543","V552","V556","V557","V558","V559","V560","V561")]

##rename activity column in order to be easily understandable by humans as requested in the
##exercise.(explanation in the codebook/README)
n_rows<-nrow(table_mean_std)
table_mean_std$activity<-as.character(table_mean_std$activity)
for(i in 1:n_rows){
        if(table_mean_std[i,"activity"]==1){
                table_mean_std[i,"activity"]<-"WALKING"
        }else if(table_mean_std[i,"activity"]==2){
                table_mean_std[i,"activity"]<-"WALKING_UPSTAIRS"
        }else if(table_mean_std[i,"activity"]==3){
                table_mean_std[i,"activity"]<-"WALKING_DOWNSTAIRS"
        }else if(table_mean_std[i,"activity"]==4){
                table_mean_std[i,"activity"]<-"SITTING"
        }else if(table_mean_std[i,"activity"]==5){
                table_mean_std[i,"activity"]<-"STANDING"
        }else {table_mean_std[i,"activity"]<-"LAYING"
        }
}

##rename all Vx columns in order to be easily understandable by humans as requested in the
##exercise.(explanation in the codebook/README)
features$V2<-as.character(features$V2)
table_col_names<-names(table_mean_std)
for(i in table_col_names){
        if(substring(names(table_mean_std[i]),1,1)=="V"){
                num_V<-substring(names(table_mean_std[i]),2)
                colnames(table_mean_std)[colnames(table_mean_std)==i]<-features[num_V,"V2"]
        }
}

##create a data frame gruping by subject and activity and calculating the mean of the
##rest of values.(explanation in the codebook/README)
DT<-data.table(table_mean_std)
table_mean_std_grouped<-DT[,lapply(.SD, mean, na.rm=TRUE),by=list(subject,activity)]

##create a txt file with the information of table_mean_std_grouped
write.table(table_mean_std_grouped,"tidy_dataset.txt",row.name=FALSE)
