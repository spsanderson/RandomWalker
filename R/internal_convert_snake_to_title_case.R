# Helper function to convert a snake_case string to Title Case
convert_snake_to_title_case <- function(string) {

  # Replace underscores with spaces to separate words
  string_with_spaces <- gsub("_", " ", string)

  # Replace the substring "cum" with "cumulative" for better readability
  string_with_replaced_strings <- gsub("cum", "cumulative", string_with_spaces)

  # Split the modified string into individual words
  words <- strsplit(string_with_replaced_strings, " ")[[1]]

  # Capitalize the first letter of each word and concatenate them back into a single string
  capitalized_words <- paste(toupper(substring(words, 1, 1)), substring(words, 2), sep = "", collapse = " ")

  # Return the title-cased string
  return(capitalized_words)
}
