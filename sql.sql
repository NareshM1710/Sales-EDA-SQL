use new_schema ;
ALTER TABLE Sales MODIFY COLUMN OrderDate text ;
ALTER TABLE Sales MODIFY COLUMN TotalAmount Float;

-- 1 :
Select * from Sales;
Select Customername,orderdate from sales ;	
select distinct ProductName from sales ;
select * from sales where Region = "North" ;
select * from sales order by orderdate desc ;

-- 2 :

select region, round(sum(TotalAmount)) as Totalsales   from sales  group by Region;
select ProductName,  avg(price) as AvergeProduct from sales group by ProductName;
select CustomerName,  Count(Orderid) as Count from sales group by CustomerName ;
Select ProductName , max(totalamount) as Max , min(totalamount) as Min from sales group by	ProductName ;
Select sum(Quantity) as TotalQuantity from sales ;

-- 3 :
Create table Customer 
(
ProductID int,
CustomerID int ,
ProductName varchar(255),
Region varchar (255) ) ;

select * from Customer c inner join Sales s  on c.CustomerID = s.CustomerID;
-- Select ProductID from Sales s inner join Products p on s.productId= p.product id :
--  Select * from Sales s left join region r on s.Region = s.Region:
-- Select * from sales s join customer c on s.customerid=c.customerid join product p on s.product = p.product :
-- Select Customername , orderid from order o left join customer on o.customerid = c.customerid where c.customerid is null :
-- 4 :
with salesp (Avgvalue) as (
select avg(Totalamount)
from sales )
select CustomerID , Totalamount  from sales s , salesp
where s.Totalamount > salesp.Avgvalue ;

with product (avgproduct) as ( 
select avg(price) from sales )
select productname , price , avgproduct from sales , product  where sales.price > product.avgproduct ;

with high  as (
select totalamount , row_number() over ( order by totalamount desc) as rownum
from sales )
select totalamount from high where rownum = 2;

SELECT CustomerID , COUNT(*) 
FROM sales
GROUP BY CustomerID
ORDER BY COUNT(*) DESC ;

select region , sum(TotalAmount) as totalsales
from sales 
group by region 
order by region  desc;
 
select  OrderDate ,TotalAmount ,sum(TotalAmount) over (order by OrderDate) as cumulative_total_sales
from sales
order by OrderDate;



select CustomerID , dense_rank() over (order by sum(TotalAmount) desc) as rowid
from sales 
group by CustomerID ;

with ts as (
select sum(TotalAmount) as total
from sales
) , 
average as ( select (price/ sum(TotalAmount)) * 100 as Average1 from sales)
select t.total , a.Average1
from ts t , average a 
;

select productname,
sum(case when region='North' then totalamount else 0 end) as North,
sum(case when region='East' then totalamount else 0 end) as East,
sum(case when region='South' then totalamount else 0 end) as South,
sum(case when region='West' then totalamount else 0 end) as West
from sales 
group by productname;

update sales set price = price*1.10 ;




