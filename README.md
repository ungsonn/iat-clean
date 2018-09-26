# iat-clean
R script for cleaning IAT data (2002-2013) from Project Implicit with select variables

## Contents
* "import and tidy iat.R": script for unzipping IAT .sav files from Project Implicit (years 2002-2013), selecting a subset of variables, and cleaning data as per Project Implicit exclusionary criteria
* "state_info.csv": spreadsheet containing state-level names, abbreviations, and numbers to facilitate state-level analyses

## Notes
* "import and tidy.R" assumes that you have the zipped (.zip) folders from Project Implicit in the same directory (e.g., "RACE_IAT.public.2002-2003.zip"). All datasets and codebooks are available on the [Project Implicit Open Science Framework page](https://osf.io/gwofk/). Use of R package "here" ensures that no modification of working directory is needed to run entire script
* "import and tidy.R" takes a long time (~10-11 minutes for me) and uses the beep() function from the R package "beepr" to play sounds at certain intervals (e.g., after succesfully unzipping and lceaning each year's IAT data)
