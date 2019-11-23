/*
Process Charges
Author: Alvin G. Thomas, MSPH

Written for Stata14 SE
Created on 2019-11-06
Last Edited 2019-11-07

Copyright (c) 2019 Alvin G. Thomas (https://github.com/alvinthomas).
It is made available under a CC-BY-SA 4.0 International license.
*/

***** PREAMBLE *****
clear all
macro drop _all
set more off

*************** BEGIN ***************
*-------------------------------------------------------------
* Incidents Charges
*-------------------------------------------------------------
use 00_data/incident_preprocess, clear

* Incidents

*------------------------------------------
* Party
*------------------------------------------

gen incident_party = inlist(incidentdesc, ///
  "LOUD MUSIC/PARTY", ///
  "LOUD MUSIC/PARTY/OTHER NOISE", ///
  "LOUD PARTY FOLLOW UP", ///
  " LOUD PARTY", ///
  "LOUD MUSIC")

replace incident_party = 1 if inlist(incidentdesc, ///
  " LOUD MUSIC", ///
  "LOUD PARTY", ///
  "LOUD MUSIC/PARTY", ///
  "LOUD NOISE")

*------------------------------------------
* Alcohol
*------------------------------------------

gen incident_alcohol = inlist(incidentdesc, ///
  "ALCOHOL VIOLATIONS", ///
  "OPEN CONTAINER", ///
  "OPEN CONTAINER OF MALT BEVERAGE", ///
  "UNDERAGE CONSUMPTION", ///
  "DRUNK AND DISRUPTIVE", ///
  "INTOXICATED AND DISRUPTIVE", ///
  "PUBLIC INEBRIATE", ///
  "PUBLIC CONSUMPTION", ///
  "OPEN CONTAINER VIOLATION")


replace incident_alcohol = 1 if inlist(incidentdesc, ///
  "DRIVING WHILE IMPAIRED", ///
  "IMPAIRED DRIVING DWI")

*------------------------------------------
* Drug
*------------------------------------------

gen incident_drug = inlist(incidentdesc, ///
  "DRUG VIOLATIONS", ///
  "SIMPLE POSSESSION", ///
  "OVERDOSE", ///
  "EQUIP/PARAPHERNALIA-POSS/CONCEALING", ///
  "UNDERAGE POSSESSION")

replace incident_drug = 1 if inlist(incidentdesc, ///
  "NARCOTIC SNIFF", ///
  "SIMPLE POSSESSION OF MARIJUANA", ///
  "PARAPHERNALIA- USING/ EQUIPMENT", ///
  "SELL CRACK COCAINE", ///
  "NARCOTIC INVESTIGATION", ///
  "FELONY POSSESSION OF COCAINE", ///
  "PARAPHERNALIA- POSSESSING/CONCEALING EQUIPMENT", ///
  "EQUIPMENT/PARAPHERNALIA-MANUFACTURING")

replace incident_drug = 1 if inlist(incidentdesc, ///
  "POSSIBLE DRUG ACTIVITY", ///
  "POSSESSION OF MARIJUANA", ///
  "SELL COCAINE", ///
  "DRUG VIOLATION- OTHER", ///
  "POSSIBLE DRUG USE", ///
  "POSSESSION OF COCAINE", ///
  "POSSESSION OF DRUG PARAPHERNALIA", ///
  "NARCOTIC IVIOLATION", ///
  "SELL AND DELIVER SCH I")

*------------------------------------------
* Domestic
*------------------------------------------

gen incident_domestic = inlist(incidentdesc, ///
  "DOMESTIC DISTURBANCE/NO ASSAULT", ///
  "DOMESTIC DISTURBANCE", ///
  "CIVIL MATTER", ///
  "CIVIL DISPUTE OVER MONEY", ///
  "DOMESTIC DISTURBANCE- POSSIBLE ASSAULT", ///
  "VERBAL DOMESTIC", ///
  "ARGUMENT OVER CHILD CARE", ///
  "CIVIL DISPUTE", ///
  "DISPUTE")

*------------------------------------------
* Information
*------------------------------------------

gen incident_information = inlist(incidentdesc, ///
  "INFORMATION", ///
  "BARKING DOGS", ///
  "DOG CALL", ///
  "SUSPICIOUS PERSON", ///
  "SUSPICIOUS VEHICLE", ///
  "SUSPICIOUS CONDITION", ///
  " SUSPICIOUS CONDITION")

replace incident_information = 1 if inlist(incidentdesc, ///
  "NUISANCE COMPLAINT", ///
  "SUSPICIOUS CONDITIONS", ///
  "SUSPICIOUS", ///
  "SUSPICIOUS ACTIVITY", ///
  "SUSPICIOUS CIRCUMSTANCES", ///
  "INFORMATION-JUVENILE ASSIST", ///
  "SUSPICIOUS PERSONS", ///
  "CHECK WELL BEING")

replace incident_information = 1 if inlist(incidentdesc, ///
  "VEHICLE FIRE", ///
  "ANIMAL CALL", ///
  "PROPERTY CHECK", ///
  "UNLOCK VEHICLE", ///
  "DUSTURBANCE", ///
  "SUSPICIOUS NOISE", ///
  "WELL BEING CHECK", ///
  "GOOD NEIGHBOR/NATIONAL NIGHT OUT", ///
  "GUNSHOTS HEARD")

replace incident_information = 1 if inlist(incidentdesc, ///
  "REPORT OF GUNSHOTS", ///
  "SUSPICIOUS BEHAVIOR", ///
  "SUSPICIOUS INCIDENT", ///
  "CHECK WELL-BEING", ///
  "GUN SHOTS HEARD", ///
  "ABANDONED HOUSE/PROERTY", ///
  "ANIMAL CONCERN")

replace incident_information = 1 if inlist(incidentdesc, ///
  "INFORMATION(DUPLICATE REPORT)", ///
  "POLICE ADVICE", ///
  "INFORMATION LANDLORD DISPUTE", ///
  "NOISY FOWL", ///
  "UNFOUNDED LOUD NOISE", ///
  "GUNSHOTS")

*------------------------------------------
* Theft
*------------------------------------------

gen incident_theft = inlist(incidentdesc, ///
  "LARCENY- ALL OTHER", ///
  "B&E  , LARCENY F/VEHICLE", ///
  "B&E RESIDENCE-FORCE", ///
  "B&E RESIDENCE NO FORCE", ///
  "LARCENY OF BICYCLE", ///
  "B&E LARCENY FROM VEHICLE")

replace incident_theft = 1 if inlist(incidentdesc, ///
  "BURGLARY-NO FORCE", ///
  "B&E VEH (ATT LAR F/VEH)", ///
  "LARCENY FROM MOTOR VEHICLE", ///
  "LARCENY FROM RESIDENCE", ///
  "BURGLARY W/FORCE", ///
  "AUTOMOBILE THEFT")

replace incident_theft = 1 if inlist(incidentdesc, ///
  "ARMED ROBBERY", ///
  "LARCENY OF CELL PHONE", ///
  "LARCENY", ///
  "LARCENY AFTER B&E", ///
  "ROBBERY", ///
  "LARCENY FROM BUILDING")

replace incident_theft = 1 if inlist(incidentdesc, ///
  "B&E VEH", ///
  "POSSESSING/CONCEALING STOLEN PROPERTY", ///
  "LARCENY FROM AUTO /PARTS AND ACCESSORIES", ///
  "LARCENY OF MOTORCYCLE / MOPED", ///
  "POSSESSING STOLEN PROPERTY", ///
  "B&E SHED-FORCE", ///
  "LARCENY OF DOG")

replace incident_theft = 1 if inlist(incidentdesc, ///
  "LARCENY- MEDICATION", ///
  "LARCENY OF STREET SIGN", ///
  "LARCENY OF WATCH", ///
  "LARCENY OF WATER", ///
  "LARCENY FROM PERSON", ///
  "LARCENY OF MEDICATIONS", ///
  " ARMED ROBBERY")

replace incident_theft = 1 if inlist(incidentdesc, ///
  "LARCENY OF CELLPHONE", ///
  "LARCENY OF PATIO CUSHIONS", ///
  "LARCENY OF A LAWN MOWER", ///
  "POSSESS STOLEN PROPERTY", ///
  "LARCENY- OF BICYCLE", ///
  "STRONG ARM ROBBERY", ///
  "POSSIBLE STOLEN BICYCLE", ///
  "LARCENY OF A LICENSE PLATE")

replace incident_theft = 1 if inlist(incidentdesc, ///
  "POSSESSING STOLEN FIREARM", ///
  "LARCENY OF SCOOTER", ///
  "LARCENY OF MAIL", ///
  "LARCENY OF MOTORCYCLE", ///
  "LARCENY OF MOTOR VEHICLE", ///
  "POSS OF STOLEN GOODS", ///
  "REC/POSS STOLE MV", ///
  "PURSE SNATCHING")

replace incident_theft = 1 if inlist(incidentdesc, ///
  "POSS STOLEN PROPERTY", ///
  "LARCENY- CELL PHONE", ///
  "LARCENY OF PACKAGES", ///
  "LARCENY OF A BICYCLE", ///
  "POSSESSING STOLEN VEHICLE", ///
  "LARCENY OF FIREARM", ///
  "LARCENY OF LAWN CHAIR", ///
  "B&E VEHICLE(ATT LARCENY)")

*------------------------------------------
* Property
*------------------------------------------

gen incident_property = inlist(incidentdesc, ///
  "TRESPASSING", ///
  "VANDALISM / DAMAGE TO PROPERTY (WILLFUL)", ///
  "DAMAGE TO PROPERTY(NON-CRIMINAL)", ///
  "DAMAGE TO PROPERTY", ///
  "VEHICLE DAMAGE")

replace incident_property = 1 if inlist(incidentdesc, ///
  "ALARM", ///
  "DAMAGE TO PROPERTY (WILLFUL)", ///
  "ARSON", ///
  "ABANDONED PROPERTY", ///
  "B&E BUSINESS-FORCE", ///
  "GRAFFITI VANDALISM")

replace incident_property = 1 if inlist(incidentdesc, ///
  "VANDALISM/DAMAGE TO PROPERTY", ///
  "1ST DEGREE TRESPASS", ///
  " DAMAGE TO PROPERTY (WILLFUL)", ///
  "B&E VEH (NO PROPERTY TAKEN)", ///
  "2ND DEGREE TRESPASSING")

*------------------------------------------
* Moving
*------------------------------------------

gen incident_moving = inlist(incidentdesc, ///
  "TOWED VEHICLE", ///
  "TRAFFIC COMPLAINT", ///
  "UNAUTHORIZED USE OF CONVEYANCE", ///
  "DWLR", ///
  "TRAFFIC / DIRECTED PATROL", ///
  "NOL")

replace incident_moving = 1 if inlist(incidentdesc, ///
  "NO INSURANCE", ///
  "FICT/ALT TITLE/REG CARD/TAG", ///
  "IMPROPERLY PARKED VEHICLE", ///
  "LICENSE CHECKPOINT", ///
  " PARKING COMPLAINT")

replace incident_moving = 1 if inlist(incidentdesc, ///
  "ILLEGALLY PARKED VEHICLE", ///
  "UNSAFE MOVEMENT", ///
  "TRAFFIC COMPLAINT-RESIDENTIAL PARKING", ///
  "HIT & RUN")

replace incident_moving = 1 if inlist(incidentdesc, ///
  "NDL - OPERATOR OR CHAUFFER", ///
  "UNAUTHORIZED USE OF BICYCLE", ///
  "DRIVING WHILE LICENSE REVOKED", ///
  "IMPROPERLY PARKED VEHICLES", ///
  "SPEEDING", ///
  "TRAFFIC STOP")

replace incident_moving = 1 if inlist(incidentdesc, ///
  "VEHICLE SEARCH", ///
  "RECKLESS DRIVING", ///
  "CRASH INVESTIGATION", ///
  "PARKING COMPLAINT", ///
  "HIT AND RUN", ///
  "PARKING DISPUTE")

*------------------------------------------
* Victimless
*------------------------------------------

gen incident_victimless = inlist(incidentdesc, ///
  "DISTURBING THE PEACE", ///
  "DISTURBANCE", ///
  "RESISTING ARREST", ///
  "REFUSE TO LEAVE", ///
  "LITTERING")

replace incident_victimless = 1 if inlist(incidentdesc, ///
  "PROBATION VIOLATION", ///
  "UNDISCIPLINED CHILD", ///
  "NUISANCE", ///
  "DISCHARGING FIREARM", ///
  "POSSESSION OF A FIREARM BY FELON")

replace incident_victimless = 1 if inlist(incidentdesc, ///
  "WEAPON ON SCHOOL PROPERTY", ///
  "RESIST, DELAY AND OBSTRUCT", ///
  "MISUSE OF PUBLIC SEATING", ///
  "MENTAL DISORDER", ///
  "BARKING DOG", ///
  "EMERGENCY COMMITMENT-NON CRIMINAL DETAINMENT", ///
  "VICIOUS DOG/LEASH LAW VIOLATION")

replace incident_victimless = 1 if inlist(incidentdesc, ///
  "DISCHARGING PYROTECHNICS - USE/FIREWORKS", ///
  "REFUSAL TO LEAVE", ///
  "DOG BARKING COMPLAINT", ///
  "ABANDONED VEHICLES", ///
  "ASSIST PROBATION", ///
  "RESIST/DELAY/OBSTRUCT", ///
  "RUNAWAY")

replace incident_victimless = 1 if inlist(incidentdesc, ///
  "FIREWORKS / GUNSHOTS", ///
  "POSSESS FIREARM BY FELON", ///
  "FAILURE TO APPEAR", ///
  "OUTSTANDING WARRANT")

*------------------------------------------
* Assult
*------------------------------------------

gen incident_assult = inlist(incidentdesc, ///
  "SIMPLE ASSAULT-OTHER", ///
  "DOMESTIC SIMPLE  ASSAULT", ///
  "ASSAULT ON FEMALE", ///
  "ASSAULT ON LEO", ///
  "ASSIST CPS")

replace incident_assult = 1 if inlist(incidentdesc, ///
  "ASSAULT WITH A DEADLY WEAPON", ///
  "PHYSICAL SIMPLE ASSAULT-NON AGGRAVATED", ///
  "SIMPLE ASSAULT", ///
  "DOMESTIC AGGRAVATED ASSAULT")

replace incident_assult = 1 if inlist(incidentdesc, ///
  "AWDWIKISI", ///
  "ASSAULT INFLICTING SERIOUS INJURY", ///
  "AGGRAVATED ASSAULT", ///
  "MURDER & NONNEGLIENT MANSLAUGHTER", ///
  "PHYSICAL SIMPLE ASSAULT")

*------------------------------------------
* Personal
*------------------------------------------

gen incident_personal = inlist(incidentdesc, ///
  "COMMUNICATING THREATS -INTIMIDATION, NON PHYSICAL THREAT", ///
  "HARASSMENT", ///
  "FIGHTING/ AFFRAY", ///
  "DEATH INVESTIGATION", ///
  "KIDNAPPING", ///
  "THREATENING PHONE CALLS")

replace incident_personal = 1 if inlist(incidentdesc, ///
  "IDENTITY THEFT", ///
  "50B ORDER VIOLATION", ///
  "VERBAL ARGUMENT", ///
  "CRUELTY TO ANIMALS (CITY ORDINANCE)", ///
  "MISSING PERSON", ///
  "ANIMAL ABUSE")

replace incident_personal = 1 if inlist(incidentdesc, ///
  "CHILD NEGLECT (NO ASSAULT)", ///
  "COMMUNICATING THREATS", ///
  "HARASSING PHONE CALLS-NO THREATS", ///
  "DOG BITES AND ATTACKS")

replace incident_personal = 1 if inlist(incidentdesc, ///
  "WELL-BEING CHECK", ///
  "NEIGHBOR DISPUTE", ///
  "COMMUNICATING UNWANTED ADVANCES", ///
  "CHILD ABUSE/ASSAULT-NO INJURY")

replace incident_personal = 1 if inlist(incidentdesc, ///
  "ATTEMPTED B&E RESIDENCE-FORCE", ///
  "CHILD ABUSE/ASSAULT-N INJURY", ///
  "HOMICIDAL THREATS", ///
  "SUICIDAL THREATS", ///
  "PROTECTIVE ORDER VIOLATION", ///
  "CHILD ABUSE-NON ASSAULTIVE", ///
  "50B VIOLATION")

*------------------------------------------
* Financial
*------------------------------------------

gen incident_financial = inlist(incidentdesc, ///
  "FRAUD-ALL OTHER", ///
  "CREDIT CARD/ATM FRAUD", ///
  "CREDIT CARD FRAUD", ///
  "OBTAINING MONEY BY FALSE PRETENSE", ///
  "USING FRAUDULENT ID CARD", ///
  "FORGERY- USING/UTTERING", ///
  "OBTAINING PROPERTY FALSE PRETENSE")

replace incident_financial = 1 if inlist(incidentdesc, ///
  "FRAUDULENT FACEBOOK ACCOUNT", ///
  "UNLAWFULLY OBTAINING CREDIT CARD", ///
  "PHONE SCAM", ///
  "TOWING SCAM", ///
  "EMBEZZLEMENT- OTHER", ///
  "FRAUD", ///
  "FICTITIOUS TAG", ///
  "IPVS")

*------------------------------------------
* Sexual
*------------------------------------------

gen incident_sexual = inlist(incidentdesc, ///
  "SEXUAL BATTERY", ///
  "INDECENT EXPOSURE", ///
  "PEEPING TOM", ///
  "URINATING IN PUBLIC", ///
  "STALKING")

replace incident_sexual = 1 if inlist(incidentdesc, ///
  "SEXUAL ASSAULT", ///
  "FORCIBLE RAPE", ///
  "STATUTORY RAPE", ///
  "AGGRAVATED ASSAULT WITH SEXUAL MOTIVES", ///
  "SEXUAL HARASSMENT")

*------------------------------------------
* Non-crime
*------------------------------------------

gen incident_non_crime = inlist(incidentdesc, ///
  "ASSIST EMS", ///
  "FOUND PROPERTY", ///
  "COMMUNITY OUTREACH", ///
  "ABANDONED VEHICLE", ///
  "ASSIST OTHER AGENCY", ///
  "PUBLIC ASSISTANCE")

replace incident_non_crime = 1 if inlist(incidentdesc, ///
  "FUNERAL ESCORT", ///
  "VOLUNTARY MENTAL COMMITMENT", ///
  "INVOLUNTARY COMMITMENT-NON CRIMINAL DETAINMENT", ///
  "LOST PROPERTY")

replace incident_non_crime = 1 if inlist(incidentdesc, ///
  "WARRANT SERVICE", ///
  "CHECK ON WELL BEING", ///
  "DOMESTIC ASSISTANCE", ///
  "ASSIST FIRE DEPARTMENT", ///
  "ASSIST CITIZEN", ///
  "ATTEMPTED SUICIDE")

replace incident_non_crime = 1 if inlist(incidentdesc, ///
  "CHECK ON WELL-BEING", ///
  "K9 SNIFF", ///
  "K-9 SNIFF", ///
  "VEHICLE UNLOCK", ///
  "K-9 DEMO/ COMMUNITY TALK")

replace incident_non_crime = 1 if inlist(incidentdesc, ///
  "CALL FOR SERVICE", ///
  "FOUND I PHONE", ///
  "ASSISTANCE", ///
  "ASSIST OC EMS", ///
  "ASSIST EMS (SUICIDE ATTEMPT)")

replace incident_non_crime = 1 if inlist(incidentdesc, ///
  "ANIMAL DISPATCH", ///
  "FOUND PURSE", ///
  "CARDIAC ARREST", ///
  "SUICIDE ATTEMPT", ///
  "K-9 DEMONSTRATION", ///
  "ASSIST CHATHAM COUNTY")

replace incident_non_crime = 1 if inlist(incidentdesc, ///
  "ASSIST ORANGE COUNTY", ///
  "DIRECTED PATROL", ///
  "ACCIDENTAL ALARM", ///
  "LOST WALLET", ///
  "DOMESTIC ASSIST", ///
  "K9 DEMO", ///
  "ASSIST BAIL BONDSMAN")

*------------------------------------------
* Final
*------------------------------------------
gen incident_cat  = .
replace incident_cat = 1 if incident_party == 1
replace incident_cat = 2 if incident_alcohol == 1
replace incident_cat = 3 if incident_drug == 1
replace incident_cat = 4 if incident_domestic == 1
replace incident_cat = 5 if incident_information == 1
replace incident_cat = 6 if incident_theft == 1
replace incident_cat = 7 if incident_property == 1
replace incident_cat = 8 if incident_moving == 1
replace incident_cat = 9 if incident_victimless == 1
replace incident_cat = 10 if incident_assult == 1
replace incident_cat = 11 if incident_personal == 1
replace incident_cat = 12 if incident_financial == 1
replace incident_cat = 13 if incident_sexual == 1
replace incident_cat = 14 if incident_non_crime == 1
label define incident_cat 1 "Party" 2 "Alcohol" 3 "Drug" 4 "Domestic" ///
  5 "Information" 6 "Theft" 7 "Property Crime" 8 "Moving Crime" ///
  9 "Victimeless Crime" 10 "Assult" ///
  11 "Personal Crime" 12 "Financial" 13 "Sexual" ///
  14 "Non-Crime"
label values incident_cat incident_cat

*************** END *****************
