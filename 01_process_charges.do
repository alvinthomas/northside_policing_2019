/*
Process Charges
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

*************** BEGIN ***************
*-------------------------------------------------------------
* Arrests Charges
*-------------------------------------------------------------
use 00_data/arrests_preprocess, clear

* Arrests

*------------------------------------------
* Alcohol
*------------------------------------------

gen arrest_charge_alcohol = inlist(chrgdesc, ///
  "OPEN CONTAINER", ///
  "CONSUME ALCOHOLIC BEVERAGE LESS THAN 21", ///
  "PUBLIC CONSUMPTION", ///
  "DRUNK / DISRUPTIVE", ///
  "CONSUMING ON UNAUTHORIZED PREMISES")

replace arrest_charge_alcohol = 1 if inlist(chrgdesc, ///
  "UNDERAGE POSS OF SPIRITIOUS LIQUOR", ///
  "GIVE/SELL MALT BEV TO MINOR", ///
  "POSS /CONSUMING ALCOHOL PASSENGER AREA OF VEH", ///
  "FTA ALCOHOL VIOLATION")

replace arrest_charge_alcohol = 1 if inlist(chrgdesc, ///
  "CONSUME ON UNAUTHORIZED PREMISE", ///
  "CONSUMING ON OFF PREMISES", ///
  "LIQUOR  - POSSESSION", ///
  "OFA DRUNK AND DISRUPTIVE", ///
  "POSSESS ON UNAUTHORIZED PREMISES", ///
  "FTA OPEN CONTAINER", ///
  "FTA ALCOHOL VIOLATION", ///
  "FTA OPEN CONTAINER")

replace arrest_charge_alcohol = 1 if inlist(chrgdesc, ///
  "UNDERAGE POSS OF SPIRITIOUS LIQUOR", ///
  "POSS /CONSUMING ALCOHOL PASSENGER AREA OF VEH", ///
  "GIVE/SELL MALT BEV TO MINOR", ///
  "CONSUMING ON OFF PREMISES", ///
  "OFA DRUNK AND DISRUPTIVE", ///
  "LIQUOR  - POSSESSION", ///
  "CONSUME ON UNAUTHORIZED PREMISE")

replace arrest_charge_alcohol = 1 if inlist(chrgdesc, ///
  "IMPAIRED DRIVING DWI", ///
  "RECKLESS DRIVING", ///
  "DRIVING WHILE IMPAIRED", ///
  "IMPAIRED DRIVING DWI OFA", ///
  "DWLR IMPAIRED REV", ///
  "DWLR IMPAIRED REV")

*------------------------------------------
* Drug
*------------------------------------------

gen arrest_charge_drug = inlist(chrgdesc, ///
  "UNDERAGE POSSESSION", ///
  "POSSESSION MARIJUANA", ///
  "DRUG PARAPHERNALIA", ///
  "POSS COCAINE FEL", ///
  "POSS MARIJUANA MISD", ///
  "POSS COCAINE FEL")

replace arrest_charge_drug = 1 if inlist(chrgdesc, ///
  "DRUGS-POSS SCHED VI", ///
  "POSSESS HEROIN", ///
  "DRUGS-MISD POSS", ///
  "DRUGS-POSS SCHED VI", ///
  "POSSESS HEROIN", ///
  "POSSESS ON UNAUTHORIZED PREMISES")

replace arrest_charge_drug = 1 if inlist(chrgdesc, ///
  "SELL COCAINE", ///
  "DRUGS-MISD POSS", ///
  "SELL COCAINE", ///
  "POSSESSION ON UNAUTHORIZED PREMISES", ///
  "PWISD II CS")

*------------------------------------------
* Victimless
*------------------------------------------

gen arrest_charge_victimless = inlist(chrgdesc, ///
  "FAIL TO APPEAR/COMPL", ///
  "RESISTING ARREST", ///
  "PROBATION VIOLATION", ///
  "LITTERING", ///
  "WARRANT FOR ARREST", ///
  "SCHOOL-FAIL TO ATTEND")

replace arrest_charge_victimless = 1 if inlist(chrgdesc, ///
  "NOISE ORDINANCE VIOLATION", ///
  "FICT/ALT TITLE/REG CARD/TAG", ///
  "PAROLE VIOLATION", ///
  "UNAUTHORIZED USE OF MOTOR VEHICLE")

replace arrest_charge_victimless = 1 if inlist(chrgdesc, ///
  "RESIST, DELAY AND OBSTRUCT", ///
  "MISUSE OF 911", ///
  "OFA THREATS, PANHANDLING", ///
  "FAIL TO APPEAR/COMPL ON A FELONY", ///
  "MISUSE OF 911", ///
  "RESIST DELAY AND OBSTRUCT", ///
  "OFA THREATS, PANHANDLING", ///
  "PAROLE OR PROBATION VIOLATION")

replace arrest_charge_victimless = 1 if inlist(chrgdesc, ///
  "MISUSE OF PUBLIC SEATING", ///
  "COMMON LAW-GOING ARMED", ///
  "INTERFERE W/EMERGENCY COMMUNICATIONS", ///
  "RESIST DELAY AND OBSTRUCT")

replace arrest_charge_victimless = 1 if inlist(chrgdesc, ///
  "PAROLE OR PROBATION VIOLATION", ///
  "PAROLE VIOLATION", ///
  "MISUSE OF PUBLIC SEATING", ///
  "NOISE ORDINANCE VIOLATION", ///
  "FAIL TO APPEAR/COMPL ON A FELONY", ///
  "RESIST, DELAY AND OBSTRUCT", ///
  "INTERFERE W/EMERGENCY COMMUNICATIONS")

*------------------------------------------
* Moving
*------------------------------------------

gen arrest_charge_moving = inlist(chrgdesc, ///
  "HIT & RUN - PD", ///
  "FTA-DWLR", ///
  "NDL - OPERATOR OR CHAUFFER", ///
  "DWLR NOT IMPARIED REV", ///
  "FTA (DWLR NOT IMPAIRED, NO LIABILITY INSURANCE)", ///
  "FAIL TO BURN HEADLAMPS")

replace arrest_charge_moving = 1 if inlist(chrgdesc, ///
  "IMPEDE THE FLOW OF TRAFFIC", ///
  "DRIVING W/LIC REVOKED", ///
  "FICT/ALT TITLE/REG CARD/TAG", ///
  "PROVISIONAL LICENSEE", ///
  "UNAUTHORIZED USE OF MOTOR VEHICLE")

*------------------------------------------
* Theft
*------------------------------------------

gen arrest_charge_theft = inlist(chrgdesc, ///
  "POSS STOLEN GOODS", ///
  "LARCENY -  ALL OTHER", ///
  "BREAKING/LARC-FELONY", ///
  "BREAKING/ENTER-MISD", ///
  "LARCENY", ///
  "BURGLARY-1ST DEGREE", ///
  "POSS OF STOLEN GOODS", ///
  "ROBBERY", ///
  "BURGLARY-2ND DEGREE")

replace arrest_charge_theft = 1 if inlist(chrgdesc, ///
  "COMMON LAW ROBBERY", ///
  "REC STOLEN GOODS", ///
  "LARCENY FROM PERSON", ///
  "LARCENY OF MOTOR VEHICLE", ///
  "CONCEALING MDSE/SHOPLIFTING")

replace arrest_charge_theft = 1 if inlist(chrgdesc, ///
  "POSS STOLEN MOTOR VEH", ///
  "REC/POSS STOLE MV", ///
  "COMMON LAW ROBBERY", ///
  "LARCENY FROM PERSON", ///
  "REC STOLEN GOODS", ///
  "ATTEMPTED BURGLARY-2ND DEGREE", ///
  "LARCENY -  BEER", ///
  "OFA M LARCENY")

replace arrest_charge_theft = 1 if inlist(chrgdesc, ///
  "REC/POSS STOLE MV", ///
  "OFA M LARCENY", ///
  "LARCENY OF MOTOR VEHICLE", ///
  "LARCENY -  BEER", ///
  "ATTEMPTED BURGLARY-2ND DEGREE", ///
  "COMMON LAW-GOING ARMED", ///
  "POSS STOLEN MOTOR VEH", ///
  "CONCEALING MDSE/SHOPLIFTING")

*------------------------------------------
* Assult
*------------------------------------------

gen arrest_charge_assult = inlist(chrgdesc, ///
  "ASSAULT ON FEMALE", ///
  "SIMPLE ASSAULT", ///
  "ASSAULT ON GOVERNMENT OFFICIAL", ///
  "ASSAULT INFLICTING SERIOUS INJURY", ///
  "AWIK/SERIOUS INJURY", ///
  "PHYSICAL SIMPLE ASSAULT-NON AGGRAVATED", ///
  "ASSAULT ON EMERGENCY PERSONNEL", ///
  "ASSAULT ON FEMALE/SIMPLE ASSAULT")

replace arrest_charge_assult = 1 if inlist(chrgdesc, ///
  "ASSAULT ON OFFICER/SIMPLE ASSAULT", ///
  "ASSAULT-SIMPLE", ///
  "ASSAULT BY STRANGULATION", ///
  "OFA SIMPLE ASSAULT", ///
  "ASSAULT ON OFFICER/SIMPLE ASSAULT", ///
  "ASSAULT-SIMPLE")

replace arrest_charge_assult = 1 if inlist(chrgdesc, ///
  "ASSAULT BY STRANGULATION", ///
  "OFA SIMPLE ASSAULT", ///
  "AFFRAY/ASSAULT & BATTERY", ///
  "ASSAULT & BATTERY")

*------------------------------------------
* Property
*------------------------------------------

gen arrest_charge_property = inlist(chrgdesc, ///
  "2ND DEGREE TRESPASS", ///
  "TRESPASSING", ///
  "DAMAGE-PERSONAL PROP", ///
  "1ST DEGREE TRESPASS", ///
  "B&E-VEHICLE", ///
  "DAMAGE-REAL PROPERTY", ///
  "CYBERSTALKING", ///
  "VANDALISM", ///
  "FRAUD-OBT PROPERTY")

replace arrest_charge_property = 1 if inlist(chrgdesc, ///
  "ATTEMPTED BREAKING/ENTER-MISD", ///
  "HIT/RUN LEAVE SCENE OF PROPERTY DAMAGE", ///
  "OFA SECOND DEGREE TRESPASS", ///
  "VANDALISM", ///
  "FAIL RETUR RENT PROP", ///
  "ATTEMPTED BREAKING/ENTER-MISD", ///
  "OFA SECOND DEGREE TRESPASS", ///
  "HIT/RUN LEAVE SCENE OF PROPERTY DAMAGE")

*------------------------------------------
* Personal
*------------------------------------------

gen arrest_charge_personal = inlist(chrgdesc, ///
  "VIOLATION DOMESTIC VIOLENCE PROTECTIVE ORDER", ///
  "AFFRAY/ASSAULT & BATTERY", ///
  "ASSAULT & BATTERY", ///
  "CRUELTY TO ANIMALS", ///
  "CRUELTY TO ANIMALS (CITY ORDINANCE)", ///
  "SECOND DEGREE KIDNAPPING")

replace arrest_charge_personal = 1 if inlist(chrgdesc, ///
  "EXPLOIT DISABLE/ELDER CAPACITY", ///
  "COMMUNICATING THREATS", ///
  "COMMUNICATE THREATS", ///
  "CHILD ABUSE-ASSAULTIVE/ NO INJURY", ///
  "VIOLATION DOMESTIC VIOLENCE PROTECTIVE ORDER", ///
  "SECOND DEGREE KIDNAPPING", ///
  "EXPLOIT DISABLE/ELDER CAPACITY")

replace arrest_charge_personal = 1 if inlist(chrgdesc, ///
  "CRUELTY TO ANIMALS", ///
  "CRUELTY TO ANIMALS (CITY ORDINANCE)", ///
  "COMMUNICATE THREATS", ///
  "VIOLATION DVPO", ///
  "COMMUNICATING THREATS")

*------------------------------------------
* Financial
*------------------------------------------

gen arrest_charge_financial = inlist(chrgdesc, ///
  "DEFRAUD INNKEEPER", ///
  "CREDIT CARD FRAUD", ///
  "FINANCIAL CARD THEFT", ///
  "VIOLATION DVPO", ///
  "FAIL RETUR RENT PROP", ///
  "FORGERY", ///
  "FINANCIAL CARD THEFT")

replace arrest_charge_financial = 1 if inlist(chrgdesc, ///
  "EMBEZZLEMENT OF STATE PROPERTY", ///
  "CREDIT CARD FRAUD", ///
  "POSS OR MANUFACUTRE OF FRADUENT FORMS OF IDENTIFICATION", ///
  "DEFRAUD INNKEEPER", ///
  "EMBEZZLEMENT OF STATE PROPERTY", ///
  "POSS OR MANUFACTURE  FRAUDULENT FORMS OF ID", ///
  "POSS OR MANUFACUTRE OF FRADUENT FORMS OF IDENTIFICATION", ///
  "FORGERY")

*------------------------------------------
* Sexual
*------------------------------------------

gen arrest_charge_sexual = inlist(chrgdesc, ///
  "RAPE-2ND DEGREE", ///
  "RAPE 1ST DEGREE", ///
  "PEEPING", ///
  "INDECENT EXPOSURE", ///
  "PUBLIC URINATION", ///
  "FAIL TO REGISTER - SEX OFFENDER REGISTRATION", ///
  "SEX OFFENDER UNLAWFULLY ON PREMISES.")

*------------------------------------------
* Final
*------------------------------------------
gen arrest_cat  = .
replace arrest_cat = 1 if arrest_charge_alcohol == 1
replace arrest_cat = 2 if arrest_charge_drug == 1
replace arrest_cat = 3 if arrest_charge_victimless == 1
replace arrest_cat = 4 if arrest_charge_moving == 1
replace arrest_cat = 5 if arrest_charge_theft == 1
replace arrest_cat = 6 if arrest_charge_assult == 1
replace arrest_cat = 7 if arrest_charge_property == 1
replace arrest_cat = 8 if arrest_charge_personal == 1
replace arrest_cat = 9 if arrest_charge_financial == 1
replace arrest_cat = 10 if arrest_charge_sexual == 1
label define arrest_cat 1 "Alcohol" 2 "Drug" 3 "Victimless Crime" ///
  4 "Moving Crime" 5 "Theft" 6 "Assult" 7 "Property Crime" ///
  8 "Personal" 9 "Financial/Fraud" 10 "Sexual Crime"
label values arrest_cat arrest_cat

*************** END *****************
