
# GRAPHS - PYTHON

import matplotlib.pyplot as plt

# CODE FOR “TOTAL EMPLOYED”
plt.figure(figsize=(10, 5))
# Plotting Abruzzo with a solid black line
plt.plot(pivoted_df['year_relative'], pivoted_df['ABRUZZO'], label='ABRUZZO', linestyle='-', marker='o', color='black')
# Plotting Molise with a dotted black line
plt.plot(pivoted_df['year_relative'], pivoted_df['MOLISE'], label='MOLISE', linestyle='--', marker='x', color='black')
# Adding titles and labels
plt.title('Total Employed in Abruzzo and Molise Relative to 2009')
plt.xlabel('Years Relative to 2009')
plt.ylabel('Total Employed')
plt.axvline(x=0, color='grey', linestyle='--') # Mark the year 2009
plt.legend()
plt.grid(True)

# CODE FOR “HOUSEHOLD INCOME”
plt.figure(figsize=(10, 5))
# Re-plotting to save the figure with the new title
plt.plot(df_new['Year_relative'], df_new['Abruzzo'], label='Abruzzo', linestyle='-', marker='o', color='black')
plt.plot(df_new['Year_relative'], df_new['Molise'], label='Molise', linestyle='--', marker='x', color='black')
plt.title('Household Income for Abruzzo and Molise Relative to 2009')
plt.xlabel('Years Relative to 2009')
plt.ylabel('Household Income')
plt.axvline(x=0, color='grey', linestyle='--')
plt.legend()
plt.grid(True)
