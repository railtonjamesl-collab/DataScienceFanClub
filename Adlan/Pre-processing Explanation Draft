Pre-processing
In wanting to remove companies from the dataset that had less than 3 years of data, we applied two methods (looking at distinct and consecutive years) and found a discrepancy in the number of remaining values. In trying to understand this, we identified the issue: some companies had entire missing years. This motivated our decision to remove these companies entirely from the dataset for two reasons:
1.	The model would incorrectly use data from two years back (given it looks at the previously available year) which wouldn’t fit our goal of only wanting to look at data from the previous year
2.	Imputing the values would introduce a lot of additional assumptions that could reduce the accuracy of our results and require additional computational power/resources that would be more suitable for a longer-term project 
As a result, our pre-processing involved:
1.	Removing companies that had entire missing years 

