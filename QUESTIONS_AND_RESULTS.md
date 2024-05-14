# PRODUCTION OF WHEAT FLOUR

**DASHBOARD**: https://lookerstudio.google.com/s/v3OtnouAGfM <br />

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

--❓ Q12.IN 2023 USE DOWNTIME GROUP
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

--❓ Q13.IN 2023 USE TRADE
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

--❓ Q14.IN 2023 USE yield 
````sql
SELECT 
	MAT.Materialdescription,
	coalesce (SUM(FG.FGQuatity),0) AS FG,
	coalesce (SUM(f3.F3Quatity),0) AS FlourCO,
	coalesce (SUM(CF.SumofQuatity),0) AS CleaningFlour,
	coalesce (SUM(B.BranQuatity),0) AS Bran,
	coalesce (SUM(M.Tempwheat),0) AS Tempwheat,
    Round((((coalesce (SUM(FG.FGQuatity),0))+(coalesce (SUM(f3.F3Quatity),0))+(coalesce (SUM(CF.SumofQuatity),0))+(coalesce (SUM(B.BranQuatity),0)))*-1)/SUM(M.Tempwheat*1000.0)*100.0,2) AS Yield
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
WHERE Tempwheat &gt; 0 
Group By MAT.Material;
````

--❓ Q15.IN 2023 USE LOSS IN PROCESS
````sql
SELECT 
	PO.ProcessOrder,
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
WHERE Tempwheat &gt; 0 
Group By PO.ProcessOrder;

````

--❓ Q16.IN 2023 USE OEE
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


