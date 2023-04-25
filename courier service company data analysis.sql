


select ta.courier_id,ta.time as acceptordertime, td.time as delivertime
into atable
from (
select courier_id, time,
       ROW_NUMBER() Over(Partition by courier_id order by time) EventID
from courier_actions where action='accept_order'
) as ta
LEFT JOIN (
select courier_id, time, 
       ROW_NUMBER() Over(Partition by courier_id order by time) EventID
from courier_actions where action='deliver_order'
) as  td
on (ta.courier_id = td.courier_id and ta.EventID = td.EventID)

select*
from atable

select courier_id, count(courier_id) as totalnumberofdelivery
from atable
group by courier_id
order by COUNT(courier_id) desc, courier_id asc
--courier_id:252 & 291 has the best performance 

select *
from couriers

select *
from couriers
where courier_id =252 or courier_id= 291
--both are male who have the best performance and thus hire more male courier.

   

select action,COUNT(action) as number ,COUNT(action)*100/(select count(action)  from user_actions) as Percentage
from user_actions
group by action
--there are 4% of cancel order and management should look into it.

select user_id, COUNT(user_id) as number_of_cancel_order
from user_actions
where action ='cancel_order'
group by user_id
order by count(user_id) desc
-- the highest number of cancel order of each user is 3. Management should look into it.

select order_id,product_ids,len(product_ids)
from orders
order by len(product_ids) desc
-- the order that has the highest number of product is 49755 and 51414



select ca.order_id,ua.user_id,ca.courier_id,ua.time as ordertime,ca.time as deliverordertime
from (select order_id, time, courier_id from courier_actions where action = 'deliver_order') as ca
join user_actions as ua
on ca.order_id=ua.order_id
where ca.order_id=49755 or ca.order_id=51414
--the user_id 18622= order_id 49755 ; user_id =17170 = order_id=51414

select product_id,name,price
from products
order by cast(price as int) desc;
--the highest price of the item is 800

exec sp_help orders

update orders set product_ids=REPLACE(product_ids,'[','')

update orders set product_ids=REPLACE(product_ids,']','')

select*
from orders

select order_id,product_ids
from orders
order by len(product_ids) desc
--highest number of item per order id is 9

select order_id,creation_time,value --do not change 'value' name. leave it as it is
into ctable
from orders
cross apply string_split(product_ids,','); 


select*
from ctable
where order_id = 25617

update ctable
set value=TRIM(value)

select*
from products
where product_id=47

select c.order_id,sum(cast(p.price as int) )from ctable as c
full join products as p
on c.value=p.product_id
group by c.order_id
order by sum(cast(p.price as int) ) Desc
--order id 59374 has the highest value.










