
print(example_data_1_subject)
write.csv(example_data_1_subject, "output.csv")
library(iglu)
data(package = "iglu")
print(example_data_hall)
print(n=1)

library(dplyr)

# Load the data
df <- read.csv("example_data_hall.csv", header = FALSE, stringsAsFactors = FALSE)
colnames(df) <- c("ID", "Timestamp", "Value", "Condition")  # Adjust column names if needed

# Check how many unique subjects exist
unique_subjects <- unique(df$ID)
print(length(unique_subjects))  # Should return 19

# Split the data by subject
subject_list <- split(df, df$ID)

# Save each subject's data as a separate CSV
for (subject in names(subject_list)) {
  write.csv(subject_list[[subject]], paste0("subject_", subject, ".csv"), row.names = FALSE)
}

# Example: Access data for subject "1636-69-026"
subject_026 <- subject_list[["1636-69-026"]]

# View the first few rows
head(subject_026)


