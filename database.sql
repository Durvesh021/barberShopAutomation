drop database if exists bshop;
create database bshop;

use bshop;
create table Inventory ( itemId int NOT NULL auto_increment, itemName VARCHAR(30), qtyAvail int, PRIMARY KEY (itemId) );
CREATE TABLE Services ( serviceId int NOT NULL auto_increment, serviceName varchar(50), forGender varchar(15), price int, primary key(serviceId));
create table Materials (serviceId int NOT NULL, itemId int, foreign key (serviceId) references Services(serviceId), foreign key (itemId) references Inventory(itemId));
create table Customers (mobNumber varchar(20), primary key(mobNumber));
create table Orders ( orderId int NOT NULL auto_increment, timedate datetime, mobNumber varchar(20), product varchar(50), paymentStatus boolean, amount int, primary key(orderId), foreign key(mobNumber) references Customers(mobNumber));
create table Appointments (appointmentId int NOT NULL auto_increment, isPaid boolean, mobNumber varchar(20), gender varchar(15), custName varchar(30), feedback varchar(500), startTime time, endTime time, amount int, primary key(appointmentId), foreign key (mobNumber) references Customers(mobNumber));
create table AppointmentServices (appointmentId int, serviceId int, foreign key(appointmentId) references Appointments(appointmentId), foreign key(serviceId) references Services(serviceId));
create table blocklist (mobNumber varchar(20), reason varchar(100));

alter table Orders add column orderStatus varchar(20);
INSERT INTO `bshop`.`services`
(`serviceName`,
`forGender`,
`price`)
VALUES
('HairCut','M',50),
('HairCut','F',100),
('Eyebrows','F',30),
('HairStyle','M',100),
('HairStyle','F',200),
('Beard','M',30)
;

select * from services;

create trigger inventoryadd
after insert
on appointmentservices
for each row
update Inventory,materials,appointmentservices
set inventory.qtyAvail=inventory.qtyAvail -1
where appointmentservices.appointmentId = new.appointmentId
and materials.serviceId = appointmentservices.serviceId
and inventory.itemId = materials.itemId;


create trigger inventorydel
after delete
on appointmentservices
for each row
update Inventory,materials,appointmentservices
set inventory.qtyAvail=inventory.qtyAvail +1
where materials.serviceId = old.serviceId
and inventory.itemId = materials.itemId;


Alter table inventory
add column itemStatus varchar(20) default 'Active';

describe materials;

INSERT INTO `bshop`.`inventory`
(`itemName`,
`qtyAvail`)
VALUES
('blade',10),
('cream',10);

INSERT INTO `bshop`.`materials`
(`serviceId`,
`itemId`)
VALUES
(3,1);