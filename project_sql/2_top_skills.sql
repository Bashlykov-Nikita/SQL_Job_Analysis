-- *Question: What are the top-paying entry data jobs, and what skills are required?

-- *- Identify the top 10 highest-paying entry data jobs and the specific skills required for these roles.
-- *- Filters for roles with specified salaries that are remote
-- *- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
-- *    helping job seekers understand which skills to develop that align with top salaries

WITH top_paying_jobs AS (
    SELECT
        job_postings_fact.job_id,
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
    )

SELECT 
    top_paying_jobs.job_title,
    top_paying_jobs.company_name,
    top_paying_jobs.salary_year_avg,
    skills_dim.skills

FROM top_paying_jobs
INNER JOIN
    skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
LIMIT 50
