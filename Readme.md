# PRODUCTION OF WHEAT FLOUR

#ข้อมูลที่แสดงผลออกมาเป็นเพียงแค่การสมมติขึ้น

# 🌾 รายงานนี้เป็น การวิเคราะห์ SQL เกี่ยวกับการผลิตแป้งสาลี เช่น ตัวเลขการใช้วัตถุดิบ  ตัวเลขยอดสินค้าที่ผลิตได้ เวลาที่ใช้ในการทำงาน เวลาที่สูญเสียจากกระบวนการผลิต ยอด OEE , Performance , Quality , Avalidility ในปั 2023 🌾


-- 🐻:List the total number of reported crimes between 2018 and 2022?

````sql
````
--❓ Q1.IN 2023 USE RM (Wheat)
````sql
SELECT 
M.Materialdescription,
ROUND(SUM(F.Quantity)/1000.0,2) AS &quot;QUANTITY_(TON)&quot;,
strftime('%Y-%m',F.Date) AS MonthID
From FinalTransaction as F , Material as M
WHERE F.MaterialNO = M.Material
AND F.Materialdescription like 'RM%'
AND MonthID Like '2023%'
Group by F.Materialdescription,MonthID
Order by F.Materialdescription,MonthID; 
````

--❓ Q2.IN 2023 USE Water
````sql
SELECT 
strftime('%Y-%m',StartDate_Cleaning) AS MonthID,
SUM(Water) AS &quot;Water(MT)&quot;
From MASTER
WHERE MonthID like '2023%'
Group by MonthID
Order by MonthID;</sql><sql name="Q3">--IN 2023 USE Reprocess 
````

--❓ Q3.IN 2023 USE Reprocess
````sql
SELECT 
strftime('%Y-%m',Date) AS MonthID,
ROUND(SUM((Quantity)/1000.0),2) AS &quot;Quantity(MT)&quot;,
note
From FinalTransaction
WHERE Note = &quot;REPROCESS&quot;
AND  MonthID like '2023%'
Group by MonthID
Order by MonthID;
````

--❓ Q4.IN 2023 USE Downgrade
````sql
SELECT 
strftime('%Y-%m',PD.start_date) AS MonthID,
Round((Sum(CF.SumofQuatity*-1))/1000.0,3) AS &quot;Quantity(MT)&quot;
From ProcessOrder as PD , CleaningFlour as CF
WHERE PD.ProcessOrder = CF.RowLabels
AND MonthID like '2023%'
GROUP BY MonthID
ORDER by MonthID;
````
--❓ Q5.IN 2023 USE ChangeOvertime
````sql
SELECT 
count(ProcessOrder),
strftime('%Y-%m',start_date)AS MonthID
FROM ProcessOrder
WHERE MonthID like '2023%'
GROUP by MonthID;
````

--❓ Q6.IN 2023 USE FG
````sql
SELECT 
	M.Materialdescription,
	(FG.FGQuatity/1000.0)*-1 AS QUANTITY,
	strftime('%Y',P.start_date) AS YEAR
FROM ProcessOrder as P,Material AS M,FG
WHERE M.Material = P.Material_ID
AND P.ProcessOrder = FG.RowLabels
AND YEAR = '2023'
Group by Material
Order by Materialdescription;
````

--❓ Q7.IN 2023 USE B1
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

--❓ Q8.IN 2023 USE DOWNTIME
````sql
SELECT 
  Sum(Total_Time) AS DOWNTIME_MIN,
  strftime ('%Y-%m',Date) AS MonthID
FROM DOWNTIME
WHERE MonthID Like '2023%'
AND DowntimeNo != '11'
Group by MonthID;
````


--❓ Q9.IN 2023 USE Runtime
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

--❓ Q10.IN 2023 USE WorkingDAY
````sql
SELECT
Count(DISTINCT  date),
strftime('%Y-%m',Date) AS MonthID
FROM FinalTransaction
Where MonthID Like '2023%'
AND Movementtype In ('101','102')
Group by MonthID;
````

--❓ Q11.IN 2023 USE Workig(HR/Day)
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


