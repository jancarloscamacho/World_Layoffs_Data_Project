SELECT * FROM layoffs;
#Approaching problems
-- Step 1 Remove Duplicates
-- Step 2 Standardize the Data
-- Step 3 Look at null values
-- Step 4 Remove any columns

CREATE TABLE layoffs_staging LIKE layoffs;
SELECT * FROM layoffs_staging;

INSERT layoffs_staging
SELECT * FROM layoffs;

#creating 
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, 'date') as row_num
FROM layoffs_staging;

#filter where row number is > 2, meaning it is a duplicate
With duplicate_cte AS

(SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, 'date') as row_num
FROM layoffs_staging)
SELECT * 
FROM duplicate_cte
WHERE row_num > 1;

SELECT * FROM layoffs_staging
WHERE company = 'Oyster';

#need to do partition by over all columns
With duplicate_cte AS

(SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) as row_num
FROM layoffs_staging)
SELECT * 
FROM duplicate_cte
WHERE row_num > 1;

SELECT * FROM layoffs_staging
WHERE company = 'Oyster';

CREATE TABLE layoffs_3
LIKE layoffs_staging;


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

#revisit (2:59)
INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) as row_num
FROM layoffs_staging;

#Deleting from table
DELETE FROM layoffs_staging2
WHERE row_num >1;

SELECT * FROM layoffs_staging2; 


-- Standardizing Data

SELECT DISTINCT (company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company); 

SELECT DISTINCT industry
FROM layoffs_staging2
#first col 
ORDER BY 1   ;
#crypto grouped together here not here multiple time

#this would be code to fix uit tho
SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2 
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT location
FROM layoffs_staging2
ORDER BY 1;

SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

#update to remove period from US

UPDATE layoffs_staging2
SET country = 'United States'
WHERE country LIKE ;

#use Trim(trailing)
SELECT DISTINCT country, TRIM(trailing '.' FROM country)
FROM layoffs_staging2
ORDER BY 1;

#THIS ONE
UPDATE layoffs_staging2
SET country = TRIM(trailing '.' FROM country)
FROM layoffs_staging2
WHERE country LIKE 'United States%';

#TIME SERIES
SELECT `date`
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2; 

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

SELECT * from layoffs_staging2;

#change datatype of table
ALTER TABLE layoffs_staging2 
MODIFY COLUMN `date` DATE;


SELECT * FROM layoffs_staging2
WHERE total_laid_off IS NULL;

SELECT * FROM layoffs_staging2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;



SELECT DISTINCT industry FROM layoffs_staging2;

SELECT DISTINCT industry FROM layoffs_staging2
WHERE industry IS NULL or industry = '';

SELECT * FROM layoffs_staging2
WHERE company = 'Airbnb';

#JOINtable to itself
SELECT * FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
    AND t1.location = t2.location
WHERE (t1.industry IS NULL or t1.industry = '')
AND t2.industry is NOT NULL;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL or t1.industry = '')
AND t2.industry is NOT NULL;


#TRIES THIS after 3:24:00, around 26 min



SELECT * FROM layoffs_staging2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

DELETE FROM layoffs_staging2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

SELECT * FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT MAX(total_laid_off), MAX(percent_laid_off)
FROM layoffs_staging2;






