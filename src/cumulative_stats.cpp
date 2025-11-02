#include <Rcpp.h>
using namespace Rcpp;

//' Fast Cumulative Sum with Initial Value
//'
//' This function computes the cumulative sum of a numeric vector with an initial value offset.
//' Implemented in C++ for improved performance.
//'
//' @param x A numeric vector
//' @param initial_value A numeric value to add to all cumulative sums
//' @return A numeric vector of cumulative sums
//' @export
// [[Rcpp::export]]
NumericVector rcpp_cumsum_init(NumericVector x, double initial_value = 0.0) {
  int n = x.size();
  NumericVector result(n);
  double cumsum = 0.0;
  
  for(int i = 0; i < n; i++) {
    cumsum += x[i];
    result[i] = initial_value + cumsum;
  }
  
  return result;
}

//' Fast Cumulative Product with Initial Value
//'
//' This function computes the cumulative product of (1 + x) multiplied by initial value.
//' Implemented in C++ for improved performance.
//'
//' @param x A numeric vector
//' @param initial_value A numeric value to multiply with cumulative products
//' @return A numeric vector of cumulative products
//' @export
// [[Rcpp::export]]
NumericVector rcpp_cumprod_init(NumericVector x, double initial_value = 1.0) {
  int n = x.size();
  NumericVector result(n);
  double cumprod = 1.0;
  
  for(int i = 0; i < n; i++) {
    cumprod *= (1.0 + x[i]);
    result[i] = initial_value * cumprod;
  }
  
  return result;
}

//' Fast Cumulative Minimum with Initial Value
//'
//' This function computes the cumulative minimum of a numeric vector with an initial value offset.
//' Implemented in C++ for improved performance.
//'
//' @param x A numeric vector
//' @param initial_value A numeric value to add to all cumulative minimums
//' @return A numeric vector of cumulative minimums
//' @export
// [[Rcpp::export]]
NumericVector rcpp_cummin_init(NumericVector x, double initial_value = 0.0) {
  int n = x.size();
  NumericVector result(n);
  double cummin = x[0];
  
  for(int i = 0; i < n; i++) {
    if(i == 0) {
      cummin = x[i];
    } else if(x[i] < cummin) {
      cummin = x[i];
    }
    result[i] = initial_value + cummin;
  }
  
  return result;
}

//' Fast Cumulative Maximum with Initial Value
//'
//' This function computes the cumulative maximum of a numeric vector with an initial value offset.
//' Implemented in C++ for improved performance.
//'
//' @param x A numeric vector
//' @param initial_value A numeric value to add to all cumulative maximums
//' @return A numeric vector of cumulative maximums
//' @export
// [[Rcpp::export]]
NumericVector rcpp_cummax_init(NumericVector x, double initial_value = 0.0) {
  int n = x.size();
  NumericVector result(n);
  double cummax = x[0];
  
  for(int i = 0; i < n; i++) {
    if(i == 0) {
      cummax = x[i];
    } else if(x[i] > cummax) {
      cummax = x[i];
    }
    result[i] = initial_value + cummax;
  }
  
  return result;
}

//' Fast Cumulative Mean with Initial Value
//'
//' This function computes the cumulative mean of a numeric vector with an initial value offset.
//' Implemented in C++ for improved performance.
//'
//' @param x A numeric vector
//' @param initial_value A numeric value to add to all cumulative means
//' @return A numeric vector of cumulative means
//' @export
// [[Rcpp::export]]
NumericVector rcpp_cummean_init(NumericVector x, double initial_value = 0.0) {
  int n = x.size();
  NumericVector result(n);
  double cumsum = 0.0;
  
  for(int i = 0; i < n; i++) {
    cumsum += x[i];
    result[i] = initial_value + cumsum / (i + 1);
  }
  
  return result;
}

//' Batch Cumulative Statistics
//'
//' This function computes all cumulative statistics (sum, prod, min, max, mean) 
//' in a single pass for better cache efficiency.
//' Implemented in C++ for improved performance.
//'
//' @param x A numeric vector
//' @param initial_value A numeric value for initial offset
//' @return A numeric matrix with 5 columns: cum_sum, cum_prod, cum_min, cum_max, cum_mean
//' @export
// [[Rcpp::export]]
NumericMatrix rcpp_batch_cumstats(NumericVector x, double initial_value = 0.0) {
  int n = x.size();
  NumericMatrix result(n, 5);
  
  double cumsum = 0.0;
  double cumprod = 1.0;
  double cummin = x[0];
  double cummax = x[0];
  
  for(int i = 0; i < n; i++) {
    // Cumulative sum
    cumsum += x[i];
    result(i, 0) = initial_value + cumsum;
    
    // Cumulative product
    cumprod *= (1.0 + x[i]);
    result(i, 1) = initial_value * cumprod;
    
    // Cumulative minimum
    if(i == 0) {
      cummin = x[i];
    } else if(x[i] < cummin) {
      cummin = x[i];
    }
    result(i, 2) = initial_value + cummin;
    
    // Cumulative maximum
    if(i == 0) {
      cummax = x[i];
    } else if(x[i] > cummax) {
      cummax = x[i];
    }
    result(i, 3) = initial_value + cummax;
    
    // Cumulative mean
    result(i, 4) = initial_value + cumsum / (i + 1);
  }
  
  colnames(result) = CharacterVector::create("cum_sum", "cum_prod", "cum_min", "cum_max", "cum_mean");
  
  return result;
}
