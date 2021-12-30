/*

EDA#2 - Exploratory Data Analysis - COVID-19

This project is an exploratory data analysis based on the COVID-19 dataset made available by Our World in Data.
Our main objective here is to explore the data using multiple functions and expressions of the T-SQL language.

A brief paragraph on COVID-19:

The COVID-19 pandemic is an ongoing global pandemic of coronavirus disease 2019 (COVID-19) caused by severe acute respiratory syndrome coronavirus 2 (SARS-CoV-2). 
The novel virus was first identified from an outbreak in the Chinese city of Wuhan in December 2019, and attempts to contain it there failed, allowing it to spread across the globe. 
The World Health Organization (WHO) declared a Public Health Emergency of International Concern on 30 January 2020 and a pandemic on 11 March 2020. 
As of 28 December 2021, the pandemic had caused more than 281 million cases and 5.4 million deaths, making it one of the deadliest in history.

More on the COVID-19 disease: https://en.wikipedia.org/wiki/COVID-19
More on the COVID-19 pandemic: https://en.wikipedia.org/wiki/COVID-19_pandemic

Data Source: https://ourworldindata.org/coronavirus

Author: Augusto Gontijo
LinkedIn: https://www.linkedin.com/in/augusto-gontijo/?locale=en_US
GitHub: https://github.com/augusto-gontijo

*/

-- DATABASE CREATION

IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'COVID_EDA')
  BEGIN
    CREATE DATABASE COVID_EDA		
	PRINT 'The database "COVID_EDA" was successfully created.'
  END
ELSE
	PRINT 'A database named "COVID_EDA" already exists.'
	USE COVID_EDA
GO

-- RAW TABLE CREATION

IF OBJECT_ID('TB_COVID_RAW', 'U') IS NOT NULL
	BEGIN	
	PRINT 'A table named "TB_COVID_RAW" already exists.'
	END
ELSE
	USE COVID_EDA
	CREATE TABLE TB_COVID_RAW (
	iso_code NVARCHAR(50),
	continent NVARCHAR(50),
	location NVARCHAR(50),
	date DATE,
	total_cases FLOAT,
	new_cases FLOAT,
	new_cases_smoothed FLOAT,
	total_deaths FLOAT,
	new_deaths FLOAT,
	new_deaths_smoothed FLOAT,
	total_cases_per_million FLOAT,
	new_cases_per_million FLOAT,
	new_cases_smoothed_per_million FLOAT,
	total_deaths_per_million FLOAT,
	new_deaths_per_million FLOAT,
	new_deaths_smoothed_per_million FLOAT,
	reproduction_rate FLOAT,
	icu_patients FLOAT,
	icu_patients_per_million FLOAT,
	hosp_patients FLOAT,
	hosp_patients_per_million FLOAT,
	weekly_icu_admissions FLOAT,
	weekly_icu_admissions_per_million FLOAT,
	weekly_hosp_admissions FLOAT,
	weekly_hosp_admissions_per_million FLOAT,
	new_tests FLOAT,
	total_tests FLOAT,
	total_tests_per_thousand FLOAT,
	new_tests_per_thousand FLOAT,
	new_tests_smoothed FLOAT,
	new_tests_smoothed_per_thousand FLOAT,
	positive_rate FLOAT,
	tests_per_case FLOAT,
	tests_units NVARCHAR(50),
	total_vaccinations FLOAT,
	people_vaccinated FLOAT,
	people_fully_vaccinated FLOAT,
	total_boosters FLOAT,
	new_vaccinations FLOAT,
	new_vaccinations_smoothed FLOAT,
	total_vaccinations_per_hundred FLOAT,
	people_vaccinated_per_hundred FLOAT,
	people_fully_vaccinated_per_hundred FLOAT,
	total_boosters_per_hundred FLOAT,
	new_vaccinations_smoothed_per_million FLOAT,
	new_people_vaccinated_smoothed FLOAT,
	new_people_vaccinated_smoothed_per_hundred FLOAT,
	stringency_index FLOAT,
	population FLOAT,
	population_density FLOAT,
	median_age FLOAT,
	aged_65_older FLOAT,
	aged_70_older FLOAT,
	gdp_per_capita FLOAT,
	extreme_poverty FLOAT,
	cardiovasc_death_rate FLOAT,
	diabetes_prevalence FLOAT,
	female_smokers FLOAT,
	male_smokers FLOAT,
	handwashing_facilities FLOAT,
	hospital_beds_per_thousand FLOAT,
	life_expectancy FLOAT,
	human_development_index FLOAT,
	excess_mortality_cumulative_absolute FLOAT,
	excess_mortality_cumulative FLOAT,
	excess_mortality FLOAT,
	excess_mortality_cumulative_per_million FLOAT
	)
	PRINT 'The table named "TB_COVID_RAW" was successfully created.' 
	
-- TRUNCATE TABLE

TRUNCATE TABLE [dbo].[TB_COVID_RAW]
GO
 
-- IMPORT CSV FILE (REMEMBER TO INPUT THE CORRECT PATH FROM YOUR COMPUTER)

BULK INSERT [dbo].[TB_COVID_RAW]
FROM 'C:\YOUR COMPUTER PATH\owid-covid-data.csv'
WITH
(
        FORMAT='CSV',
        FIRSTROW=2,
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '0x0a'
)
GO

-- CREATING VIEWS

CREATE VIEW VW_LOCATION AS
SELECT 
DISTINCT r.iso_code,
r.continent,
r.location,
r.population
FROM
TB_COVID_RAW AS r
GO

CREATE VIEW VW_CASES AS
SELECT 
r.iso_code,
r.date,
r.total_cases,
r.new_cases,
r.new_cases_smoothed,
r.total_deaths,
r.new_deaths,
r.new_deaths_smoothed,
r.total_cases_per_million,
r.new_cases_per_million,
r.new_cases_smoothed_per_million,
r.total_deaths_per_million,
r.new_deaths_per_million,
r.new_deaths_smoothed_per_million,
r.reproduction_rate,
r.icu_patients,
r.icu_patients_per_million,
r.hosp_patients,
r.hosp_patients_per_million,
r.weekly_icu_admissions,
r.weekly_icu_admissions_per_million,
r.weekly_hosp_admissions,
r.weekly_hosp_admissions_per_million,
r.new_tests,
r.total_tests,
r.total_tests_per_thousand,
r.new_tests_per_thousand,
r.new_tests_smoothed,
r.new_tests_smoothed_per_thousand,
r.positive_rate,
r.tests_per_case,
r.tests_units
FROM
TB_COVID_RAW AS r
GO

CREATE VIEW VW_VAC AS
SELECT 
r.iso_code,
r.date,
r.total_vaccinations,
r.people_vaccinated,
r.people_fully_vaccinated,
r.total_boosters,
r.new_vaccinations,
r.new_vaccinations_smoothed,
r.total_vaccinations_per_hundred,
r.people_vaccinated_per_hundred,
r.people_fully_vaccinated_per_hundred,
r.total_boosters_per_hundred,
r.new_vaccinations_smoothed_per_million,
r.new_people_vaccinated_smoothed,
r.new_people_vaccinated_smoothed_per_hundred,
r.stringency_index,
r.population_density,
r.median_age,
r.aged_65_older,
r.aged_70_older,
r.gdp_per_capita,
r.extreme_poverty,
r.cardiovasc_death_rate,
r.diabetes_prevalence,
r.female_smokers,
r.male_smokers,
r.handwashing_facilities,
r.hospital_beds_per_thousand,
r.life_expectancy,
r.human_development_index,
r.excess_mortality_cumulative_absolute,
r.excess_mortality_cumulative,
r.excess_mortality,
r.excess_mortality_cumulative_per_million
FROM
TB_COVID_RAW AS r
GO

-- ANALYSIS QUERIES

-- List of all countries ordered by nº of total cases with the latest update:
SELECT 
l.[location] AS country, 
MAX(c.[date]) AS 'latest_update', 
MAX(c.total_cases) AS 'total_cases'
FROM VW_CASES c
JOIN VW_LOCATION l 
ON c.iso_code = l.iso_code
WHERE l.continent IS NOT NULL
GROUP BY l.[location]
HAVING MAX(c.total_cases) >= 0
ORDER BY 3 DESC

-- List of the top 10 contries with the highest death ratio (latest update):
SELECT TOP 10
l.[location] AS country, 
MAX(c.[date]) AS 'latest_update', 
ROUND((MAX(c.total_deaths) / MAX(c.total_cases)) * 100,2) AS 'death_ratio'
FROM VW_CASES c
JOIN VW_LOCATION l 
ON c.iso_code = l.iso_code
WHERE l.continent IS NOT NULL
GROUP BY l.[location]
ORDER BY 3 DESC

-- List of all continents sorted by the highest death ratio (latest update):

SELECT
t.continent,
CONVERT(VARCHAR, ROUND((total_deaths / total_cases) * 100,2)) + ' %' AS 'death_ratio'
FROM
	(SELECT
	l.[continent] AS continent, 	 
	SUM(c.new_deaths) AS 'total_deaths',
	SUM(c.new_cases) AS 'total_cases'	
	FROM VW_CASES c
	JOIN VW_LOCATION l 
	ON c.iso_code = l.iso_code
	WHERE l.continent IS NOT NULL
	GROUP BY l.[continent]	
	) t
ORDER BY death_ratio DESC

-- List of all countries that are categorized as "Critical Countries" (countries with "High Infection" and "Low Vaccination" ratios).
-- The data were stored in a temporary table:

CREATE TABLE #TB_CRITICAL_COUNTRIES ([country] VARCHAR(50), [infection_ratio] FLOAT, [vaccionation_ratio] FLOAT)
INSERT INTO #TB_CRITICAL_COUNTRIES

	SELECT
	country,
	infection_ratio,
	vaccionation_ratio
	FROM
		(SELECT
		country,
		infection_ratio,
		vaccionation_ratio,
		CASE WHEN infection_ratio >= 10 THEN 'High Infection' ELSE 'Low Infection' END infection_status,
		CASE WHEN vaccionation_ratio >= 70 THEN 'High Vaccionation' ELSE 'Low Vaccination' END vaccination_status
		FROM
			(SELECT
			l.[location] AS country, 
			MAX(c.[date]) AS 'latest_update', 
			ROUND((MAX(c.total_cases) / MAX(l.[population])) * 100,2) AS 'infection_ratio',
			ROUND((MAX(v.people_vaccinated) / MAX(l.[population])) * 100,2) AS 'vaccionation_ratio'
			FROM VW_CASES c
			JOIN VW_LOCATION l 
			ON c.iso_code = l.iso_code
			JOIN VW_VAC v
			ON v.iso_code = l.iso_code
			WHERE l.continent IS NOT NULL
			GROUP BY l.[location]
			) temp
		) temp2
	WHERE infection_status = 'High Infection'
	AND vaccination_status = 'Low Vaccination'

SELECT * FROM #TB_CRITICAL_COUNTRIES
ORDER BY infection_ratio DESC

-- Comparison between the nº of new cases and the previous month new cases. new cases growth throuout the months.
-- The desired country can be setted on the "@country" variable:

DECLARE @country AS VARCHAR(50)
SET @country = 'Brazil'

SELECT 
country,
year_month,
new_cases,
prev_month_new_cases,
CONVERT(VARCHAR, ROUND(((new_cases - prev_month_new_cases)/prev_month_new_cases)*100,2)) + ' %' AS new_cases_growth
FROM

	(SELECT
	country,
	year_month,
	new_cases,
	LAG(new_cases, 1) OVER (ORDER BY year_month) AS prev_month_new_cases
	FROM

		(SELECT 
		l.[location] AS country,
		LEFT(CONVERT(VARCHAR, DATEFROMPARTS(YEAR(c.[date]), MONTH(c.[date]), '01')), 7) AS year_month,
		SUM(c.new_cases) AS new_cases
		FROM VW_CASES c
		JOIN VW_LOCATION l
		ON c.iso_code = l.iso_code
		WHERE l.[location] = @country
		GROUP BY l.[location], LEFT(CONVERT(VARCHAR, DATEFROMPARTS(YEAR(c.[date]), MONTH(c.[date]), '01')), 7)
		) t
	) t2

-- Rolling average of the new vaccinations of the selected country (considering current day + 6 preceding days)
-- Usage of variables for easy selection of country and period:

DECLARE @country AS VARCHAR(50)
DECLARE @dt_start AS DATE
DECLARE @dt_end AS DATE

SET @country = 'Brazil'
SET @dt_start = '2021-01-18'
SET @dt_end = '2021-12-31'

SELECT
l.[location] AS country,
v.[date],
v.new_vaccinations,
ROUND(AVG(v.new_vaccinations) OVER (ORDER BY v.[date] ROWS 6 PRECEDING),0) AS new_vac_rolling_avg
FROM VW_VAC v
JOIN VW_LOCATION l
ON v.iso_code = l.iso_code
WHERE l.[location] = @country
AND v.[date] >= @dt_start
AND v.[date] <= @dt_end

-- Listing of the 5 months with the highest count of new deaths on each critical country:

SELECT 
f.country as critical_country,
f.year_month,
f.new_deaths,
f.rank_id
FROM
	(SELECT
	e.country,
	e.year_month,
	e.new_deaths,
	DENSE_RANK() OVER (PARTITION BY e.country ORDER BY e.new_deaths DESC) AS rank_id
	FROM
		(
		SELECT 
		l.[location] AS country,
		LEFT(CONVERT(VARCHAR, DATEFROMPARTS(YEAR(c.[date]), MONTH(c.[date]), '01')), 7) AS year_month,
		SUM(c.new_deaths) AS new_deaths
		FROM VW_CASES c
		JOIN VW_LOCATION l
		ON c.iso_code = l.iso_code
		GROUP BY l.[location], LEFT(CONVERT(VARCHAR, DATEFROMPARTS(YEAR(c.[date]), MONTH(c.[date]), '01')), 7)
		) e
	) f
WHERE f.rank_id <= 5
AND f.new_deaths > 0
AND f.new_deaths IS NOT NULL
AND f.country IN (SELECT country FROM #TB_CRITICAL_COUNTRIES)

-- A list of all countries with the latest death_ratio, latest stringency index and a "critical country" flag.
-- A temporary table named "#TB_LATEST_STR_INDEX" was created for this query:

CREATE TABLE #TB_LATEST_STR_INDEX (country VARCHAR(50), [date] DATE, stringency_index FLOAT)
INSERT INTO #TB_LATEST_STR_INDEX
	SELECT 
	a.country,
	a.[date],
	b.stringency_index
	FROM
		(SELECT
		l.[location] AS country,
		MAX(v.[date]) AS 'date'
		FROM VW_LOCATION l 
		JOIN VW_VAC v
		ON v.iso_code = l.iso_code
		WHERE v.stringency_index IS NOT NULL
		GROUP BY l.[location]
		) a
		JOIN
		(SELECT
		l.[location] AS country,
		v.[date] AS 'date',
		v.stringency_index
		FROM VW_LOCATION l 
		JOIN VW_VAC v
		ON v.iso_code = l.iso_code
		WHERE v.stringency_index IS NOT NULL
		) b
		ON a.country = b.country AND a.[date] = b.[date]

SELECT 
l.[location] AS country, 
ROUND((MAX(c.total_deaths) / MAX(c.total_cases)) * 100,2) AS 'death_ratio',
si.stringency_index,
CASE WHEN l.[location] IN (SELECT country FROM #TB_CRITICAL_COUNTRIES) THEN 'Yes'
ELSE 'No'
END critical_country
FROM VW_CASES c
JOIN VW_LOCATION l 
ON c.iso_code = l.iso_code
JOIN #TB_LATEST_STR_INDEX si
ON l.[location] = si.country
WHERE l.continent IS NOT NULL
GROUP BY l.[location], si.stringency_index
ORDER BY 2 DESC

-- Information on stringency_index:

/*The stringency index is a composite measure based on nine response indicators including school closures, workplace closures, and travel bans, rescaled to a
value from 0 to 100 (100 = strictest). If policies vary at the subnational level, the index shows the response level of the strictest subregion.*/