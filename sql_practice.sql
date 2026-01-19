select EmpID 
  , OrderDate
  , OrderTotal
from red_30_sales_cleaned
where EmpID = 900015476
order by OrderDate


select EmpID 
  , OrderDate
  , OrderTotal
from red_30_sales_cleaned
where EmpID = 900012972
order by OrderDate


select EmpID 
  , OrderDate
  , OrderTotal
from red_30_sales_cleaned
where EmpID in (900015476, 900012972, 900010875)
order by OrderDate


select *
from red_30_sales_cleaned
where OrderType = 'Retail'
  and OrderDate = '2018-08-05'
  or OrderDate = '2018-08-07'

select *
from red_30_sales_cleaned
where OrderType = 'Retail'
  and OrderDate between '2018-08-01' and '2018-08-31'

-- Aggregate functions

select EmpID
  , sum(Quantity)
  , sum(OrderTotal)
from red_30_sales_cleaned
where EmpID in (900015476, 900012972, 900010875)
group by EmpID

select EmpID
  , sum(Quantity)
  , sum(OrderTotal)
  , avg(Quantity) as AverageQuanity
  , avg(OrderTotal) as AverageOrderTotal
from red_30_sales_cleaned
where EmpID in (900015476, 900012972, 900010875)
group by EmpID

select EmpID
  , sum(Quantity)
  , sum(OrderTotal)
  , avg(Quantity) as AverageQuanity
  , avg(OrderTotal) as AverageOrderTotal
  , min(OrderTotal) SmallestOrderTotal
  , max(OrderTotal) as LargestOrderTotal
from red_30_sales_cleaned
where EmpID in (900015476, 900012972, 900010875)
group by EmpID


select EmpID
  , OrderType
  , sum(Quantity)
  , sum(OrderTotal)
  , avg(Quantity) as AverageQuanity
  , avg(OrderTotal) as AverageOrderTotal
  , min(OrderTotal) SmallestOrderTotal
  , max(OrderTotal) as LargestOrderTotal
from red_30_sales_cleaned
where EmpID in (900015476, 900012972, 900010875)
group by EmpID, OrderType


select count(*)
from red_30_sales_cleaned

select count(distinct(EmpID))
from red_30_sales_cleaned

-- functions

PRAGMA table_info(red_30_sales_cleaned); -- display the types of table colums


select cast(OrderDate as date)   -- cast or convert the type text into date
from red_30_sales_cleaned;


select EmpID
  , max(julianday(OrderDate)) - min(julianday(OrderDate)) as MinMaxDatediffDays
from red_30_sales_cleaned
where EmpID = 900010875


select OrderDate
  , strftime('%Y-%m-01', OrderDate) as FirstOfMonth
from red_30_sales_cleaned


select strftime('%Y-%m-01', OrderDate) as FirstOfMonth
  , sum(OrderTotal) as OrderTotalSum
from red_30_sales_cleaned
group by FirstOfMonth

-- inner join

select * 
from red_30_sales_cleaned as sc
inner join red_30_tech_us_customer_info as ci
  on sc.OrderNum = ci.OrderNum


select ci.OrderNum
  , ci.CustName
  , ci.CustomerType
  , ci.CustState
  , sr.State
  , sr.Region
  , sc.state_name
  , sc.state_code 
  , sc.state_timezone
from red_30_tech_us_customer_info as ci
inner join red_30_tech_us_sales_regions as sr 
  on ci.CustState = sr.State
inner join us_state_codes as sc 
  on ci.CustState = sc.state_name

-- Left join

select *
from red_30_sales_cleaned as sc 
left join red_30_tech_us_product_info as pi
  on sc.OrderNum = pi.OrderNum


select sr.State
  , sr.Region
  , usc.state_name
  , usc.state_code
from red_30_tech_us_sales_regions as sr 
left join us_state_codes as usc 
  on sr.State = usc.state_name


select sr.State
  , sr.Region
  , usc.state_name
  , usc.state_code
from us_state_codes as usc
left join red_30_tech_us_sales_regions as sr
  on sr.State = usc.state_name


select *
from red_30_sales_cleaned as sc 
left join red_30_tech_us_sales_associates as sa 
  on sc.EmpID = sa.EmpID
left join red_30_tech_us_customer_info as ci 
  on sc.OrderNum = ci.OrderNum
left join red_30_tech_us_sales_regions as sr 
  on ci.CustState = sr.State


  -- Common Table Expression (CTE)


WITH dupe_identifier AS (
    SELECT *,
           row_number() OVER (
               PARTITION BY OrderNum, OrderDate, EmpID
               ORDER BY OrderNum
           ) AS row_nbr
    FROM red_30_tech_us_sales
)
SELECT *
FROM dupe_identifier
WHERE row_nbr = 1;

select *
from red_30_tech_us_sales
where OrderNum in (1102922)

-- ...................................

with order_product_discounts as (
select sc.EmpID
  , pi.ProdCategory
  , sum(Discount) as DiscountSum
from red_30_sales_cleaned as sc 
left join red_30_tech_us_product_info as pi 
  on sc.OrderNum = pi.OrderNum
group by sc.EmpID
  , pi.ProdCategory
)

select *
  , rank() over (partition by ProdCategory order by DiscountSum desc) as DiscountedRank
from order_product_discounts
