#Q1  Provide the list of markets in which customer "Atliq Exclusive" operates its business in the APAC region.
select market from dim_customer where customer= "Atliq Exclusive" and region= "APAC" group by market; 

#Q2 What is the percentage of unique product increase in 2021 vs. 2020? The final output contains these fields, unique_products_2020,  unique_products_2021, percentage_chg   
with cte as(SELECT count(distinct if(fiscal_year = 2020,product_code,null))as unique_products_2020,
                   count(distinct if(fiscal_year = 2021,product_code,null))as unique_products_2021
			from fact_sales_monthly)
select *,round(((unique_products_2021-unique_products_2020)/unique_products_2020)*100,2)as percentage_change from cte;

#Q3 Provide a report with all the unique product counts for each segment and sort them in descending order of product counts.
-- The final output contains 2 fields, segment product_count.
select segment, count(distinct product_code) as product_count from dim_product group by segment order by product_count desc;

# Q4  Follow-up: Which segment had the most increase in unique products in 2021 vs 2020? The final output contains these fields, 
#                                                                        segment, product_count_2020, product_count_2021, difference 
WITH CTE1 AS (SELECT segment,COUNT( DISTINCT product_code) AS product_count_2020
			  FROM FACT_SALES_MONTHLY
			  LEFT JOIN DIM_PRODUCT USING(product_code)
			  WHERE FISCAL_YEAR = 2020
			  GROUP BY segment),
	 CTE2 AS (SELECT segment,COUNT( DISTINCT product_code) AS product_count_2021
			  FROM FACT_SALES_MONTHLY
			  LEFT JOIN DIM_PRODUCT USING(product_code)
			  WHERE FISCAL_YEAR = 2021
			  GROUP BY segment)
SELECT *, (product_count_2021-product_count_2020) AS difference
FROM CTE1
INNER JOIN CTE2 USING(segment)
ORDER BY difference DESC;


#Q5 . Get the products that have the highest and lowest manufacturing costs. The final output should contain these fields,
-- product_code,    product,     manufacturing_cost
select product, f.product_code,  f.manufacturing_cost from fact_manufacturing_cost f join dim_product p 
on p.product_code = f.product_code  where manufacturing_cost in 
(select max(manufacturing_cost) from fact_manufacturing_cost
union
select min(manufacturing_cost) from fact_manufacturing_cost)  order by manufacturing_cost desc ; 


# Q6. Generate a report which contains the top 5 customers who received an average high pre_invoice_discount_pct for the fiscal year 2021 and in the Indian market. 
# The final output contains these fields, customer_code, customer, average_discount_percentage
with TBL1 as (SELECT customer_code AS A, AVG(pre_invoice_discount_pct) AS B FROM fact_pre_invoice_deductions
WHERE fiscal_year = '2021'
GROUP BY customer_code),
TBL2 AS
(SELECT customer_code AS C, customer AS D FROM dim_customer
WHERE market = 'India')

SELECT TBL2.C AS customer_code, TBL2.D AS customer, ROUND (TBL1.B, 4) AS average_discount_percentage
FROM TBL1 JOIN TBL2
ON TBL1.A = TBL2.C
ORDER BY average_discount_percentage DESC
LIMIT 5 ; 



#7. Get the complete report of the Gross sales amount for the customer “Atliq Exclusive” for each month. This analysis helps to get an idea of low and 
# high-performing months and take strategic decisions.The final report contains these columns:Month, Year, Gross sales Amount 
with cte as (select concat(monthname(fs.date)," " ,year(fs.date))as "month", 
	round(sum(fs.sold_quantity * fg.gross_price),2)as gross_sales_amount
	from fact_sales_monthly fs join dim_customer c on fs.customer_code = c.customer_code 
	join fact_gross_price fg on fs.product_code= fg.product_code
    where c.customer= "Atliq Exclusive" 
	group by month order by gross_sales_amount desc)
select month,CONCAT(round((gross_sales_amount/1000000),2),' M') AS Gross_sales_mln from cte ;




# 8. In which quarter of company year(sept to Aug) 2020, got the maximum total_sold_quantity? The finaloutput contains these fields sorted by the
# total_sold_quantity, Quarter, total_sold_quantity
select   
	case  
		when date between '2019-09-01' and '2019-11-01' then 1
        when date between '2019-12-01' and '2020-02-01' then 2
		when date between '2020-03-01' and '2020-05-01' then 3
		when date between '2020-06-01' and '2020-08-01' then 4
	end as Quarters,
    sum(sold_quantity)as total_sold_quantity 
	from fact_sales_monthly WHERE fiscal_year = 2020
    GROUP BY Quarters order by total_sold_quantity desc; 


#9. Which channel helped to bring more gross sales in the fiscal year 2021 and the percentage of contribution? The final output contains these fields,
# channel,gross_sales_mln, percentage   

with cte as(SELECT C.channel,
       ROUND(SUM(G.gross_price*FS.sold_quantity/1000000), 2) AS Gross_sales_mln
FROM fact_sales_monthly FS JOIN dim_customer C ON FS.customer_code = C.customer_code
						   JOIN fact_gross_price G ON FS.product_code = G.product_code
WHERE FS.fiscal_year = 2021
GROUP BY channel) 
select channel, concat(Gross_sales_mln, " M")as Sales_Millions ,  CONCAT(ROUND(Gross_sales_mln*100/total , 2), ' %')as percentage from  
(
(SELECT SUM(Gross_sales_mln) AS total FROM cte) A,
(SELECT * FROM cte) B
)
ORDER BY percentage DESC ;







# Q10. Get the Top 3 products in each division that have a high total_sold_quantity in the fiscal_year 2021? 
# The final output contains these fields, division, product_code, product, total_sold_quantity, rank_order
WITH Output1 AS 
(
SELECT P.division, FS.product_code, P.product, SUM(FS.sold_quantity) AS Total_sold_quantity
FROM dim_product P JOIN fact_sales_monthly FS
ON P.product_code = FS.product_code
WHERE FS.fiscal_year = 2021 
GROUP BY  FS.product_code, division, P.product
),
Output2 AS 
(
SELECT division, product_code, product, Total_sold_quantity,
        RANK() OVER(PARTITION BY division ORDER BY Total_sold_quantity DESC) AS 'Rank_Order' 
FROM Output1
)
 SELECT Output1.division, Output1.product_code, Output1.product, Output2.Total_sold_quantity, Output2.Rank_Order
 FROM Output1 JOIN Output2
 ON Output1.product_code = Output2.product_code
WHERE Output2.Rank_Order IN (1,2,3) ;