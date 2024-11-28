
-- *Question: What are the top-paying entry data jobs?**

-- *- Identify the top 10 highest-paying data roles that are available remotely.
-- *- Focuses on job postings with specified salaries.
-- *- Why? Aims to highlight the top-paying opportunities, 
-- *    offering insights into employment options and location flexibility.
SELECT
    job_postings_fact.job_title,
    company_dim.name AS company_name,
    job_postings_fact.salary_year_avg,
    job_postings_fact.job_schedule_type,
    job_postings_fact.job_location,
    job_postings_fact.job_posted_date
FROM 
    job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title NOT LIKE '%Business Analyst%' AND 
    (job_title LIKE '%Junior%' OR job_title LIKE'%Entry%') 
    AND salary_year_avg IS NOT NULL
    AND job_location = 'Anywhere'
ORDER BY salary_year_avg DESC
LIMIT 10