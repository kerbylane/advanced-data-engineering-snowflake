USE ROLE accountadmin;
CREATE DATABASE course_repo;
USE SCHEMA public;

-- Create credentials
CREATE OR REPLACE SECRET course_repo.public.github_pat
  TYPE = password
  USERNAME = '[github user name here]'
  PASSWORD = '[put the GitHub token content here]';

-- Create the API integration
CREATE OR REPLACE API INTEGRATION git_api_integration
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('[url to your account]') -- URL to your GitHub profile
  ALLOWED_AUTHENTICATION_SECRETS = (GITHUB_PAT)
  ENABLED = TRUE;

-- Create the git repository object
CREATE OR REPLACE GIT REPOSITORY course_repo.public.advanced_data_engineering_snowflake
  API_INTEGRATION = git_api_integration -- Name of the API integration defined above
  ORIGIN = 'https://github.com/kerbylane/advanced-data-engineering-snowflake.git' -- Insert URL of forked repo
  GIT_CREDENTIALS = course_repo.public.github_pat;

-- List the git repositories
SHOW GIT REPOSITORIES;