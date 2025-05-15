
# This R file documents the steps carried out in Stata for the econometric analysis

# PART 1: LABOUR MARKET
# Collapse and reshape
# collapse (sum) emp, by(anno regione)
# reshape wide total_employed, i(anno) j(regione) string

# Correlation and DiD
# pwcorr ABRUZZOtotal_employed MOLISEtotal_employed, sig star(.01)
# gen abruzzo=0
# replace abruzzo=1 if region=="ABRUZZO"
# reg total_employed abruzzo##treatyears ib(2009).year

# Income DiD setup
# gen time=0
# replace time=1 if anno>=2009
# gen treatment=0
# replace treatment=1 if regione=="Abruzzo"
# gen time_treatment=time*treatment
# regress income time treatment time_treatment

# PART 2: GDP
# Pre-treatment test
# regress gdp time treat time_treat

# Synthetic Control
# tsset region_code year
# synth gdpinmillions unemployment populationolderthan15thousand householdincome, trunit(14) trperiod(2009) nested fig keep(result_synth) replace

# Post-synth analysis
# use result_synth.dta, clear
# gen gap=_Y_treated-_Y_synthetic
# keep gap _time
# save result2_synth, replace

# DiD with weights from synth
# gen year_indicator = year - 2009
# gen Post=0
# replace Post=1 if year_indicator>0
# gen inter = treat * Post
# reg gdp treat##Post ib(#10).year

# Falsification check
# replace year_indicator = year-2007
# drop Post
# gen Post=0
# replace Post=1 if year_indicator>0
# replace inter = treat * Post
