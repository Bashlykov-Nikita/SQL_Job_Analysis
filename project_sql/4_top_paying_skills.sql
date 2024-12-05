-- *Question: What are the top skills based on salary?

-- *- Look at the average salary associated with each skill for Data Analyst positions.
-- *- Focuses on roles with specified salaries, regardless of location.
-- *- Why? It reveals how different skills impact salary levels for Data jobs 
-- *    and helps identify the most financially rewarding skills to acquire or improve.

SELECT
    skills_dim.skills,
    ROUND(AVG(job_postings_fact.salary_year_avg), 2) AS avg_salary_per_skill,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM     
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short LIKE '%Data%'
	AND job_work_from_home = TRUE 
    AND job_postings_fact.salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skills
ORDER BY
    avg_salary_per_skill DESC