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
