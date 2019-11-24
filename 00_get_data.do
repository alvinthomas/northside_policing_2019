/*
Create Chapel Hill Police
Author: Alvin G. Thomas, MSPH

Written for Stata14 SE
Created on 2019-10-20
Last Edited 2019-10-31

Copyright (c) 2019 Alvin G. Thomas (https://github.com/alvinthomas).
It is made available under a CC-BY-SA 4.0 International license.
*/

***** PREAMBLE *****
clear all
macro drop _all
set more off

* Start Log File
global DO_NAME = "00_get_data"
agt_log, name($DO_NAME )

*************** BEGIN ***************
*-------------------------------------------------------------
* Read in Arrests
*-------------------------------------------------------------
import excel using "00_data/northside 2014 to 2019.xlsx", firstrow ///
  sheet("arrests") clear

*-------------------------------------------------------------
* Clean variables
*-------------------------------------------------------------

* Male/female sex (only functional form available in dataset)
gen female = sex == "F"
gen male = sex == "M"

foreach i in female male {
  replace `i' = . if !inlist(sex, "M", "F")
}

* Race (based on North Carolina race classification)
gen asian = race == "A"
gen black = race == "B"
gen hispanic = race == "H"
gen native = race == "I"
gen unknown_race = race == "U"
gen white = race == "W"

foreach i in asian black hispanic native unknown_race white {
  replace `i' = . if !inlist(race, "A", "B", "H", "I", "U", "W")
}

gen arrest_date = dofc(date_arr)
format arrest_date %td

gen temp = strltrim(chrgdesc)
replace chrgdesc = temp
drop temp

preserve
gen n = 1
collapse (sum) n=n, by(chrgdesc)
gsort -n
compress
save 00_data/arrest_charges, replace
export excel using "04_tables/arrest_charges.xlsx", firstrow(var) replace
restore

*-------------------------------------------------------------
* Save Product
*-------------------------------------------------------------

drop ObjectID Loc_name Shape
sort case_id

compress
save 00_data/arrests_preprocess, replace
do 01_process_charges
compress
save 00_data/arrests, replace
export excel using "00_data/arrests.xlsx", firstrow(var) replace

*-------------------------------------------------------------
* Read in Incidents
*-------------------------------------------------------------
import excel using "00_data/northside 2014 to 2019.xlsx", firstrow ///
  sheet("incdentslatlong") clear

drop if X == 0

*-------------------------------------------------------------
* Clean variables
*-------------------------------------------------------------

gen report_date_full = clock(date_rept , "MD20Yhm")
gen report_date = dofc(report_date_full)
format report_date %td

rename chrgdesc incidentdesc

gen temp = strltrim(incidentdesc)
replace incidentdesc = temp
drop temp

rename X X_incident
rename Y Y_incident

preserve
gen n = 1
collapse (sum) n=n, by(incidentdesc)
gsort -n
compress
save 00_data/incident_charges, replace
export excel using "04_tables/incident_charges.xlsx", firstrow(var) replace
restore

*-------------------------------------------------------------
* Save Product
*-------------------------------------------------------------

sort inci_id
gen unique_id = _n

compress
save 00_data/incident_preprocess, replace
do 03_process_incidents
compress
save 00_data/incidents, replace
export excel using "00_data/incidents.xlsx", firstrow(var) replace

*-------------------------------------------------------------
* Merge
*-------------------------------------------------------------
use 00_data/incidents, clear
rename inci_id case_id
merge m:m case_id using 00_data/arrests, keep(match) nogen
save 00_data/matched, replace
export excel using "00_data/matched.xlsx", firstrow(var) replace

use 00_data/arrests, clear
append using 00_data/matched, gen(attached)
save 00_data/arrests_append, replace
export excel using "00_data/arrests_append.xlsx", firstrow(var) replace

use 00_data/incidents, clear
rename inci_id case_id
merge m:m case_id using 00_data/arrests, keep(master) nogen
save 00_data/not_matched, replace
gen matched = 0
keep unique_id matched
save 00_data/not_matched_ids, replace
export excel using "00_data/not_matched_ids.xlsx", firstrow(var) replace

use 00_data/incidents, clear
merge 1:1 unique_id using 00_data/not_matched_ids, nogen
replace matched = 1 if missing(matched)
save 00_data/incidents, replace
export excel using "00_data/incidents2.xlsx", firstrow(var) replace

preserve
gen n = 1
collapse (sum) n=n, by(incidentdesc matched)
gsort matched -n
compress
save 00_data/incident_charges_matched, replace
export excel using "04_tables/incident_charges_matched.xlsx", firstrow(var) replace
restore

*************** END *****************

*log close log_$DO_NAME
log close _all
