
# Install/load required packages
if (!require("rvest")) install.packages("rvest")
if (!require("stringr")) install.packages("stringr")
if (!require("httr")) install.packages("httr")

library(rvest)
library(stringr)
library(httr)

# --- Configuration ---
# <<!! SET YOUR DESTINATION FOLDER HERE !!>>
destination_folder <- "E:/ALS_Datasets/lidar_zh_2014" # Saves to a subfolder in your project
base_url <- "https://maps.zh.ch/download/hoehen/2014/lidar/"


# --- 2. GET FILENAMES AND PREPARE FOLDER ---

# Create destination folder if needed
if (!dir.exists(destination_folder)) {
  cat("Creating destination folder:", destination_folder, "\n")
  dir.create(destination_folder, recursive = TRUE)
}

# Scrape filenames from the URL
cat("Getting file list from server...\n")
tryCatch({
  page_content <- read_html(base_url)
  laz_filenames <- page_content %>%
    html_nodes("a") %>%
    html_attr("href") %>%
    str_subset("\\.laz$")
  
  if (length(laz_filenames) == 0) {
    stop("No .laz files found at the URL.")
  }
}, error = function(e) {
  stop("Could not access or parse the URL. ", e$message)
})


# --- 3. DOWNLOAD FILES WITH PROGRESS & SIZE CHECK ---

total_files <- length(laz_filenames)
cat(sprintf("Found %d LAZ files. Starting download/verification...\n", total_files))

start_time <- Sys.time()
pb <- txtProgressBar(min = 0, max = total_files, style = 3, width = 50, char = "=")

# Loop through each file
for (i in 1:total_files) {
  filename <- laz_filenames[i]
  file_url <- paste0(base_url, filename)
  dest_path <- file.path(destination_folder, filename)
  
  # Check if local file exists
  if (file.exists(dest_path)) {
    # If it exists, check its size against the server's file size
    local_size <- file.info(dest_path)$size
    
    # Use a HEAD request to get remote file size without downloading
    response <- try(HEAD(file_url), silent = TRUE)
    
    # Check if the HEAD request was successful and get the size
    if (!inherits(response, "try-error") && response$status_code == 200) {
      remote_size <- as.numeric(headers(response)$`content-length`)
      
      # If sizes match, skip the download
      if (!is.na(remote_size) && local_size == remote_size) {
        setTxtProgressBar(pb, i) # Update progress bar
        next # Move to the next file
      }
    }
    # If sizes don't match or HEAD request failed, it will re-download below
  }
  
  # Download the file (only runs if file doesn't exist or size is wrong)
  tryCatch({
    download.file(url = file_url, destfile = dest_path, mode = "wb", quiet = TRUE)
  }, error = function(e) {
    # Handle download errors for individual files
    cat(sprintf("\n[ERROR] Failed to download %s. Skipping. Error: %s\n", filename, e$message))
  })
  
  # Update progress
  setTxtProgressBar(pb, i)
}

close(pb)


# --- 4. FINAL REPORT ---
end_time <- Sys.time()
duration <- round(end_time - start_time, 2)

cat("\n\n--- Download Complete ---\n")
cat(sprintf("Total files processed: %d\n", total_files))
cat(sprintf("Data saved to: %s\n", normalizePath(destination_folder)))
cat(sprintf("Total time taken: %s\n", format(duration)))