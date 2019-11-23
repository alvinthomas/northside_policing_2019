capture program drop agt_log

program agt_log
  syntax, name(str)

  capture log close _all // Close any open log files

  local cur date(c(current_date), "DMY") // Create a Date Object
  local y = year(`cur')  // Grab the year
  local m = month(`cur') // Grab the month
  local d = day(`cur') // Grab the day
  if `m' < 10 {
  	local m = "0`m'" // Add a 0 to single-digit months
  }
  if `d' < 10 {
  	local d = "0`d'" // Add a 0 to single-digit days
  }
  local filedate = "`y'`m'`d'" // Combine into a single macro

  local now = subinstr("`c(current_time)'", ":", "", .)
  local timestamp `filedate'T`now'

  * Create a log file with the date in the filename
  log using 01_logs/`name'_`timestamp'.txt, text replace name(log_`name')

end
