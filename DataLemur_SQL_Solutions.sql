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
---------------------------------------------------------------------
SELECT  
      sum(case when device_type = 'laptop' then 1 else 0 
      end ) as laptop_views,
      sum(case when device_type in('tablet', 'phone') then 1 else 0 
      end) as mobile_views
from viewership;


-- Platfrom:- DataLemur
-- Company:-Facebook(Difficultty; Easy)
-- Question:- (Find the number of days between each user's first and last post in 2021 (for users who posted at least twice))
---------------------------------------------------------------------
SELECT user_id, datediff(max(post_date), min(post_date)) as days_between
from posts 
where year(post_date) = 2021
group by user_id
having count(post_id) >=2;


-- Platfrom:- DataLemur
-- Company:-Microsoft(Difficultty; Easy)
-- Question:- (Find top 2 power users who sent the highest number of messages in august 2022)
---------------------------------------------------------------------
SELECT sender_id, count(message_id) as count_messages
from messages 
where extract(year from sent_date) = 2022 and extract(month from sent_date) = 8
group by sender_id
order by count_messages desc
limit 2;
