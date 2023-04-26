use classicmodels;
select * from customers where customerName="Land Of Toys Inc.";
explain select * from customers where customerName="Land Of Toys Inc.";
-- add  thêm index vào bảng custommer có tên là customername
alter table customers add index idx_customerName(customerName);
-- add thêm index cho 2 cột trong bảng customers
alter table customers add index idx_full_name (contactFirstName,contactLastName);

explain select *from customers where contactFirstName="Jean" or contactFirstName="King";

-- xóa chỉ mục trong bảng 
alter  table customers drop index idx_full_name;


-- thực hành 2

-- Tạo mới stored procedure
delimiter //
create procedure findAllCustomers()
begin 
select * from customers;
end 
// delimiter ;
 -- gọi procedure
call findAllCustomers();
 
-- Sửa stored procedure 
delimiter //
drop procedure if exists `findAllCustomers`//
create procedure findAllCustomers()
begin 
select * from customers where customerNumber=175;
end // delimiter ;

-- Tham số loại IN 
delimiter //
create procedure getCusById(IN cusNum int(11))
begin
select * from customers where customerNumber=cusNum;
end
// delimiter ;

call getCusById(175);

-- Tham số loại OUT
delimiter //
create procedure getCustomerCountByCity
(
In in_city varchar(50),
Out total int 
)
begin 
select count(customerNumber) into total
from customers where city= in_city;
end
// delimiter ;

drop procedure getCustomerCountByCity;
call getCustomerCountByCity("lyon",@total);
select @total;

select * from customers where city="lyon";

-- Tham số loại INOUT
delimiter //
create procedure setCounter
(
InOut counter int,
In inc int 
)
begin 
set counter = counter + inc;
end
// delimiter ;

set @counter=1;
call setCounter(@counter,1);
call setCounter(@counter,1);
call setCounter(@counter,5);
select @counter;

-- thực hành 4
create view customer_view 
as
select customerName, customerNumber , phone from customers;
 select * from customer_view;

-- cập nhật view
create or replace view customer_view 
as
select customerNumber, customerName , contactFirstName, contactLastName, phone
from customers where city = "Nantes" ;
-- xóa view
drop view customer_view;