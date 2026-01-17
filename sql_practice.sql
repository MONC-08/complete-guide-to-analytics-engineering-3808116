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