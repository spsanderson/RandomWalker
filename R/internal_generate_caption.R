# Helper function to generate a caption string based on provided attributes
generate_caption <- function(attributes) {

  # Initialize an empty vector to hold parts of the caption
  parts <- c()

  # Check if 'dimension' attribute is not NULL and add it to 'parts'
  if (!is.null(attributes$dimension)) {
    parts <- c(parts, paste0(attributes$dimension, " dimensions"))
  }

  # Check if 'num_steps' attribute is not NULL and add it to 'parts'
  if (!is.null(attributes$num_steps)) {
    parts <- c(parts, paste0(attributes$num_steps, " steps"))
  }

  # Check if 'mu' attribute is not NULL and add it to 'parts'
  if (!is.null(attributes$mu)) {
    parts <- c(parts, paste0("mu = ", attributes$mu))
  }

  # Check if 'sd' attribute is not NULL and add it to 'parts'
  if (!is.null(attributes$sd)) {
    parts <- c(parts, paste0("sd = ", attributes$sd))
  }

  # Combine all parts into a single string with commas separating them
  caption <- paste(parts, collapse = ", ")

  # If the caption is not an empty string, append a period at the end
  if (caption != "") {
    caption <- paste0(caption, ".")
  }

  # Return the generated caption
  return(caption)
}
