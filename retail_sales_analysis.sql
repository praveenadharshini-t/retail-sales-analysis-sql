RETAIL SALES ANALYSIS

-- 1.Creating Database
create database Retail_Sales_db
use Retail_Sales_db

-- 2.Getting info about dataset
describe retail_sales;

Data Cleaning
-- 3.Changing Datatypes
alter table retail_sales
modify Date DATE
alter table retail_sales
modify `Customer ID` varchar(30);
alter table retail_sales
modify `Price per unit` decimal(10,2)
alter table retail_sales
modify `Total Amount` decimal(10,2)

-- 4.Checking NULLs
select * from retail_sales
where `transaction id` is null
or
`customer id` is null
or
`product category` is null;

-- 5.Checking if total amount is correct
Select *,
       quantity * `price per unit` AS calculated_total
FROM retail_sales
WHERE `total amount` != quantity * `price per unit`;

-- 6.Total sales
select sum(`total amount`) as Total_Sales
from retail_sales;

-- 7.Total Quantity
select sum(Quantity) as `Total Quantity Sold`
from retail_sales;

-- 8.Number of transactions
select count(*) as `Total Transactions`
from retail_sales;

-- 9.Unique product category
select distinct(`product category`) as `Product_Category`
from retail_sales
select count(distinct(`product category`))
from retail_sales;

-- 10.Top selling categories
select sum(Quantity) as `Total Quantity Sold`, `product category`
from retail_sales
group by `Product category`;

select `Product category`, sum(quantity) as `Total Quantity Sold`
from retail_sales
group by `Product category`
order by `Total Quantity Sold` desc;

-- 11.Revenue by category
select `Product category`, sum(`total amount`) as `Total revenue by category`
from retail_sales
group by `Product category`
order by `Total revenue by category` desc;

-- 12.Gender-wise spending
select gender, sum(`Quantity`) as `Total Quantity` 
from retail_sales
group by gender;

select gender, sum(`Total Amount`) 
from retail_sales
group by gender;

select gender, sum(`Quantity`) as `Total Quantity Purchased`, 
sum(`total amount`) as `Total Spent`
from retail_sales
group by gender;


-- 13.Monthly Sales
select month(date) as month, 
       sum(`total amount`) as `Monthly Revenue`
from retail_sales
group by month
order by `month`
desc

-- 14.Top 5 Customers
select `customer id`, sum(`total amount`) as `Total Spent`, 
        sum(Quantity) as `total quantity`
from retail_sales
group by `customer id`
order by `total spent`
desc limit 5;

-- 15.Age Group Analysis
SELECT
CASE
    WHEN age < 25 THEN 'Under 25'
    WHEN age BETWEEN 25 AND 40 THEN '25-40'
    WHEN age BETWEEN 41 AND 60 THEN '41-60'
    ELSE '60+'
END AS age_group,
SUM(`total amount`) AS revenue
FROM retail_sales
GROUP BY age_group
ORDER BY revenue DESC;

-- 16.Total Revenue
select
    SUM(`total amount`) AS Total_revenue
FROM retail_sales; 


-- 17.Ranking customers by spending
SELECT 
    `customer id`,
    SUM(`Total Amount`) AS total_spent,
    RANK() OVER (ORDER BY SUM(`Total Amount`) DESC) AS rank_position
FROM retail_sales
GROUP BY `customer id`;

-- 18.Running Total
select
    `Date`,
    SUM(`Total Amount`) AS daily_sales,
    SUM(SUM(`Total Amount`)) OVER (ORDER BY `Date`) AS running_total
FROM retail_sales
GROUP BY `Date`;