-- Clean school-level data
CREATE TABLE school_results AS
SELECT
  "Division Number" AS division_number,
  "Division Name" AS division_name,
  "School Number" AS school_number,
  "School Name" AS school_name,
  "School Year" AS school_year,
  CASE
    WHEN "Pass Rate" = '<' THEN NULL
    ELSE CAST("Pass Rate" AS REAL)
  END AS school_pass_rate
FROM school_results_raw;
-- Compute district year-over-year change
CREATE VIEW v_district_yoy AS
WITH d AS (
  SELECT
    division_number,
    division_name,
    school_year,
    district_pass_rate
  FROM district_results
),
w AS (
  SELECT
    division_number,
    division_name,
    school_year,
    district_pass_rate,
    LAG(district_pass_rate) OVER (
      PARTITION BY division_number
      ORDER BY school_year
    ) AS prev_rate
  FROM d
)
SELECT
  division_number,
  division_name,
  school_year,
  district_pass_rate,
  (district_pass_rate - prev_rate) AS district_yoy_change
FROM w;
-- Compute district year-over-year change
CREATE VIEW v_district_yoy AS
WITH d AS (
  SELECT
    division_number,
    division_name,
    school_year,
    district_pass_rate
  FROM district_results
),
w AS (
  SELECT
    division_number,
    division_name,
    school_year,
    district_pass_rate,
    LAG(district_pass_rate) OVER (
      PARTITION BY division_number
      ORDER BY school_year
    ) AS prev_rate
  FROM d
)
SELECT
  division_number,
  division_name,
  school_year,
  district_pass_rate,
  (district_pass_rate - prev_rate) AS district_yoy_change

FROM w;
