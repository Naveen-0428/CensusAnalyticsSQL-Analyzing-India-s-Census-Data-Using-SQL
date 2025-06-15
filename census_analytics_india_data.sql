-- calling data
select*from project1.dbo.Data1; 
select*from project1..sheet1 ;

-- number of rows in dataset 
select count(*) from project1.dbo.Data1    
select count(*) from project1.dbo.sheet1;

--data for only two state haryana and punjab
 select*from project1..data1 
 where State IN ('Haryana','punjab');

--total population of india 
 select sum(population) as total_population from project1..sheet1

 --average growth of india
  select avg(growth) as average_growth from project1..data1

--average growth percentage by state
select avg(growth)*100 as average_growth, State from project1..data1
group by State ;

--sexratio vs state 
select sex_ratio as sex_ratio,State as state from project1..data1
order by state desc;

-- sex_ratio vs district
select avg(sex_ratio)as avg_sexratio,district as district from project1..data1
group by district 

--maximum literacy rate of top 5 state 
 select TOP 5 MAX(literacy) AS maximum_literacy_rate, State from project1..data1
group by State
order by State desc;

--top 3 state with maximum literacy and maximum sex ratio
select top 3 State , round(max(Literacy),0) as max_literacy_rate,max(Sex_Ratio) as max_sex_ratio from project1..data1
GROUP BY State
order by State desc

--last 5 state with minimum literacy rate
select top 5 State , round(max(Literacy),0) from project1..data1
GROUP BY State
order by round(max(Literacy),0) asc

--temporary table showing top 8 state according to population 
DROP TABLE if exists #topstates;
CREATE table #topstates
(State nvarchar(255) ,
topstate float)

insert into #topstates
select top 8 State , max(population) from project1..sheet1
group by state 
order by max(population) desc;
SELECT * FROM #topstates;

--state starting with letter A and H
SELECT state 
FROM project1..Data1
WHERE LEFT(state, 1) IN ('A', 'H');


--state starting with letter A and ending with h
SELECT state 
FROM project1..Data1
WHERE LEFT(state, 1) = 'A'
  AND RIGHT(state, 1) = 'H';

--joining of two table 
select d.Sex_Ratio,s.population,s.state ,s.district
from project1..Data1 as d
inner join project1..Sheet1 as s 
on d.district=s.district


--total number of males , females
--female/males = sex_ratio and female+males=population using these 2 equartion : males= population/(sex_ratio+1) 
SELECT 
    ROUND(s.population / (1 + d.sex_ratio), 0) AS males,
    ROUND(s.population - (s.population / (1 + d.sex_ratio)), 0) AS females,
    s.district,
    s.state
FROM project1..Data1 AS d
INNER JOIN project1..Sheet1 AS s 
    ON d.district = s.district;

-- according to state: total number of males and female 
SELECT 
    SUM(ROUND(s.population / (1 + d.sex_ratio), 0)) AS males,
    SUM(ROUND(s.population - (s.population / (1 + d.sex_ratio)), 0)) AS females,
    s.state
FROM project1..Data1 AS d
INNER JOIN project1..Sheet1 AS s 
    ON d.district = s.district
GROUP BY s.state;

-- total literate people/population = literacy_ratio, total illiterate people =(1-literacy_ratio)*population based on state wise 
select d.State,sum(s.population) AS total_population, sum(round((1-literacy/100)*population,0)) as  total_illiterate_people, sum(round((Literacy/100)*population,0))as total_literate_people
FROM project1..Data1 AS d
INNER JOIN project1..Sheet1 AS s 
ON d.district = s.district
Group by d.state

--population in previous census , Let, x is previous census so population = x + x*growth , prev.census = population/(1+growth)
select  d.state, sum(d.Growth) as total_Growth,sum(s.population ) as toal_population, sum(Round(s.population/(1+Growth),0)) as previous_cens
from project1..Data1 as d
INNER JOIN project1..Sheet1 AS s 
    ON d.district = s.district
	group by d.state

-- area/km2  to population : State wise 
select  sum(s.Area_Km2) as total_area, d.state,sum(s.population) as total_population
from project1..Data1 as d
INNER JOIN project1..Sheet1 AS s 
    ON d.district = s.district
	group by d.state

-- population density this census and previous census
select sum(Round(s.population/(1+d.Growth),0)) as previous_cens,round(sum(Round(s.population/(1+d.Growth),0))/ sum(s.Area_Km2),0) as prev_area_per_km2_to_population
, sum(s.population) as current_census,round(sum(s.population)/sum(s.Area_km2),0) as curre_area_per_km2_to_population
from project1..Data1 as d
INNER JOIN project1..Sheet1 AS s 
    ON d.district = s.district

--window function
--top 3 district from each state having highest literacy rate 
with ranked_literacy as (select District , State , Literacy ,rank() over (partition by State order  by Literacy desc) as raannk from project1..Data1
where Literacy is not NULL )
select* from ranked_literacy 
where raannk <=3
order by state




