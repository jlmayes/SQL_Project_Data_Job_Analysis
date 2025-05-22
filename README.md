# Introduction
In this SQL project, I explored the data within the job market on data analyst roles with a focus on remote jobs within the United States. Specifically looking into top-paying jobs, in-demand skills, and where high demand met high salary in this field. 

Check out my SQL queries here: [project_sql folder](/project_sql/)

# Background

Driven by my desire to gain marketable skills to become a data analyst, I followed along with Luke Barousse through his SQL course https://www.lukebarousse.com/products/sql-for-data-analytics. The aim of this project is to understand the data analyst job market better by identifying top-paying jobs, in demand skills, and how they intersect with each other. The data provided includes details on job title, salaries, locations, and required skills. 

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn for a data analyst looking to maximize job market value?

# Tools I Used

In this project, I utilized a variety of tools to conduct my analysis:

- **SQL**: Allowed me to extract insights and answer my key questions through queries.
- **PostgreSQL**: Database management system that allowed me to store, query, and manipulate the large volume of job posting data.
- **Visual Studio Code:** This platform helped me manage the database and execute SQL queries.
- **Git & Github:** Vital for version control and collaboration, making certain all SQL scripts and analysis were tracked and shareable.
# The Analysis

Each query for this project seeked to investigate specific aspects of the data analyst job market. Below  is how I aimed to approach each question:

## 1. Top Paying Data Analyst Jobs

To pinpoint the highest-paying roles, I filtered the data analyst roles by average yearly salary and location, focusing on remote jobs within the United States. This query highlights the high paying roles in the field.

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM    
    job_postings_fact
LEFT JOIN company_dim
    ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere' AND
    search_location LIKE '%United States%' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
**Here's the breakdown of the top data analyst jobs in 2023:**

- **Wide Salary Range:** Top 10 paying data analyst roles range from $170,000 to $336,500, indicating significant salary potential in the field.
- **Diverse Employers:** Companies like Meta, SmartAssest, and UCLA Health are among those offering high salaries, showing the need for data analyst within different industries.
- **Job Title Variety:** There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.
-**Remote Opportunities:** These jobs offer remote and hybrid opportunities which shows the flexibility in personnel location within these top company for high paying roles.


![Top Paying Roles](assets\1_top_paying_roles.png)*Bar graph visualizing the salary for the top 10 salaries for data analysts; Created in Excel from my SQL results*

## 2. Skills For Top Paying Jobs
To understand what skills are needed for the top-paying jobs, I joined the jop postings with the skills data, which provided insights into what employers values the most for high-compensation roles.

```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM    
        job_postings_fact
    LEFT JOIN company_dim
        ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND 
        job_location = 'Anywhere' AND
        search_location LIKE '%United States%' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    salary_year_avg DESC;
```
**Here's the breakdown of the most demandd skills for data analysts in 2023:**

- **SQL**, **Python**, and **Tableau** are among the most requested skills with **SQL** being the leading appearing in 9 out of the 10 roles.
- Other skills like **R**, **Excel**, and **Power BI** show varying demand with these roles.
- More niche skills like **Pyspark**, **Databricks**, and **Hadoop** only appear once among these high salary jobs.

![Top Demanded Skills](assets\2_top_skills.png)*Bar graph visualizing the count of skills for the top 10 spaying jobs for data analysts; Created in Excel from my SQL results*

## 3. In-Demand Skills for Data Analysts

This query identified the skills most requested in job postings that offer working from home, helping to understand skills in high demand.

```sql
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
     job_title_short = 'Data Analyst' AND 
    job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```
**Heres's the breakdown of the most demanded skills for data analysts in 2023:**

- **SQL** and **Excel** are foundational skills needed for a data analysts role. This shows the strong need for skills in data manasgement, spreadsheet manipulation, and data processing.
- **Python**, **Tableau**, and **Power BI** are more technical skills which are essential to transform the data with programming and visualizations into a story that can be used to support decision-making insights.


|Skills      | Demand Count|
|------------|-------------|
|SQL	     |7291         |
|Excel	     |4611         |
|Python	     |4330         |
|Tableau	 |3745         |
|Power BI	 |2609         |

*Table of the demand for the top 5 skilld in data analyst job postings*

## 4. Skills Based in Salary

This query dives into the average salaries associated with different skills which uncovered the highest paying skills for a data analyst in the United States.

```sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
     job_title_short = 'Data Analyst' 
     AND salary_year_avg IS NOT NULL
     AND job_location = 'Anywhere' 
     AND search_location LIKE '%United States%'
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
```

**Top-paying skills for data analysts in 2023:**

- Skills like **pyspark**, **bitbucket**,**watson**, and **couchbase** are among the highest average salaries. These are specialized tools are used mostly in big data, advanced analytics, and cloud environments.
- Libraries such as **pandas**, **jupyter**, and **numpy** are also among the top-paying skills. This highlisghts the importance of Pyhton-based data anlysis and scientific computing in the field.
- As a data analyst, investing in advanced, technical, and/or specialized skills will give you access to higher salary opportunities in the job market.


|Skills	    | Average Salary|
|-----------|-----------------|
|pyspark    |	$208,172      |
|bitbucket  |	$189,155      |
|watson     |	$160,515      |
|couchbase  |	$160,515      |
|crystal    |	$158,500      |
|pandas     |	$157,479      |
|gitlab     |	$154,500      |
|swift	    |   $153,750      |
|jupyter    |	$152,777      |
|numpy      |	$152,750      |

*Table of the average salary for the top 10 paying skills for data analysts*

## 5.Most Optimal Skills to Learn

Putting together insights from salary data and demand, this query aimed to pinpoint skills that are in high demand and have high salries within the United States. This focus offered a strategic path for skill development.

```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
    AND search_location LIKE '%United States%' 
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25
```
**Here's a breakdown of the most optiaml skill for Data Analysts in 2023:**

- There is a high demand for programming languages like **python** and **r** with their demand counts being 196 and 127, however, the average salary is around $101,000-$102,000. Having these skills is still highly valued and widely available.
- **SQL** is in the highest demand at 336 but has an average salary around $98,000. 
- The top paid skills **go** ($120,172), **hadoop** ($119,012), and **azure** ($115,166) shows a range of highly valued skills that involves big data, programming languages, and cloud-computing. These skills are in demand and compensate for having a more niche skill.

|Skill ID	|Skills	    |Demand Count	|Average Salary|
|-----------|-----------|---------------|--------------|
|8	        |go	        |24	            |$120,172      |
|97	        |hadoop	    |20	            |$119,012      |
|74	        |azure	    |25	            |$115,166      |
|234        |confluence	|11	            |$114,210      |
|80	        |snowflake	|31	            |$113,683      |
|76	        |aws	    |23	            |$111,463      |
|77	        |bigquery	|12	            |$108,792      |
|4	        |java	    |15	            |$108,490      |
|79	        |oracle	    |34	            |$106,551      |
|194	    |ssis	    |11	            |$106,382      |

*Table of the most optimal skills for data analysts sorted by salary*

# What I Learned

Throughout this project, I've strengthened several key SQL techniques and skill:

- **Advanced Query Techniques:** I learned to build advance SQL queries using JOINs and CTEs to combine multiple tables with also employing WITH clauses for temporaty tables.
- **Data Aggregation:** I utilized GROUP BY and aggregate functions like COUNT() and AVG() to summarize data more effectively and compile key insights from the data.
- **Analytical Thinking:** I developed the ability to translate real-world questions into actionable SQL queries that returned insightful answers.

# Conclusions

### Insights
From the anlaysis, several general insights emerged:

1. **Top-Paying Data Anlayst Jobs:** The highest-paying jobs for data analysts that allow remot work and are withing the United States offered a wide range of salaries, the higest at $336,500.
2. **Skills for Top-Paying Jobs:** Advanced proficiency in SQL is required for high-paying data analyst jobs concluding it is a critical skill to earn a top salary.
3. **Most In-Demand Skills:** SQL is the most demanded skill in the data analyst job market, making it a critical skill oto have in your tool belt.
4. **Skill with Higher Salaries:** Pyspark and bit bucket are the specialized skills associated with the highest average salaries. This indicates having a niche expertise in a skill correlates with a premium salary.
5. **Optimal Skills for Job Market Value:** SQL leads in demand and offers a decent high salary, making it an optimal skill for the job market but skills such as go, hadoop, and azure are in demand and offer the higher end salaries.

### Closing Thoughts

This course and project helped me enhance my SQL skills and provided valuable insights into the data analyst job market. Gaining this base knowledge will help me to continue to expand and develop as I aspire to break into the field as a data analyst. I know what is needed to better position myself in a competitive job market by focusing on the high-demand skills. As I continue to grow as a data analyst, I will branch out into more niche skills after I have a solid foundation in the basic skills needed such as SQL, Excel, Python, and Tableau.