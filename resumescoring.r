# Install necessary packages if not already installed
if (!require("textclean")) {
  install.packages("textclean")
  library(textclean)
}

if (!require("tm")) {
  install.packages("tm")
  library(tm)
}

# Function to preprocess text (remove stopwords, punctuation, etc.)
preprocess_text <- function(text) {
  text <- tolower(text)  # Convert to lowercase
  text <- gsub("[[:punct:]]", "", text)  # Remove punctuation using gsub
  text <- gsub("[[:digit:]]", "", text)  # Remove numbers
  
  # Remove stopwords using tm's stopwords function
  stop_words <- stopwords("en")
  text <- unlist(strsplit(text, " "))  # Split text into words
  text <- text[!text %in% stop_words]  # Remove stopwords
  text <- paste(text, collapse = " ")  # Recombine words into a single string
  
  text <- stripWhitespace(text)  # Remove extra whitespaces
  return(text)
}

# Function to extract text from the resume PDF
extract_resume_text <- function(resume_file) {
  # Load the pdftools package if not already loaded
  if (!require("pdftools")) {
    install.packages("pdftools")
    library(pdftools)
  }
  
  resume_text <- pdf_text(resume_file)
  resume_text <- paste(resume_text, collapse = " ")  # Combine all pages into one string
  return(resume_text)
}

# Example job description
job_description <- "Data Scientist needed with skills in Python, Machine Learning, and Deep Learning.
Must have experience in developing predictive models, working with large datasets, and using data visualization tools."

# Preprocess the job description
job_description_clean <- preprocess_text(job_description)

# Set the file path for the resume (Update path to your file location)
resume_file <- "C:/Users/hp/Downloads/Sample.pdf"  #Add a resume (pdf)

# Extract text from the resume PDF
resume_text <- extract_resume_text(resume_file)

# Preprocess the resume text
resume_text_clean <- preprocess_text(resume_text)

# Print the cleaned resume text for verification (optional)
print("Cleaned Resume Text:")
print(resume_text_clean)

# Install and load the textTinyR package for COS_TEXT function if not already installed
if (!require("textTinyR")) {
  install.packages("textTinyR")
  library(textTinyR)
}

# Use textTinyR's COS_TEXT to compute the cosine similarity
similarity_score <- COS_TEXT(text_vector1 = job_description_clean, text_vector2 = resume_text_clean)

# Convert similarity score to percentage
similarity_score_percentage <- similarity_score * 100

# Output the similarity score
print(paste("Resume Score:", round(similarity_score_percentage, 2), "/10"))
