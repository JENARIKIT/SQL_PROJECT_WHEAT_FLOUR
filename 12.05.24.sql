/* 🌾 PRODUCTION OF WHEAT FLOUR🌾 

**📊 DASHBOARD**: https://lookerstudio.google.com/s/v3OtnouAGfM 


# This report utilizes SQL to analyze data pertaining to wheat flour production in the year 2023, encompassing the following metrics
   **🟢 Quantity of raw materials consumed** <br />
   **🟢 Number of products manufactured** <br />
   **🟢 Operational time** <br />
   **🟢 Production process downtime** <br />
   **🟢 OEE values** <br />
   **🟢 Performance values** <br />
   **🟢 Quality values** <br />
   **🟢 Availability** values <br /> 


**❗❗ This report is based on hypothetical data ❗❗**

🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾🌾 */


🟠 **Q1.** List the total amount of Raw Material used in 2023 
````sql
SELECT 
	M.Materialdescription,
	ROUND(SUM(F.Quantity)/1000.0,2) AS "QUANTITY_(TON)"
From FinalTransaction as F , Material as M
WHERE F.MaterialNO = M.Material
AND F.Materialdescription like 'RM%'
AND Date Like '2023%'
Group by F.Materialdescription
Order by F.Materialdescription;
````
🟣**Results:**

Materialdescription  				|QUANTITY_(TON)|
------------------------------------------------|--------------|
AUSTRALIAN PRIME HARD 13.5% 			|   495.88     |
AUSTRALIAN PRIME HARD 14%  			|  7025.18     |
AUSTRALIAN PREMIUM WHITE 10.5% 			|  5327.19     |
AUSTRALIAN STANDARD WHITE 10%			|  5916.95     |
RM-CWAD16-CANADIAN WESTERN AMBER DURUM16 	|    51.94     |
CANADA WESTERN RED SPRING 13.5%  		| 13710.43     |
DARK NORTHERN SPRING 14.5%			|  6771.83     |
NORTHERN SPRING 14%				|  1783.63     |
SOFT WHITE 10.5%				|  1487.95     |
UNION WHEAT 10.5%				|  3108.62     |
UNION WHEAT 12.5%				| 19300.13     |
WESTERN WHITE 10.5%				|   100.39     |


🟠 **Q2.** List the total amount of Water used in 2023 
````sql
SELECT 
	strftime('%Y-%m',StartDate_Cleaning)   AS MonthID,
	SUM(Water) AS &quot;Water(MT)&quot;
From MASTER
WHERE MonthID like '2023%'
Group by MonthID
Order by MonthID;</sql><sql name="Q3">--IN 2023 USE Reprocess 
````

🟣**Results:**

MonthID		    |Water(MT)	  |
-------------------|--------------|
2023-01	       	   |219.605	  |
2023-02		   |149.481	  |
2023-03		   |238.54	  |
2023-04		   |223.521	  |
2023-05		   |302.792	  |
2023-06		   |220.048	  |
2023-07		   |250.511	  |
2023-08		   |246.633	  |
2023-09		   |251.796	  |
2023-10		   |228.649	  |
2023-11	     	   |238.089	  |
2023-12		   |196.175	  |

🟠 **Q3.** List the total amount of Reprocess-Product used in Process 2023
````sql
SELECT 
	strftime('%Y-%m',Date) 		  AS MonthID,
	ROUND(SUM((Quantity)/1000.0),2)   AS &quot;Quantity(MT)&quot;,
	note
From FinalTransaction
WHERE Note = &quot;REPROCESS&quot;
AND  MonthID like '2023%'
Group by MonthID
Order by MonthID;
````
🟣**Results:**

MonthID		    |Quantity(MT)  | Note	  |
--------------------|--------------|--------------|
2023-01		    |42.7	   |REPROCESS	  |
2023-02	            |15.1	   |REPROCESS	  |
2023-03	   	    |58.3	   |REPROCESS 	  |
2023-04		    |49.24	   |REPROCESS 	  |
2023-05		    |62.57	   |REPROCESS	  |
2023-06	            |31.64	   |REPROCESS	  |
2023-07	            |38.2	   |REPROCESS	  |
2023-08	            |44.2	   |REPROCESS	  |
2023-09	            |25.75	   |REPROCESS	  |
2023-10	            |52.06	   |REPROCESS	  |
2023-11	            |41.29	   |REPROCESS	  |
2023-12	            |62.58	   |REPROCESS	  |


🟠 **Q4.** List the total amount of Downgrade produced in the 2023 process.
````sql
SELECT 
	strftime('%Y-%m',PD.start_date) 		AS MonthID,
	Round((Sum(CF.SumofQuatity*-1))/1000.0,3) 	AS &quot;Quantity(MT)&quot;
From ProcessOrder as PD , CleaningFlour as CF
WHERE PD.ProcessOrder = CF.RowLabels
AND MonthID like '2023%'
GROUP BY MonthID
ORDER by MonthID;
````
🟣**Results:**

MonthID		    |Quantity(MT)  | 
--------------------|--------------|
2023-01 	    |123.889	   |
2023-02		    |69.438	   |
2023-03 	    |119.448	   |
2023-04		    |90.809	   |
2023-05		    |135.278	   |
2023-06		    |111.32	   |
2023-07		    |121.751	   |
2023-08		    |127.154	   |
2023-09		    |112.486	   |
2023-10		    |108.439	   |
2023-11		    |126.537	   |
2023-12		    |64.744	   |


🟠 **Q5.** IN 2023 USE ChangeOvertime
````sql
SELECT 
	count(ProcessOrder)		 AS Change_Overtimes,
	strftime('%Y-%m',start_date) 	 AS MonthID
FROM ProcessOrder
WHERE MonthID like '2023%'
GROUP by MonthID;
````

🟣**Results:**
Change_Overtimes    |  MonthID     | 
--------------------|--------------|
54		    |2023-01	   |
37		    |2023-02	   |
61		    |2023-03	   |
52		    |2023-04	   |
73		    |2023-05	   |
59		    |2023-06	   |
63		    |2023-07	   |
76		    |2023-08	   |
71		    |2023-09	   |
59	 	    |2023-10	   |
66		    |2023-11	   |
50		    |2023-12	   |

🟠 **Q6.** List the total amount of Finished goods produced in the 2023 process.
````sql
SELECT 
	M.Materialdescription,
	(FG.FGQuatity/1000.0)*-1	 AS QUANTITY,
	strftime('%Y',P.start_date) 	 AS YEAR
FROM ProcessOrder as P,Material AS M,FG
WHERE M.Material = P.Material_ID
AND P.ProcessOrder = FG.RowLabels
AND YEAR = '2023'
Group by Material
Order by Materialdescription;
````

🟣**Results:**

Materialdescription |  QUANTITY    |  YEAR    	  |  
--------------------|--------------|--------------|
Flour-Bread1	    | 	47.166	   |    2023      |
Flour-Bread4	    |	59.832	   |	2023      |
Flour-Bread5	    |	48.741	   |	2023      |
Flour-Bread6	    |	58.575	   |	2023      |
Flour-CrispyFlour1  |	11.904	   |	2023      |
Flour-CrispyFlour2  |	30.566	   |	2023      |
Flour-Feed1	    |	61.919	   |	2023      |
Flour-Feed3	    |	71.876	   |	2023      |
Flour-FriedChicken1 |	46.706	   |	2023      |
Flour-Noodle1	    |	56.414	   |	2023      |
Flour-Noodle3	    |	62.392	   |	2023      |

🟠 **Q7.** List the total amount of Temperd Wheat produced in the 2023 process.
````sql
SELECT 
 	Mat.Materialdescription,
	Tempwheat,
 	strftime('%Y',P.start_date) AS MonthID
 FROM MASTER AS M , ProcessOrder AS P , Material As Mat
 WHERE M.ProcessOrder = P.ProcessOrder
 AND P.Material_ID = Mat.Material
 AND MonthID Like '2023%' 

 AND Mat.Material != '3100000090' --ไม่เอา &quot;WFC
 Group BY Mat.Materialdescription;
````
🟣**Results:**

Materialdescription |  Tempwheat   |  MonthID     |  
--------------------|--------------|--------------|
Flour-Bread1	    |	70.021	   |	2023      |
Flour-Bread4	    |	83.771	   |	2023      |
Flour-Bread5	    |	68.859	   |	2023      |
Flour-Bread6	    |	83.765	   |	2023      |
Flour-CrispyFlour1  |	18.978	   |	2023      |
Flour-CrispyFlour2  |	51.383	   |	2023      |
Flour-Feed1	    |	89.264	   |	2023      |
Flour-Feed3	    |	90.451	   |	2023      |
Flour-FriedChicken1 |	76.784	   |	2023      |
Flour-Noodle1	    |	87.622	   |	2023      |
Flour-Noodle3	    |	88.768	   |	2023      |


🟠 **Q8.** List the total amount of Downtime in Production process of 2023.
````sql
SELECT 
  Sum(Total_Time) AS DOWNTIME_MIN,
  strftime ('%Y-%m',Date) AS MonthID
FROM DOWNTIME
WHERE MonthID Like '2023%'
AND DowntimeNo != '11'
Group by MonthID;
````
🟣**Results:**

DOWNTIME_MIN        |  MonthID     | 
--------------------|--------------|
497   		    |	2023-01    |
698   		    |	2023-03    |
244   		    |	2023-04    |
1189   		    |	2023-05    |
1828   		    |	2023-06    |
2533   		    |	2023-07    |
1214   		    |	2023-08    |
1102   		    |	2023-09    |
1444   		    |	2023-10    |
1287   		    |	2023-11    |
661   		    |	2023-12    |


🟠 **Q9.** List the total amount of Runtime used in Process 2023
````sql
SELECT 
	SUM(Total_HR) AS Total_HR ,
	Round(SUM(Total_HR*60),0) AS Total_MIN,
	Round(SUM((Total_HR*60)/(60*24.0)),2) AS Total_DAY,
	strftime('%Y-%m',StartDate_Milling) AS MonthID
FROM MASTER 
WHERE MonthID Like '2023%'
Group by MonthID;
````
🟣**Results:**
Total_HR |  Total_MIN   |  Total_DAY    |   MonthID   |
---------|--------------|---------------|-------------| 
402.04   |	24122.0 |	16.75	|   2023-01   |
299.41   |	17965.0 |	12.48	|   2023-02   |
472.4    |	28344.0 |	19.68	|   2023-03   |
419.31   |	25159.0 |	17.47	|   2023-04   |
575.96   |	34558.0 |	24.0 	|   2023-05   |
481.15   |	28869.0 |	20.05	|   2023-06   |
542.57   |	32554.0 |	22.61	|   2023-07   |
797.66   |	47860.0 |	33.24	|   2023-08   |
587.43   |	35246.0 |	24.48	|   2023-09   |
623.39   |	37403.0 |	25.97	|   2023-10   |
580.55   |	34833.0 |	24.19	|   2023-11   |
530.55   |	31833.0 |	22.11	|   2023-12   |



🟠 **Q10.** List of working days in 2023
````sql
SELECT
Count(DISTINCT  date) 	AS WorkingDay ,
strftime('%Y-%m',Date) 	AS MonthID
FROM FinalTransaction
Where MonthID Like '2023%'
AND Movementtype In ('101','102')
Group by MonthID;
````
🟣**Results:**
WorkingDay |  MonthID | 
-----------|----------|
25	   |  2023-01 |
22	   |  2023-02 |
28	   |  2023-03 |
22	   |  2023-04 |
29	   |  2023-05 |
28	   |  2023-06 |
30	   |  2023-07 |
31	   |  2023-08 |
30	   |  2023-09 |
31	   |  2023-10 |
29	   |  2023-11 |
25	   |  2023-12 |


🟠 **Q11.** List of working hours per day (HR/Day) in 2023
````sql
SELECT 
	R.Total_MIN,
	R.Total_HR,
	R.Total_DAY,
	W.WorkingDay,
	Round((R.Total_HR/W.WorkingDay),2) AS Working_HR_DAY
FROM Runtime AS R , WorkingDay AS W 
WHERE R.MonthID = W.MonthID
Group by R.MonthID;
````
🟣**Results:**
Total_MI  | Total_HR | Total_DAY  |  WorkingDay | Working_HR_DAY | 
----------|----------|------------|-------------|----------------|
24122.0	  | 402.04   |   16.75    | 	25    	|	16.08    |
28344.0	  | 472.4    | 	 19.68    |	28    	|	16.87	 |
25159.0	  | 419.31   | 	 17.47    |	22    	|	19.06    |
34558.0	  | 575.96   | 	 24.0     |	29    	|	19.86    |    
28869.0	  | 481.15   | 	 20.05    |	28    	|	17.18    |
32554.0	  | 542.57   | 	 22.61    |	30    	|	18.09    |
47860.0	  | 797.66   | 	 33.24    |	31    	|	25.73    |
35246.0	  | 587.43   | 	 24.48    |	30    	|	19.58    |
37403.0	  | 623.39   | 	 25.97    |	31    	|	20.11    |
34833.0	  | 580.55   | 	 24.19    |	29    	|	20.02    |
31833.0	  | 530.55   | 	 22.11    |	25    	|	21.22    |

🟠 **Q12.** List of production downtime in 2023, by group
````sql
SELECT 
  	GT.DowntimeNo,
  	GT.DowntimeDescription,
	Sum(Total_Time) AS DOWNTIME_MIN,
	strftime ('%Y',Date) AS Year
FROM DOWNTIME AS DT , GroupDT AS GT
WHERE DT.DowntimeNo = GT.DowntimeNo
AND Year Like '2023%'
Group by GT.DowntimeNo
Order By Year;
````
🟣**Results:**
DowntimeNo |  DowntimeDescription |DOWNTIME_MIN |Year| 
-----------|----------------------|-------------|----|
1	   |  MECHANICAL LOSSES   |	263     |2023|
2	   |  ELECTRICAL LOSSES   | 	99      |2023|
3	   |  MECHANIC UTILITY    |	158     |2023|
4	   |  ELECTRICAL UTILITY  | 	156     |2023|
5	   |  OTHER UTILITY       | 	909     |2023|
6	   |  PRODUCTION          |	10512   |2023|
7	   |  CLEAR_LINE_PLAN     | 	200     |2023|
8	   |  CLEAR_LINE_UNPLAN   | 	549     |2023|
11	   |  OTHER 		  |	11846   |2023|


🟠 **Q13.** List of product transactions in 2023, by transaction type
````sql
SELECT 
	T.Trade,
	SUM(FG.FGQuatity/1000.0)*-1 AS QUANTITY,
	strftime('%Y-%m',P.start_date) AS MonthID
FROM ProcessOrder as P,Material AS M,FG,Trade As T
WHERE M.Material = P.Material_ID
AND P.ProcessOrder = FG.RowLabels
AND T.Material = P.Material_ID
AND MonthID like '2023%'
Group by T.Trade,MonthID
Order by MonthID;
````
🟣**Results:**
TRADE	             |  QUANTITY	       |   MonthID   |
---------------------|-------------------------|-------------|
DOMESTIC TRADE	     |		882.049	       |   2023-01   |
INTERNATIONAL TRADE  |		2376.385       |   2023-01   |
DOMESTIC TRADE	     |		305.951	       |   2023-02   |
INTERNATIONAL TRADE  |		1962.699       |   2023-02   |
DOMESTIC TRADE	     |		946.146	       |   2023-03   |
INTERNATIONAL TRADE  |		2622.173       |   2023-03   |
DOMESTIC TRADE	     |		1106.547       |   2023-04   |
INTERNATIONAL TRADE  |		2001.842       |   2023-04   |
DOMESTIC TRADE	     |		929.583        |   2023-05   |
INTERNATIONAL TRADE  |		3404.82	       |   2023-05   |
DOMESTIC TRADE	     |		773.814	       |   2023-06   |
INTERNATIONAL TRADE  |		2788.037       |   2023-06   |
DOMESTIC TRADE	     |		565.976	       |   2023-07   |
INTERNATIONAL TRADE  |		2969.353       |   2023-07   |
DOMESTIC TRADE	     |		982.001	       |   2023-08   |
INTERNATIONAL TRADE  |		3305.334       |   2023-08   |
DOMESTIC TRADE	     |		910.797	       |   2023-09   |
INTERNATIONAL TRADE  |		2921.9	       |   2023-09   |
DOMESTIC TRADE	     |		579.165        |   2023-10   |
INTERNATIONAL TRADE  |		2617.765       |   2023-10   |
DOMESTIC TRADE	     |		1343.225       |   2023-11   |
INTERNATIONAL TRADE  |		2144.641       |   2023-11   |
DOMESTIC TRADE	     |		863.639	       |   2023-12   |
INTERNATIONAL TRADE  |		2093.337       |   2023-12   |



🟠**Q14**. Yield in 2023 
````sql
SELECT 
	MAT.Materialdescription,
	coalesce (SUM(FG.FGQuatity)*-1/1000.0,0) AS FG,
	coalesce (SUM(f3.F3Quatity)*-1/1000.0,0) AS FlourCO,
	coalesce (SUM(CF.SumofQuatity)*-1/1000.0,0) AS CleaningFlour,
	coalesce (SUM(B.BranQuatity)*-1/1000.0,0) AS Bran,
	coalesce (SUM(M.Tempwheat),0) AS Tempwheat,
    Round(((((coalesce (SUM(FG.FGQuatity),0))+(coalesce (SUM(f3.F3Quatity),0))+(coalesce (SUM(CF.SumofQuatity),0))+(coalesce (SUM(B.BranQuatity),0)))*-1)/SUM(M.Tempwheat*1000.0))*100.0,2) AS Yield
FROM FG
LEFT join ProcessOrder as PO
on PO.ProcessOrder = FG.RowLabels
LEFT join F3
on PO.ProcessOrder = F3.RowLabels
LEFT join CleaningFlour as CF
on PO.ProcessOrder = CF.RowLabels
LEFT join Bran AS B
on PO.ProcessOrder = B.RowLabels
LEFT join MASTER AS M
on PO.ProcessOrder = M.ProcessOrder
LEFT join Material AS MAT
on PO.Material_ID = MAT.Material
WHERE Tempwheat > 0 
Group By MAT.Material;
````
🟣**Results:**

Materialdescription|        FG      |    FlourCO  |   CleaningFlour  |    Bran     |   Tempwheat    |   Yield     | 
-------------------|----------------|-------------|------------------|-------------|----------------|-------------|
Flour-Bread1	   |	7348.32501  |	670.35801 |	313.96101    |	2014.101   |	10661.471   |	97.05     |
Flour-Noodle1	   |	3773.281    |	966.235   |	149.355      |	1069.038   |	6118.562    |	97.37     |
Flour-Feed1	   |	23560.34407 |	84.913    |	494.015	     |	5578.74704 |	30249.356   |	98.24     |
Flour-Feed3	   |	4910.015    |	0.034     |	127.869	     |	1134.721   |	6255.855    |	98.67     |
Flour-CrispyFlour1 |	186.65	    |	10.854	  |	12.782	     |	50.065     |	265.085	    |	98.21     |
Flour-FriedChicken1|	835.01501   |	192.354	  |	38.464 	     |	244.425	   |	1334.414    |	98.19     |
Flour-CrispyFlour2 |	1151.492    |	260.581	  |	52.909	     |	318.461	   |	1835.53	    |	97.16     |
Flour-Bread4	   |	4850.44401  |	700.66    |	226.525	     |	1243.7	   |	7165.491    |	97.99     |
Flour-Bread5	   |	469.606	    |	36.538	  |	23.571	     |	121.503	   |	664.876	    |	97.95     |
Flour-Bread6	   |	2488.83601  |	259.952	  |	118.064	     |	627.953	   |	3563.765    |	98.06     |
Flour-Noodle3	   |	1076.342    |	93.942	  |	22.994	     |	263.607	   |	1481.228    |	98.36     |

🟠 **Q15**.List of Loss in Process in 2023
````sql
SELECT 
	MAT.Materialdescription,
	coalesce (SUM(FG.FGQuatity)/1000.0,0) AS FG,
	coalesce (SUM(f3.F3Quatity)/1000.0,0) AS FlourCO,
	coalesce (SUM(CF.SumofQuatity)/1000.0,0) AS CleaningFlour,
	coalesce (SUM(B.BranQuatity)/1000.0,0) AS Bran,
	coalesce (SUM(RE.Quantity),0) AS Reprocess,
	coalesce (SUM(M.Tempwheat),0) AS Tempwheat,
    Round((((coalesce (SUM(FG.FGQuatity),0))+(coalesce (SUM(f3.F3Quatity),0))+(coalesce (SUM(CF.SumofQuatity),0))+(coalesce (SUM(B.BranQuatity),0)))/-1000.0)-(coalesce (SUM(RE.Quantity),0))-SUM(M.Tempwheat),2) AS LOSS_IN_PROCESS
FROM FG
LEFT join ProcessOrder as PO
on PO.ProcessOrder = FG.RowLabels
LEFT join F3
on PO.ProcessOrder = F3.RowLabels
LEFT join CleaningFlour as CF
on PO.ProcessOrder = CF.RowLabels
LEFT join Bran AS B
on PO.ProcessOrder = B.RowLabels
LEFT join MASTER AS M
on PO.ProcessOrder = M.ProcessOrder
LEFT join Material AS MAT
on PO.Material_ID = MAT.Material
Left join Reprocess AS RE
on PO.ProcessOrder = RE.PO
WHERE Tempwheat > 0 
Group By Materialdescription;

````
🟣**Results:**

Materialdescription|       FG	    |   FlourCO   |   CleaningFlour  |      Bran   |   Reprocess   |   Tempwheat    |LOSS_IN_PROCESS | 
-------------------|----------------|-------------|------------------|-------------|---------------|----------------|----------------|
Flour-Bread1 	   |	-7348.32501 | -670.35801  |	-313.96101   |	-2014.101  |	7.75	   |	10661.471   |	-322.48      |
Flour-Bread4	   |	-4850.44401 |	-700.66	  |	-226.525     |	-1243.7	   |	41.25	   |	7165.491    |	-185.41      |
Flour-Bread5	   |	-469.606    |	-36.538	  |	-23.571	     |	-121.503   |	9.12	   |	664.876	    |	-22.78       |
Flour-Bread6	   |	-2488.83601 |	-259.952  |	-118.064     |	-627.953   |	27.97	   |	3563.765    |	-96.93       |
Flour-CrispyFlour1 |	-186.65	    |	-10.854   |	-12.782	     |	-50.065    |	  0	   |	265.085	    |	-4.73        |
Flour-CrispyFlour2 |	-1151.492   |	-260.581  |	-52.909	     |	-318.461   |	5.36	   |	1835.53	    |	-57.45       |
Flour-Feed1	   |	-23560.34407|	-84.913	  |	-494.015     |	-5578.74704|	302.81     |	30249.356   |	-834.15      |
Flour-Feed3	   |	-4910.015   |	-0.034	  |	-127.869     |	-1134.721  |	70.05	   |	6255.855    |	-153.27      |
Flour-FriedChicken1|	-835.01501  |	-192.354  |	-38.464	     |	-244.425   |	8.04	   |	1334.414    |	-32.2        |
Flour-Noodle1	   |	-3773.281   |	-966.235  |	-149.355     |	-1069.038  |	32.75	   |	6118.562    |	-193.4       |
Flour-Noodle3	   |	-1076.342   |	-93.942	  |	-22.994	     |	-263.607   |	15.7	   |	1481.228    |	-40.04       |



🟠 **Q16**.Values of OEE, Performance, Quality, and Availability in 2023
````sql
/*CREATE VIEW IN_2023_USE_OEE

AS */

--1.สร้างTable B1/Downgrade/FG Join กับ Downtime โดยไม่เอา Group 11 โดยใช้ select ซ้อน select

--2.หาค่า A P Q OEE

--Step1 Create Table Tempwheat

 /* CREATE TABLE Tempwheat
AS
SELECT 
 SUM(Tempwheat) AS Tempwheat,
 strftime('%Y-%m',P.start_date) AS MonthID
 FROM MASTER AS M , ProcessOrder AS P , Material As Mat
 WHERE M.ProcessOrder = P.ProcessOrder
 AND P.Material_ID = Mat.Material
 AND MonthID Like '2023%'

 AND Mat.Material != '3100000090'
 Group BY MonthID;   */
 -------------------------------------------------------------
 --Step2 CREATE table Downgrade
  
/* Create table Downgrade
 AS
 SELECT 
strftime('%Y-%m',PD.start_date) AS MonthID,
Round((Sum(CF.SumofQuatity*-1))/1000.0,3) AS &quot;DownGrade_Quantity&quot;
From ProcessOrder as PD , CleaningFlour as CF
WHERE PD.ProcessOrder = CF.RowLabels
AND MonthID like '2023%'
GROUP BY MonthID
ORDER by MonthID;  */
  -------------------------------------------------------------
 --Step3 CREATE table FG
 
 /*  CREATE TABLE FG_Recive
 AS
 SELECT 
	SUM(FG.FGQuatity/1000.0)*-1 AS QUANTITY,
	strftime('%Y-%m',P.start_date) AS MonthID
FROM ProcessOrder as P,Material AS M,FG
WHERE M.Material = P.Material_ID
AND P.ProcessOrder = FG.RowLabels
AND MonthID like '2023%'
Group by MonthID
Order by MonthID; */
 
  -------------------------------------------------------------
 SELECT 
RT.MonthID,
RT.Total_HR AS RUNTIME_HR,
ROUND((DT.DownTime_MIN/60.00),2) AS DownTime_HR ,
ROUND((RT.Total_HR)*100.0/((DT.DownTime_MIN/60.00)+RT.Total_HR),2) AS A,
ROUND(TW.Tempwheat,2) AS Tempwheat,
ROUND((TW.Tempwheat/RT.Total_HR)*100.0/(11.0),2) AS P,
DG.DownGrade_Quantity AS Downgrade,
FR.Quantity AS FG_Recive,
ROUND(((FR.Quantity-DG.DownGrade_Quantity)/(FR.Quantity))*100,2) AS Q,
ROUND(((RT.Total_HR)*100.0/((DT.DownTime_MIN/60.00)+RT.Total_HR))*((TW.Tempwheat/RT.Total_HR)*100.0/(11.0))*(((FR.Quantity-DG.DownGrade_Quantity)/(FR.Quantity))*100)/10000.0,2) AS OEE
FROM

(	 SELECT 
  Sum(Total_Time) AS DOWNTIME_MIN,
  strftime ('%Y-%m',Date) AS MonthID
FROM DOWNTIME AS DT , GroupDT AS GT
WHERE DT.DowntimeNo = GT.DowntimeNo
AND MonthID Like '2023%'
AND DT.DowntimeNo != '11' --ไม่เอา Downtimegroup นี้
Group by MonthID
Order By MonthID 		) AS  DT  ,  Runtime AS RT  ,  Tempwheat AS TW  , Downgrade As DG ,  FG_Recive AS FR
WHERE DT.MonthID = RT.MonthID
AND DT.MonthID = TW.MonthID
AND DT.MonthID = DG.MonthID
AND DT.MonthID = FR.MonthID;   
 

````
🟣**Results:**
MonthID |RUNTIME_HR|DownTime_HR|   A   | Tempwheat|       P     | Downgrade |FG_Recive   |   Q  |  OEE |
--------|----------|-----------|-------|----------|-------------|-----------|------------|------|------|
2023-01	|  402.04  |	8.28   | 97.98 | 4281.25  |	96.81   |  123.889  |	3258.434 | 96.2 | 91.25|
2023-02	|  299.41  |	2.48   | 99.18 | 3069.73  |	93.21   |   69.438  |	2268.65  | 96.94| 89.61|
2023-03	|  472.4   |	11.63  | 97.6  | 4831.81  |	92.98   |  119.448  |	3568.319 | 96.65| 87.71|
2023-04	|  419.31  |	4.07   | 99.04 | 4208.01  |	91.23   |   90.809  |	3108.389 | 97.08| 87.72|
2023-05	|  575.96  |	19.82  | 96.67 | 5914.66  |	93.36   |  135.278  |	4334.403 | 96.88| 87.43|
2023-06	|  481.15  |	30.47  | 94.05 | 4718.7	  |     89.16   |  111.32   |	3561.851 | 96.87| 81.23|
2023-07	|  542.57  |	42.22  | 92.78 | 4969.09  |	83.26   |  121.751  |	3535.329 | 96.56| 74.59|
2023-08	|  797.66  |	20.23  | 97.53 | 5895.51  |	67.19   |  127.154  |	4287.335 | 97.03| 63.59|
2023-09	|  587.43  |	18.37  | 96.97 | 5353.16  |	82.84   |  112.486  |	3832.697 | 97.07| 77.97|
2023-10	|  623.39  |	24.07  | 96.28 | 4452.13  |	64.93   |  108.439  |	3196.93	 | 96.61| 60.39|
2023-11	|  580.55  |	21.45  | 96.44 | 4948.74  |	77.49   |  126.537  |	3487.866 | 96.37| 72.02|
2023-12	|  530.55  |	11.02  | 97.97 | 4043.1   | 	69.28   |  64.744   |	2956.976 | 97.81| 66.38|
