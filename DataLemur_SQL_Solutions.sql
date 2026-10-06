-- Platfrom:- DataLemur
-- Company:- LinkedIn (Difficultty; Easy)
-- Question:- Data Science skills (find candidates proficient in Python, Tableau, and postgreSQL
------------------------------------------------------------------------------------------------

SELECT candidate_id
from candidates
where skill in ('python', 'tableau', 'postgresql')
group by candidate_id
having count(skill) = 3
order by candidate_id asc;
