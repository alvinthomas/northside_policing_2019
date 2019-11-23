/*
Arrest Tables
Author: Alvin G. Thomas, MSPH

Written for Stata14 SE
Created on 2019-11-07
Last Edited 2019-11-07

Copyright (c) 2019 Alvin G. Thomas (https://github.com/alvinthomas).
It is made available under a CC-BY-SA 4.0 International license.
*/

***** PREAMBLE *****
clear all
macro drop _all
set more off

* Start Log File
global DO_NAME = "02_charge_table"
agt_log, name($DO_NAME )

*************** BEGIN ***************
*-------------------------------------------------------------
* Initialize
*-------------------------------------------------------------
use 00_data/arrests, clear

* Restrictions

* Initialize
putexcel set 04_tables/table_arrest_charge, replace

capture program drop pval
program define pval, rclass
  args p
  local result = `p'
  if `p' < 1 {
    local result = string(`p', "%4.1f")
  }
  if `p' < 0.1 {
    local result = string(`p', "%4.2f")
  }
  if `p' < 0.05 {
    local result = string(`p', "%4.3f")
  }
  if `p' < 0.045 {
    local result = string(`p', "%4.2f")
  }
  if `p' < 0.01 {
    local result = cond(`p' < 0.01, "<0.01", string(`p', "%4.2f"))
  }
  if `p' < 0.001 {
    local result = cond(`p' < 0.001, "<0.001", string(`p', "%4.3f"))
  }
  return local p `"`result'"'
end

gen age_cat = .
replace age_cat = 1 if inrange(age, 16, 22)
replace age_cat = 2 if inrange(age, 23, 30)
replace age_cat = 3 if inrange(age, 31, 40)
replace age_cat = 4 if inrange(age, 41, 50)
replace age_cat = 5 if inrange(age, 51, 60)
replace age_cat = 6 if inrange(age, 61, 70)
replace age_cat = 7 if inrange(age, 71, 80)

gen age_cat1 = age_cat == 1
gen age_cat2 = age_cat == 2
gen age_cat3 = age_cat == 3
gen age_cat4 = age_cat == 4
gen age_cat5 = age_cat == 5
gen age_cat6 = age_cat == 6
gen age_cat7 = age_cat == 7

replace age_cat1 = . if missing(age)
replace age_cat2 = . if missing(age)
replace age_cat3 = . if missing(age)
replace age_cat4 = . if missing(age)
replace age_cat5 = . if missing(age)
replace age_cat6 = . if missing(age)
replace age_cat7 = . if missing(age)

*-------------------------------------------------------------
* Headers
*-------------------------------------------------------------
local row = 1

quietly sum arrest_charge_alcohol, detail
putexcel B`row' = "`r(sum)'"

putexcel A`row' = "Alcohol-related Arrest (N=`r(sum)')", bold
putexcel B`row' = "%", bold
putexcel C`row' = "N", bold

local row = `row' + 1

*-------------------------------------------------------------
* Alcohol
*-------------------------------------------------------------
putexcel A`row' = "Race/Ethnicity"
local row = `row' + 1

putexcel A`row' = "Black"

quietly sum black if arrest_charge_alcohol==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "White"

quietly sum white if arrest_charge_alcohol==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Hispanic"

quietly sum hispanic if arrest_charge_alcohol==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Asian"

quietly sum asian if arrest_charge_alcohol==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Native"

quietly sum native if arrest_charge_alcohol==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Unknown Race/Ethnicity"

quietly sum unknown_race if arrest_charge_alcohol==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Sex"
local row = `row' + 1

putexcel A`row' = "Female"

quietly sum female if arrest_charge_alcohol==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Male"

quietly sum male if arrest_charge_alcohol==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age"
local row = `row' + 1

putexcel A`row' = "Age 16-22"

quietly sum age_cat1 if arrest_charge_alcohol==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 23-30"

quietly sum age_cat2 if arrest_charge_alcohol==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 31-40"

quietly sum age_cat3 if arrest_charge_alcohol==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 41-50"

quietly sum age_cat4 if arrest_charge_alcohol==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 51-60"

quietly sum age_cat5 if arrest_charge_alcohol==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 61-70"

quietly sum age_cat6 if arrest_charge_alcohol==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 71-80"

quietly sum age_cat7 if arrest_charge_alcohol==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

*-------------------------------------------------------------
* Headers
*-------------------------------------------------------------
quietly sum arrest_charge_drug, detail
putexcel B`row' = "`r(sum)'"

putexcel A`row' = "Drug-related Arrest (N=`r(sum)')", bold
putexcel B`row' = "%", bold
putexcel C`row' = "N", bold

local row = `row' + 1

*-------------------------------------------------------------
* Drug
*-------------------------------------------------------------
putexcel A`row' = "Race/Ethnicity"
local row = `row' + 1

putexcel A`row' = "Black"

quietly sum black if arrest_charge_drug==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "White"

quietly sum white if arrest_charge_drug==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Hispanic"

quietly sum hispanic if arrest_charge_drug==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Asian"

quietly sum asian if arrest_charge_drug==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Native"

quietly sum native if arrest_charge_drug==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Unknown Race/Ethnicity"

quietly sum unknown_race if arrest_charge_drug==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Sex"
local row = `row' + 1

putexcel A`row' = "Female"

quietly sum female if arrest_charge_drug==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Male"

quietly sum male if arrest_charge_drug==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age"
local row = `row' + 1

putexcel A`row' = "Age 16-22"

quietly sum age_cat1 if arrest_charge_drug==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 23-30"

quietly sum age_cat2 if arrest_charge_drug==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 31-40"

quietly sum age_cat3 if arrest_charge_drug==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 41-50"

quietly sum age_cat4 if arrest_charge_drug==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 51-60"

quietly sum age_cat5 if arrest_charge_drug==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 61-70"

quietly sum age_cat6 if arrest_charge_drug==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 71-80"

quietly sum age_cat7 if arrest_charge_drug==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

*-------------------------------------------------------------
* Headers
*-------------------------------------------------------------
quietly sum arrest_charge_victimless, detail
putexcel B`row' = "`r(sum)'"

putexcel A`row' = "Victimless Crime Arrest (N=`r(sum)')", bold
putexcel B`row' = "%", bold
putexcel C`row' = "N", bold

local row = `row' + 1

*-------------------------------------------------------------
* Victimless
*-------------------------------------------------------------
putexcel A`row' = "Race/Ethnicity"
local row = `row' + 1

putexcel A`row' = "Black"

quietly sum black if arrest_charge_victimless==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "White"

quietly sum white if arrest_charge_victimless==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Hispanic"

quietly sum hispanic if arrest_charge_victimless==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Asian"

quietly sum asian if arrest_charge_victimless==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Native"

quietly sum native if arrest_charge_victimless==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Unknown Race/Ethnicity"

quietly sum unknown_race if arrest_charge_victimless==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Sex"
local row = `row' + 1

putexcel A`row' = "Female"

quietly sum female if arrest_charge_victimless==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Male"

quietly sum male if arrest_charge_victimless==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age"
local row = `row' + 1

putexcel A`row' = "Age 16-22"

quietly sum age_cat1 if arrest_charge_victimless==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 23-30"

quietly sum age_cat2 if arrest_charge_victimless==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 31-40"

quietly sum age_cat3 if arrest_charge_victimless==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 41-50"

quietly sum age_cat4 if arrest_charge_victimless==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 51-60"

quietly sum age_cat5 if arrest_charge_victimless==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 61-70"

quietly sum age_cat6 if arrest_charge_victimless==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 71-80"

quietly sum age_cat7 if arrest_charge_victimless==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1


*-------------------------------------------------------------
* Headers
*-------------------------------------------------------------
quietly sum arrest_charge_dui, detail
putexcel B`row' = "`r(sum)'"

putexcel A`row' = "DUI Arrest (N=`r(sum)')", bold
putexcel B`row' = "%", bold
putexcel C`row' = "N", bold

local row = `row' + 1

*-------------------------------------------------------------
* DUI
*-------------------------------------------------------------
putexcel A`row' = "Race/Ethnicity"
local row = `row' + 1

putexcel A`row' = "Black"

quietly sum black if arrest_charge_dui==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "White"

quietly sum white if arrest_charge_dui==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Hispanic"

quietly sum hispanic if arrest_charge_dui==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Asian"

quietly sum asian if arrest_charge_dui==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Native"

quietly sum native if arrest_charge_dui==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Unknown Race/Ethnicity"

quietly sum unknown_race if arrest_charge_dui==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Sex"
local row = `row' + 1

putexcel A`row' = "Female"

quietly sum female if arrest_charge_dui==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Male"

quietly sum male if arrest_charge_dui==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age"
local row = `row' + 1

putexcel A`row' = "Age 16-22"

quietly sum age_cat1 if arrest_charge_dui==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 23-30"

quietly sum age_cat2 if arrest_charge_dui==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 31-40"

quietly sum age_cat3 if arrest_charge_dui==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 41-50"

quietly sum age_cat4 if arrest_charge_dui==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 51-60"

quietly sum age_cat5 if arrest_charge_dui==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 61-70"

quietly sum age_cat6 if arrest_charge_dui==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 71-80"

quietly sum age_cat7 if arrest_charge_dui==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

*-------------------------------------------------------------
* Headers
*-------------------------------------------------------------
quietly sum arrest_charge_moving, detail
putexcel B`row' = "`r(sum)'"

putexcel A`row' = "Moving Crime Arrest (N=`r(sum)')", bold
putexcel B`row' = "%", bold
putexcel C`row' = "N", bold

local row = `row' + 1

*-------------------------------------------------------------
* Moving
*-------------------------------------------------------------
putexcel A`row' = "Race/Ethnicity"
local row = `row' + 1

putexcel A`row' = "Black"

quietly sum black if arrest_charge_moving==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "White"

quietly sum white if arrest_charge_moving==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Hispanic"

quietly sum hispanic if arrest_charge_moving==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Asian"

quietly sum asian if arrest_charge_moving==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Native"

quietly sum native if arrest_charge_moving==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Unknown Race/Ethnicity"

quietly sum unknown_race if arrest_charge_moving==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Sex"
local row = `row' + 1

putexcel A`row' = "Female"

quietly sum female if arrest_charge_moving==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Male"

quietly sum male if arrest_charge_moving==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age"
local row = `row' + 1

putexcel A`row' = "Age 16-22"

quietly sum age_cat1 if arrest_charge_moving==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 23-30"

quietly sum age_cat2 if arrest_charge_moving==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 31-40"

quietly sum age_cat3 if arrest_charge_moving==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 41-50"

quietly sum age_cat4 if arrest_charge_moving==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 51-60"

quietly sum age_cat5 if arrest_charge_moving==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 61-70"

quietly sum age_cat6 if arrest_charge_moving==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 71-80"

quietly sum age_cat7 if arrest_charge_moving==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

*-------------------------------------------------------------
* Headers
*-------------------------------------------------------------
quietly sum arrest_charge_theft, detail
putexcel B`row' = "`r(sum)'"

putexcel A`row' = "Theft Arrest (N=`r(sum)')", bold
putexcel B`row' = "%", bold
putexcel C`row' = "N", bold

local row = `row' + 1

*-------------------------------------------------------------
* Theft
*-------------------------------------------------------------
putexcel A`row' = "Race/Ethnicity"
local row = `row' + 1

putexcel A`row' = "Black"

quietly sum black if arrest_charge_theft==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "White"

quietly sum white if arrest_charge_theft==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Hispanic"

quietly sum hispanic if arrest_charge_theft==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Asian"

quietly sum asian if arrest_charge_theft==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Native"

quietly sum native if arrest_charge_theft==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Unknown Race/Ethnicity"

quietly sum unknown_race if arrest_charge_theft==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Sex"
local row = `row' + 1

putexcel A`row' = "Female"

quietly sum female if arrest_charge_theft==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Male"

quietly sum male if arrest_charge_theft==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age"
local row = `row' + 1

putexcel A`row' = "Age 16-22"

quietly sum age_cat1 if arrest_charge_theft==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 23-30"

quietly sum age_cat2 if arrest_charge_theft==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 31-40"

quietly sum age_cat3 if arrest_charge_theft==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 41-50"

quietly sum age_cat4 if arrest_charge_theft==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 51-60"

quietly sum age_cat5 if arrest_charge_theft==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 61-70"

quietly sum age_cat6 if arrest_charge_theft==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 71-80"

quietly sum age_cat7 if arrest_charge_theft==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

*-------------------------------------------------------------
* Headers
*-------------------------------------------------------------
quietly sum arrest_charge_assult, detail
putexcel B`row' = "`r(sum)'"

putexcel A`row' = "Assult Arrest (N=`r(sum)')", bold
putexcel B`row' = "%", bold
putexcel C`row' = "N", bold

local row = `row' + 1

*-------------------------------------------------------------
* Assult
*-------------------------------------------------------------
putexcel A`row' = "Race/Ethnicity"
local row = `row' + 1

putexcel A`row' = "Black"

quietly sum black if arrest_charge_assult==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "White"

quietly sum white if arrest_charge_assult==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Hispanic"

quietly sum hispanic if arrest_charge_assult==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Asian"

quietly sum asian if arrest_charge_assult==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Native"

quietly sum native if arrest_charge_assult==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Unknown Race/Ethnicity"

quietly sum unknown_race if arrest_charge_assult==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Sex"
local row = `row' + 1

putexcel A`row' = "Female"

quietly sum female if arrest_charge_assult==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Male"

quietly sum male if arrest_charge_assult==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age"
local row = `row' + 1

putexcel A`row' = "Age 16-22"

quietly sum age_cat1 if arrest_charge_assult==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 23-30"

quietly sum age_cat2 if arrest_charge_assult==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 31-40"

quietly sum age_cat3 if arrest_charge_assult==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 41-50"

quietly sum age_cat4 if arrest_charge_assult==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 51-60"

quietly sum age_cat5 if arrest_charge_assult==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 61-70"

quietly sum age_cat6 if arrest_charge_assult==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 71-80"

quietly sum age_cat7 if arrest_charge_assult==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

*-------------------------------------------------------------
* Headers
*-------------------------------------------------------------
quietly sum arrest_charge_property, detail
putexcel B`row' = "`r(sum)'"

putexcel A`row' = "Property Crime Arrest (N=`r(sum)')", bold
putexcel B`row' = "%", bold
putexcel C`row' = "N", bold

local row = `row' + 1

*-------------------------------------------------------------
* Property
*-------------------------------------------------------------
putexcel A`row' = "Race/Ethnicity"
local row = `row' + 1

putexcel A`row' = "Black"

quietly sum black if arrest_charge_property==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "White"

quietly sum white if arrest_charge_property==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Hispanic"

quietly sum hispanic if arrest_charge_property==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Asian"

quietly sum asian if arrest_charge_property==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Native"

quietly sum native if arrest_charge_property==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Unknown Race/Ethnicity"

quietly sum unknown_race if arrest_charge_property==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Sex"
local row = `row' + 1

putexcel A`row' = "Female"

quietly sum female if arrest_charge_property==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Male"

quietly sum male if arrest_charge_property==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age"
local row = `row' + 1

putexcel A`row' = "Age 16-22"

quietly sum age_cat1 if arrest_charge_property==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 23-30"

quietly sum age_cat2 if arrest_charge_property==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 31-40"

quietly sum age_cat3 if arrest_charge_property==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 41-50"

quietly sum age_cat4 if arrest_charge_property==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 51-60"

quietly sum age_cat5 if arrest_charge_property==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 61-70"

quietly sum age_cat6 if arrest_charge_property==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 71-80"

quietly sum age_cat7 if arrest_charge_property==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

*-------------------------------------------------------------
* Headers
*-------------------------------------------------------------
quietly sum arrest_charge_personal, detail
putexcel B`row' = "`r(sum)'"

putexcel A`row' = "Personal Crime Arrest (N=`r(sum)')", bold
putexcel B`row' = "%", bold
putexcel C`row' = "N", bold

local row = `row' + 1

*-------------------------------------------------------------
* Personal
*-------------------------------------------------------------
putexcel A`row' = "Race/Ethnicity"
local row = `row' + 1

putexcel A`row' = "Black"

quietly sum black if arrest_charge_personal==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "White"

quietly sum white if arrest_charge_personal==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Hispanic"

quietly sum hispanic if arrest_charge_personal==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Asian"

quietly sum asian if arrest_charge_personal==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Native"

quietly sum native if arrest_charge_personal==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Unknown Race/Ethnicity"

quietly sum unknown_race if arrest_charge_personal==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Sex"
local row = `row' + 1

putexcel A`row' = "Female"

quietly sum female if arrest_charge_personal==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Male"

quietly sum male if arrest_charge_personal==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age"
local row = `row' + 1

putexcel A`row' = "Age 16-22"

quietly sum age_cat1 if arrest_charge_personal==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 23-30"

quietly sum age_cat2 if arrest_charge_personal==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 31-40"

quietly sum age_cat3 if arrest_charge_personal==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 41-50"

quietly sum age_cat4 if arrest_charge_personal==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 51-60"

quietly sum age_cat5 if arrest_charge_personal==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 61-70"

quietly sum age_cat6 if arrest_charge_personal==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 71-80"

quietly sum age_cat7 if arrest_charge_personal==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

*-------------------------------------------------------------
* Headers
*-------------------------------------------------------------
quietly sum arrest_charge_financial, detail
putexcel B`row' = "`r(sum)'"

putexcel A`row' = "Financial Crime Arrest (N=`r(sum)')", bold
putexcel B`row' = "%", bold
putexcel C`row' = "N", bold

local row = `row' + 1

*-------------------------------------------------------------
* Financial
*-------------------------------------------------------------
putexcel A`row' = "Race/Ethnicity"
local row = `row' + 1

putexcel A`row' = "Black"

quietly sum black if arrest_charge_financial==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "White"

quietly sum white if arrest_charge_financial==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Hispanic"

quietly sum hispanic if arrest_charge_financial==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Asian"

quietly sum asian if arrest_charge_financial==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Native"

quietly sum native if arrest_charge_financial==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Unknown Race/Ethnicity"

quietly sum unknown_race if arrest_charge_financial==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Sex"
local row = `row' + 1

putexcel A`row' = "Female"

quietly sum female if arrest_charge_financial==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Male"

quietly sum male if arrest_charge_financial==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age"
local row = `row' + 1

putexcel A`row' = "Age 16-22"

quietly sum age_cat1 if arrest_charge_financial==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 23-30"

quietly sum age_cat2 if arrest_charge_financial==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 31-40"

quietly sum age_cat3 if arrest_charge_financial==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 41-50"

quietly sum age_cat4 if arrest_charge_financial==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 51-60"

quietly sum age_cat5 if arrest_charge_financial==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 61-70"

quietly sum age_cat6 if arrest_charge_financial==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 71-80"

quietly sum age_cat7 if arrest_charge_financial==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1


*-------------------------------------------------------------
* Headers
*-------------------------------------------------------------
quietly sum arrest_charge_sexual, detail
putexcel B`row' = "`r(sum)'"

putexcel A`row' = "Sexual Crime Arrest (N=`r(sum)')", bold
putexcel B`row' = "%", bold
putexcel C`row' = "N", bold

local row = `row' + 1

*-------------------------------------------------------------
* Sexual
*-------------------------------------------------------------
putexcel A`row' = "Race/Ethnicity"
local row = `row' + 1

putexcel A`row' = "Black"

quietly sum black if arrest_charge_sexual==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "White"

quietly sum white if arrest_charge_sexual==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Hispanic"

quietly sum hispanic if arrest_charge_sexual==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Asian"

quietly sum asian if arrest_charge_sexual==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Native"

quietly sum native if arrest_charge_sexual==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Unknown Race/Ethnicity"

quietly sum unknown_race if arrest_charge_sexual==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Sex"
local row = `row' + 1

putexcel A`row' = "Female"

quietly sum female if arrest_charge_sexual==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Male"

quietly sum male if arrest_charge_sexual==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age"
local row = `row' + 1

putexcel A`row' = "Age 16-22"

quietly sum age_cat1 if arrest_charge_sexual==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 23-30"

quietly sum age_cat2 if arrest_charge_sexual==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 31-40"

quietly sum age_cat3 if arrest_charge_sexual==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 41-50"

quietly sum age_cat4 if arrest_charge_sexual==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 51-60"

quietly sum age_cat5 if arrest_charge_sexual==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 61-70"

quietly sum age_cat6 if arrest_charge_sexual==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

putexcel A`row' = "Age 71-80"

quietly sum age_cat7 if arrest_charge_sexual==1, detail
local per = `r(mean)' * 100
local per = string(`per' ,"%2.1f")
putexcel B`row' = `per'
putexcel C`row' = `r(sum)'
local row = `row' + 1

*************** END *****************

*log close log_$DO_NAME
log close _all
