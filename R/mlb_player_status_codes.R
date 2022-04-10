#' @title **MLB Player Status Codes** 
#' @return Returns a tibble with the following columns
#'  |col_name                   |types     |
#'  |:--------------------------|:---------|
#'  |player_status_code         |character |
#'  |player_status_description  |character |
#' @export
#' @examples \donttest{
#'   mlb_player_status_codes()
#' }
mlb_player_status_codes <- function(){
  
  mlb_endpoint <- mlb_stats_endpoint("v1/playerStatusCodes")
  query_params <- list()
  
  mlb_endpoint <- httr::modify_url(mlb_endpoint, query = query_params)
  
  resp <- mlb_endpoint %>% 
    mlb_api_call()
  player_status_codes <- jsonlite::fromJSON(jsonlite::toJSON(resp), flatten = TRUE)  %>% 
    janitor::clean_names() %>% 
    as.data.frame() %>% 
    dplyr::rename(
      player_status_code = .data$code,
      player_status_description = .data$description)
  
  return(player_status_codes)
}
