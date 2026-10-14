-- Platfrom:- DataLemur
-- Company:- LinkedIn (Difficultty; Easy)
-- Question:- Data Science skills (find candidates proficient in Python, Tableau, and postgreSQL)
-------------------------------------------------------------------------------------------------

SELECT candidate_id
from candidates
where skill in ('python', 'tableau', 'postgresql')
group by candidate_id
having count(skill) = 3
order by candidate_id asc;



-- Platfrom:- DataLemur
-- Company:- Twitter (Difficultty; Easy)
-- Question:- Histogram of tweets(tweets posted per user in 2022)
-----------------------------------------------------------------

with tweet_counts as (
select user_id, count(tweet_id) as tweet_bucket
from tweets
where tweet_date >= '2022-01-01' and tweet_date <= '2022-12-31'
group by user_id
)
select tweet_bucket as bucket, count(user_id) as user_num
from tweet_counts
group by tweet_bucket;


SELECT account_id, sum(case when transaction_type = 'Deposit' then amount else - amount end) as final_balance
from transactions
group by account_id;


-- Platfrom:- DataLemur
-- Company:-Facebook (Difficultty; Easy)
-- Question:- Find facebook pages with zero(0) likes (unliked pages)
--------------------------------------------------------------------

select p.page_id
from pages p 
left join page_likes pl 
on p.page_id = pl.page_id
where pl.page_id is null 
order by p.page_id asc; 


-- Platfrom:- DataLemur
-- Company:-Tesla(Difficultty; Easy)
-- Question:-find unfinished parts in production(bottleneck analysis)
---------------------------------------------------------------------

select part, assembly_step 
from parts_assembly
where finish_date is null;


-- Platfrom:- DataLemur
-- Company:-New York times(Difficultty; Easy)
-- Question:- (calculate totalviewership for laptops and vs mobile devices(tablet + phone) in 1 row)
----------------------------------------------------------------------------------------------------
SELECT  
      sum(case when device_type = 'laptop' then 1 else 0 
      end ) as laptop_views,
      sum(case when device_type in('tablet', 'phone') then 1 else 0 
      end) as mobile_views
from viewership;


-- Platfrom:- DataLemur
-- Company:-Facebook(Difficultty; Easy)
-- Question:- (Find the number of days between each user's first and last post in 2021 (for users who posted at least twice))
-----------------------------------------------------------------------------------------------------------------------------
SELECT user_id, datediff(max(post_date), min(post_date)) as days_between
from posts 
where year(post_date) = 2021
group by user_id
having count(post_id) >=2;


-- Platfrom:- DataLemur
-- Company:-Microsoft(Difficultty; Easy)
-- Question:- (Find top 2 power users who sent the highest number of messages in august 2022)
---------------------------------------------------------------------------------------------
SELECT sender_id, count(message_id) as count_messages
from messages 
where extract(year from sent_date) = 2022 and extract(month from sent_date) = 8
group by sender_id
order by count_messages desc
limit 2;


-- Platfrom:- DataLemur
-- Company:-Amazon(Difficultty; Easy)
-- Question:- (Calculate the average star rating for each product grouped by month.)
------------------------------------------------------------------------------------
SELECT extract(month from submit_date) as mth, product_id, round(avg(stars), 2) as avg_stars
FROM reviews 
group by extract(month from submit_date), product_id
order by mth, product_id;


-- Platfrom:- DataLemur
-- Company:-Faang(Difficultty; Easy)
-- Question:- (Find employees who earn more than their direct managers.)
------------------------------------------------------------------------
SELECT e.employee_id, e.name 
from employee e 
join employee m 
on e.manager_id = m.employee_id
where e.salary > m.salary;


-- Platfrom:- DataLemur
-- Company:- PayPal (Difficultty; Easy)
-- Question:- (calculate the final account balance for each account)
--------------------------------------------------------------------
SELECT account_id, sum(case when transaction_type = 'Deposit' then amount else - amount end) as final_balance
from transactions
group by account_id;


-- Platfrom:- DataLemur
-- Company:- Robinhood(Difficultty; Easy)
-- Question:- (Find top 3 cities with the highest number of completed trade orders)
-----------------------------------------------------------------------------------
select u.city, count(t.order_id) as total_orders 
from trades t 
join users u 
on t.user_id = u.user_id 
where t.status = 'Completed'
group by u.city 
order by total_orders desc 
limit 3;


-- Platfrom:- DataLemur
-- Company:- Robinhood(Difficultty; Easy)
-- Question:- (Calculate the click-through rate (CTR) for each each app in 2022)
--------------------------------------------------------------------------------
SELECT app_id, round(100.0*count(case when event_type = 'click' then 1 end)/
count(case when event_type = 'impression' then 1 end),2) as CTR 
FROM events
where extract(year from timestamp) = 2022
group by app_id;


-- Platfrom:- DataLemur
-- Company:- Tiktok(Difficultty; Easy)
-- Question:- (Find users who confirmed their sign-up on the exact second day)
------------------------------------------------------------------------------
SELECT e.user_id 
from emails e 
join texts t 
on e.email_id = t.email_id
where t.signup_action = 'confirmed' and datediff(t.action_date, e.signup_date) = 1; 



-- Platfrom:- DataLemur
-- Company:- IBM(Difficultty; Easy)
-- Question:- (Generate a histogram showing the count of unique queries run by employees in Q3 2023)
----------------------------------------------------------------------------------------------------
SELECT unique_queries, count(employee_id) as employee_count
from ( select e.employee_id, count(q.query_id) as unique_queries
from employees e 
left join queries q on e.employee_id = q.employee_id and q.query_starttime >='2023-07-01'
and q.query_starttime < '2023-10-01'
group by e.employee_id ) as employee_queries
group by unique_queries
order by unique_queries;


-- Platfrom:- DataLemur
-- Company:- JPMorgan chase (Difficultty; Easy)
-- Question:- (Calculate the difference between the highest and lowest monthly issuance for each credit card)
-------------------------------------------------------------------------------------------------------------
SELECT card_name, (max(issued_amount) - min(issued_amount)) as difference
from monthly_cards_issued
group by card_name
order by difference desc;


-- Platfrom:- DataLemur
-- Company:- Alibaba(Difficultty; Easy)
-- Question:- (Find the mean number of items per order, rounded to 1 decimal place.)
------------------------------------------------------------------------------------
SELECT round(
(1.0 * sum(item_count::decimal * order_occurrences)) / 
sum(order_occurrences),1) as mean
from items_per_order;


-- Platfrom:- DataLemur
-- Company:- CVS Health(Difficultty; Easy)
-- Question:- (Find the mean number of items per order, rounded to 1 decimal place.)
------------------------------------------------------------------------------------
SELECT drug, (total_sales - cogs) as total_profit
from pharmacy_sales
order by total_profit DESC
limit 3;


-- Platfrom:- DataLemur
-- Company:- CVS Health(Difficultty; Easy)
-- Question:- (Identify manufacturers with net losses, counting their unprofitable drugs and total loss amount)
------------------------------------------------------------------------------------
SELECT manufacturer, count(drug) as drug_count,
      sum(cogs - total_sales) as total_loss 
from pharmacy_sales
where cogs > total_sales 
group by manufacturer 
order by total_loss desc;


-- Platfrom:- DataLemur
-- Company:- United Health group (Difficultty; Easy)
-- Question:- (Find how many policcy holders made 3 or more calls)
------------------------------------------------------------------
select count(policy_holder_id) as member_count
from (
      select policy_holder_id
      from callers
      group by policy_holder_id
      having count(case_id) >= 3
      ) as frequent_callers;



-- Platfrom:- DataLemur
-- Company:- Uber (Difficultty; Easy)
-- Question:- (Retrieve the exact 3rd transaction for every user)
-----------------------------------------------------------------
SELECT user_id, spend, transaction_date
from (
      select user_id, spend, transaction_date, 
              row_number() over (partition by user_id order by transaction_date) as rn 
      from transactions) as ranked_transactions
where rn = 3;


-- Platfrom:- DataLemur
-- Company:- FAANG (Difficultty; Easy)
-- Question:- (Find the second highest unique salary from the employee table)
-----------------------------------------------------------------------------
SELECT distinct salary 
from employee
order by salary desc 
limit 1 offset 1;


-- Platfrom:- DataLemur
-- Company:- Snapchat (Difficultty; Easy)
-- Question:- (Calculate the percentage of time spent sending vs. opening snaps for each age bucket.)
-----------------------------------------------------------------------------------------------------
SELECT age.age_bucket, 
        round(100.0 * sum(case when act.activity_type = 'send' then act.time_spent else 0 end)/
        sum(act.time_spent), 2) as send_perc,
        round(100.0 * sum(case when act.activity_type = 'open' then act.time_spent else 0 end)/
        sum(act.time_spent), 2) as open_perc
from activities act 
join age_breakdown age on act.user_id = age.user_id
where act.activity_type in ('send', 'open')
group by age.age_bucket;


      
