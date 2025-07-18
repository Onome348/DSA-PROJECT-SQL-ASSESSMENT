SELECT [Row_ID]
      ,[Order_ID]
      ,[Order_Date]
      ,[Order_Priority]
      ,[Order_Quantity]
      ,[Sales]
      ,[Discount]
      ,[Ship_Mode]
      ,[Profit]
      ,[Unit_Price]
      ,[Shipping_Cost]
      ,[Customer_Name]
      ,[Province]
      ,[Region]
      ,[Customer_Segment]
      ,[Product_Category]
      ,[Product_Sub_Category]
      ,[Product_Name]
      ,[Product_Container]
      ,[Product_Base_Margin]
      ,[Ship_Date]
  FROM [DSA_project].[dbo].[KMS Sql Case Study ];


-----CASE SCENERIO I
----Assessment 1
----Which product category had the highest sales?
SELECT MAX(Product_Category)
FROM [KMS Sql Case Study ];


----Assessment 2
----What are the Top 3 and Bottom 3 regions in terms of sales?
SELECT TOP 3 Region,SUM(Sales) AS Region_sales
FROM [KMS Sql Case Study ]
GROUP BY Region
ORDER BY Region_sales DESC; 
SELECT TOP 3 Region,SUM(Sales) AS Region_sales
FROM [KMS Sql Case Study ]
GROUP BY Region
ORDER BY Region_sales; 

-----Assessment 3
----What were the total sales of appliances in Ontario?
SELECT SUM(Sales) FROM [KMS Sql Case Study ]
WHERE Product_Sub_Category = 'Appliance'
AND REGION = 'Ontario';

-----Assessment 4
----Advise the management of KMS on what to do to increase the revenue from the bottom 10 customers
SELECT TOP 10 (Sales),Customer_Name, Product_Name 
FROM [KMS Sql Case Study ]
ORDER BY Sales ASC
SELECT TOP 10 (Customer_Name), (Order_date) FROM [KMS Sql Case Study ]
ORDER BY Sales ASC;

SELECT TOP 10 (Customer_Name), MAX(Order_Date) AS PurchaseDate
FROM [KMS Sql Case Study ] 
ORDER BY Sales ASC;
  
-----Assessment  5
----KMS incurred the most shipping cost using which shipping method?
SELECT TOP 1 (Ship_Mode),
    SUM(Shipping_Cost) AS TotalShip_Cost
FROM
    [KMS Sql Case Study ]
GROUP BY
    Ship_Mode
ORDER BY
    TotalShip_Cost DESC;


-----CASE SCENERIO II
-----Assessment  6
-----Who are the most valuable customers, and what products or services do they typically purchase?
SELECT TOP 10 Customer_Name, SUM(Order_Quantity) AS Highest_Purchase
FROM [KMS Sql Case Study ]
GROUP BY Customer_Name
ORDER BY SUM(Order_Quantity) DESC;

----Assessment 7
----Which small business customer had the highest sales?
SELECT TOP 1 Customer_Name, SUM (Sales) AS Highest_Sales
FROM [KMS Sql Case Study ]
WHERE Customer_Segment = 'Small Business'
GROUP BY Customer_Name
ORDER BY Highest_Sales;

----Assessment 8
----Which Corporate Customer placed the most number of orders in 2009 – 2012?
SELECT TOP 1 Customer_Name, SUM(Order_Quantity) AS Num_Of_Orders
FROM [KMS Sql Case Study ]
WHERE Customer_Segment = 'Corporate'AND Order_Date BETWEEN '2009-01-01' AND '2012-12-31'
GROUP BY Customer_Name
ORDER BY Num_Of_Orders DESC;

----Assessment 9
----Which consumer customer was the most profitable one?
SELECT TOP 1 Customer_Name, SUM(TRY_CAST(Profit AS DECIMAL(18, 0))) AS Total_Profit
FROM [KMS Sql Case Study ]
WHERE Customer_Segment = 'Consumer'
GROUP BY Customer_Name
ORDER BY Total_Profit DESC; 

----sp_help '[KMS Sql Case Study ]'

ALTER TABLE [KMS Sql Case Study ]
ALTER COLUMN Profit DECIMAL(18, 0)
GO


----Assessment 10
----Which customer returned items, and what segment do they belong to?
SELECT DISTINCT Customer_Name,Customer_Segment
FROM [KMS Sql Case Study ]
WHERE Order_Quantity = '-1'
ORDER BY Customer_Name;

----Assessment 11
----If the delivery truck is the most economical but the slowest shipping method and Express Air is the fastest but the most expensive one, do you think the company appropriately spent shipping costs based on the Order Priority? Explain your answer
SELECT Order_Priority,Ship_Mode, 
    COUNT(*) AS Number_Of_Orders,
    SUM(Shipping_Cost) AS Total_ShippingCost, 
    AVG(Shipping_Cost) AS Average_Shipping_Cost,
    AVG(DATEDIFF(day, Order_Date, Ship_Date)) AS AvgShipDays 
FROM [KMS Sql Case Study ]
GROUP BY Order_Priority,Ship_Mode
ORDER BY Order_Priority, Number_Of_Orders DESC;

---- Explanation: Kultra Mega Stores (KMS) do not appropriately spend shipping costs based on the Order Priority, as there are several high number of order that was not given priority to and a long time shipping it , and some high numbers of orders are shipped with a fast shipping mode, some low orders, unspecified priority are sent on a fast shipping mode.