USE pizzadb;
 
select count(*) from orders_details;

select pizza_id, sum(quantity) from order_info
group by pizza_id;

Select SUM(total_price) from (
select oi.pizza_id, sum(oi.quantity) * p.price as total_price
 from order_info as oi
left join 
pizzas as p
on
oi.pizza_id=p.pizza_id
Group by oi.pizza_id) xyz;

select *
from order_info as oi
left join 
pizzas as p
on
oi.pizza_id=p.pizza_id;

select sum(oi.quantity * p.price) as Revenue
from order_info as oi
left join 
pizzas as p
on
oi.pizza_id=p.pizza_id;

select oi.pizza_id, p.price
from order_info as oi
left join 
pizzas as p
on
oi.pizza_id=p.pizza_id
ORDER BY p.price DESC
LIMIT 1;

select Size, count(*)
from order_info as oi
left join 
pizzas as p
on
oi.pizza_id=p.pizza_id
Group By Size
Order By Count(*) DESC
LIMIT 1;

select pt.pizza_type_id, sum(oi.quantity) as quan
from pizza_types as pt
inner join 
pizzas as p
on
pt.pizza_type_id=p.pizza_type_id
Inner join
order_info as oi
on
p.pizza_id=oi.pizza_id
GROUP BY pt.pizza_type_id
Order By quan DESC
LIMIT 5;
use pizzadb;

select pt.category, sum(oi.quantity)
from pizza_types as pt
inner join 
pizzas as p
on
pt.pizza_type_id=p.pizza_type_id
Inner join
order_info as oi
on
p.pizza_id=oi.pizza_id
GROUP BY pt.category;

SELECT count(order_id), hour(order_time)
FROM orders_details
GROUP BY 2
ORDER BY 2;

select pt.category, pt.name, sum(oi.quantity)
from pizza_types as pt
inner join 
pizzas as p
on
pt.pizza_type_id=p.pizza_type_id
Inner join
order_info as oi
on
p.pizza_id=oi.pizza_id
GROUP BY 1,2
ORDER BY 1;

SELECT AVG(SUM)
FROM
(select DATE(order_date), SUM(oi.Quantity) as SUM
from orders_details as od
inner join 
order_info as oi
on
od.order_id=oi.order_id
GROUP BY 1
) AS XYZ;

select p.pizza_type_id as pizt, SUM(oi.quantity*p.price) as total_rev
from order_info as oi
inner join 
pizzas as p
on
p.pizza_id=oi.pizza_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3;

select p.pizza_type_id as pizt, ROUND(100*SUM(oi.quantity*p.price)/(SELECT SUM(oi.quantity*p.price)
from order_info as oi
inner join 
pizzas as p
on
p.pizza_id=oi.pizza_id),2) as total_rev
from order_info as oi
inner join 
pizzas as p
on
p.pizza_id=oi.pizza_id
GROUP BY 1
ORDER BY 2 DESC;

SELECT *
FROM
(Select pt.category as Cat ,pt.pizza_type_id as Typ,sum(oi.quantity*p.price) as Rev, 
RANK() OVER(partition by pt.category ORDER BY sum(oi.quantity*p.price) DESC) as Rnk 
from pizza_types as pt
inner join 
pizzas as p
on
pt.pizza_type_id=p.pizza_type_id
Inner join
order_info as oi
on
p.pizza_id=oi.pizza_id
GROUP BY 1,2) AS XYZ
WHERe RNK<4
ORDER BY cat;

SELECT DISTINCT MONTH(order_date)
FROM orders_details;
SELECT COUNT(*)
FROM orders_details;

select month(od.order_date) AS MNTH, ROUND(SUM(sum(oi.quantity*p.price)) OVER(ORDER BY month(od.order_date)),2) AS CUM_REV
from order_info as oi
inner join 
pizzas as p
on
oi.pizza_id=p.pizza_id
Inner join
orders_details as od
on
oi.order_id=od.order_id
GROUP BY 1;













 