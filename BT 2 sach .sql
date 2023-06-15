USE TSQL2012
SELECT orderid,orderdate,custid,empid
FROM Sales.Orders
WHERE YEAR(orderdate)=2007 and MONTH(orderdate)=06

--- cau 2
SELECT orderid,custid,empid, EOMONTH(orderdate)
FROM Sales.Orders
where  DATEADD(day, DATEDIFF(day, 0, orderdate), 0) = 
      DATEADD(day, -1, DATEADD(month, DATEDIFF(month, 0, orderdate) + 1, 0)) 
order by 4

--cau 3
--Write a query against the HR.Employees table that returns employees with last name containing the
--letter a twice or more.
select lastname
from HR.Employees
where lastname like '%a%a%'

--cau 4 : return orders with total value > 10.000
select orderid, sum(qty*unitprice) as totalvalue
from Sales.OrderDetails
group by orderid
having sum(qty*unitprice) > 10000
order by totalvalue desc

--cau 5
select shipcountry , AVG(freight) as avgfreight
from Sales.Orders
where orderdate>= '20070101' and  orderdate < '20080101'
group by shipcountry --- vi sao phai co group by moi chay dc
order by AVG(freight) desc

--cau 6: Write a query against the Sales.Orders table that calculates row numbers for orders based on order
---date ordering (using the order ID as the tiebreaker) for each customer separately.
select custid , orderdate , sum(orderid)
from sales.Orders
group by custid

SELECT custid, orderdate, orderid,
ROW_NUMBER() OVER(PARTITION BY custid ORDER BY orderdate, orderid) AS rownum
FROM Sales.Orders
ORDER BY custid, rownum;

----cau 7: Using the HR.Employees table, figure out the SELECT statement that returns for each employee the
----gender based on the title of courtesy. For ‘Ms. ‘ and ‘Mrs.’ return ‘Female’; for ‘Mr. ‘ return ‘Male’; and
----in all other cases (for example, ‘Dr. ‘) return ‘Unknown’.
select empid, firstname, lastname , titleofcourtesy,
	CASE titleofcourtesy
		WHEN 'Ms.'			 THEN 'Female'
		WHEN 'Mrs.'			 THEN 'Female'
		WHEN 'Mr.'			THEN 'Male'
		else				 'Unknow'
		end AS gender
from HR.Employees

SELECT empid, firstname, lastname, titleofcourtesy,
CASE titleofcourtesy
WHEN titleofcourtesy IN('Mrs.','Ms.') THEN 'Female'
WHEN titleofcourtesy='Mr.' THEN 'Male'
ELSE 'Unknown'
END AS gender
FROM HR.Employees;


--cau 8: Write a query against the Sales.Customers table that returns for each customer the customer ID and
--region. Sort the rows in the output by region, having NULL marks sort last (after non-NULL values).
---Note that the default sort behavior for NULL marks in T-SQL is to sort first (before non-NULL values).

SELECT custid, region
FROM Sales.Customers
ORDER BY
CASE WHEN region IS NULL THEN 1 ELSE 0 END, region;