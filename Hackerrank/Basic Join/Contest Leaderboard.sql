
/* The total score of a hacker is the sum of their maximum scores for all of the challenges. 
-- Write a query to print the hacker_id, name, and total score of the hackers 
-- ordered by the descending score. If more than one hacker achieved the same total score, 
-- then sort the result by ascending hacker_id. Exclude all hackers with a total score of  
-- from your result. */

/*The following tables contain contest data:

Hackers: The hacker_id is the id of the hacker, and name is the name of the hacker.*/

create table Hackers(
hacker_id int Primary key,
name varchar(100)
);

/*Submissions: The submission_id is the id of the submission, 
hacker_id is the id of the hacker who made the submission, 
challenge_id is the id of the challenge for which the submission belongs to, 
and score is the score of the submission.*/

create table Submissions (
submission_id int primary Key ,
hacker_id int foreign key references Hackers(hacker_id),
challenge_id int ,
score int
);

insert into Hackers 
values
(4071, 'Rose'),
(4806, 'Angela'),
(26071, 'Frank');

insert into Hackers 
values
(84072, 'Bonnie');

insert into Submissions 
values
(6943, 4071, 19797, 95),
(9951, 4071, 49593, 43),
(10063, 4071, 49593, 96),
(17513, 4806, 49593, 32),
(84264, 84072, 63132,0);


/*Sample Output

4071 Rose 191
74842 Lisa 174
84072 Bonnie 100
4806 Angela 89
26071 Frank 85
80305 Kimberly 67
49438 Patrick 43*/

select h.hacker_id, h.name, sum (masxsocres) as sumscore
from (select ss.hacker_id, max(ss.score) as masxsocres
from submissions ss
where ss.score != 0 
group by ss.hacker_id, ss.challenge_id) as t , hackers h
where h.hacker_id = t.hacker_id
group by h.hacker_id, h.name
order by sumscore DESC, h.hacker_id;



