/*
**What are the top skills based on salary?** 

- Look at the average salary associated with each skill for Data Analyst positions.
- Focuses on roles with specified salaries, regardless of location.
- Why? It reveals how different skills impact salary levels for Data Analysts 
    and helps identify the most financially rewarding skills to acquire or improve.
*/


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

[
  {
    "skills": "pyspark",
    "avg_salary": "208172"
  },
  {
    "skills": "bitbucket",
    "avg_salary": "189155"
  },
  {
    "skills": "watson",
    "avg_salary": "160515"
  },
  {
    "skills": "couchbase",
    "avg_salary": "160515"
  },
  {
    "skills": "crystal",
    "avg_salary": "158500"
  },
  {
    "skills": "pandas",
    "avg_salary": "157479"
  },
  {
    "skills": "gitlab",
    "avg_salary": "154500"
  },
  {
    "skills": "swift",
    "avg_salary": "153750"
  },
  {
    "skills": "jupyter",
    "avg_salary": "152777"
  },
  {
    "skills": "numpy",
    "avg_salary": "152750"
  },
  {
    "skills": "microstrategy",
    "avg_salary": "148239"
  },
  {
    "skills": "scikit-learn",
    "avg_salary": "145000"
  },
  {
    "skills": "elasticsearch",
    "avg_salary": "145000"
  },
  {
    "skills": "golang",
    "avg_salary": "145000"
  },
  {
    "skills": "databricks",
    "avg_salary": "143258"
  },
  {
    "skills": "linux",
    "avg_salary": "136508"
  },
  {
    "skills": "kubernetes",
    "avg_salary": "132500"
  },
  {
    "skills": "atlassian",
    "avg_salary": "131162"
  },
  {
    "skills": "twilio",
    "avg_salary": "127000"
  },
  {
    "skills": "postgresql",
    "avg_salary": "126838"
  },
  {
    "skills": "airflow",
    "avg_salary": "126103"
  },
  {
    "skills": "jenkins",
    "avg_salary": "125436"
  },
  {
    "skills": "notion",
    "avg_salary": "125000"
  },
  {
    "skills": "db2",
    "avg_salary": "123780"
  },
  {
    "skills": "gcp",
    "avg_salary": "123750"
  }
]