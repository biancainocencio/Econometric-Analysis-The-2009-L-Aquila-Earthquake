````markdown
# 🌍 Econometric Impact Analysis: The 2009 L'Aquila Earthquake

This project investigates the **causal effects of the 2009 Abruzzo earthquake** in Italy, with a particular focus on labor market outcomes, household income, and GDP. We apply a combination of econometric techniques—including **Difference-in-Differences (DiD)** and **Synthetic Control Method (SCM)**—to assess the socioeconomic aftermath of the natural disaster.

## 📌 Objective

To determine the economic and social impact of the 2009 earthquake in Abruzzo by comparing the region to suitable controls (e.g., Molise and Marche) across key metrics:
- Total Employment
- Household Income
- Regional GDP

---

## 🗂️ Dataset

The data includes cleaned regional-level panel datasets from ISTAT and Eurostat for the years surrounding the earthquake (pre- and post-2009). Key variables used:
- `emp`: total employment
- `income`: household income
- `gdpinmillions`: regional GDP
- `unemployment`, `populationolderthan15thousand`, etc. for synthetic control construction

---

## 🧠 Methodology

### 1. 📉 Difference-in-Differences (DiD)

Used to compare pre- and post-treatment changes in Abruzzo against a control group (Molise).

#### Labour Market

```stata
collapse (sum) emp, by(anno regione)
reshape wide total_employed, i(anno) j(regione) string
pwcorr ABRUZZOtotal_employed MOLISEtotal_employed, sig star(.01)
reg total_employed abruzzo##treatyears ib(2009).year
````

#### Household Income

```stata
gen time=0
replace time=1 if anno>=2009
gen treatment=0
replace treatment=1 if regione=="Abruzzo"
gen time_treatment=time*treatment
regress income time treatment time_treatment
```

#### GDP (DiD Regression)

```stata
gen Post=0
replace Post=1 if year > 2009
gen inter = treat * Post
reg gdp treat##Post ib(#10).year
```

---

### 2. 🧪 Synthetic Control Method (SCM)

Used to assess the counterfactual GDP evolution of Abruzzo had the earthquake not occurred.

```stata
synth gdpinmillions unemployment populationolderthan15thousand householdincome, ///
    trunit(14) trperiod(2009) nested fig keep(result_synth) replace
```

Post-estimation steps include:

```stata
use result_synth.dta, clear
gen gap=_Y_treated-_Y_synthetic
save result2_synth, replace
```

---

## 📊 Visualizations

All key outcomes were plotted using **Python’s Matplotlib** to illustrate pre- and post-treatment trends.

### Employed Population

```python
plt.plot(pivoted_df['year_relative'], pivoted_df['ABRUZZO'], label='ABRUZZO', linestyle='-', marker='o', color='black')
plt.plot(pivoted_df['year_relative'], pivoted_df['MOLISE'], label='MOLISE', linestyle='--', marker='x', color='black')
```

### Household Income

```python
plt.plot(df_new['Year_relative'], df_new['Abruzzo'], label='Abruzzo', linestyle='-', marker='o', color='black')
plt.plot(df_new['Year_relative'], df_new['Molise'], label='Molise', linestyle='--', marker='x', color='black')
```

---

## 🧾 Key Findings

* **Employment and Income**: Results suggest that Abruzzo experienced a significant relative decline in employment and income post-2009, validating the causal effect of the earthquake.
* **GDP Trends**: The synthetic control method shows a widening gap between the actual and counterfactual GDP trajectory, confirming that Abruzzo underperformed economically relative to similar Italian regions.
* **Parallel Trends**: Checked and partially validated for income/employment; rejected for GDP using Marche as control, justifying the use of SCM.

---

## 🧰 Tools & Technologies

* 📦 **Stata**: Econometric modeling, DiD and SCM
* 📈 **Python (Matplotlib)**: Visualization of trends and treatment effects
* 📊 **Data**: Cleaned and pre-aggregated regional time-series data (2000–2015)

---

## 📚 Learn More

This project was conducted as part of an advanced econometrics coursework. If you'd like to see the full presentation or methodology breakdown, check out the attached PDF:
[📄 Econometric Analysis - Abruzzo Earthquake](./Econometric%20Analysis%20-%20Abruzzo%20earthquake%20%281%29.pdf)

---

## 📫 Contact

* [LinkedIn](https://www.linkedin.com/in/biancainocencio/)
* [GitHub](https://github.com/biancainocencio)
* 📩 Email: [contactbiancainocencio@gmail.com](mailto:contactbiancainocencio@gmail.com)

```

---
