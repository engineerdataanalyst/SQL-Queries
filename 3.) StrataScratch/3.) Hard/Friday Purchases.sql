/* IBM is working on a new feature to analyze user purchasing behavior for all Fridays in the first quarter of the year.
   For each Friday separately, calculate the average amount users have spent per order. 
   The output should contain the week number of that Friday and average amount spent. */

WITH WeekNumbers AS
(
    SELECT GENERATE_SERIES(1, 13) AS week_number
),
MeanAmounts AS
(
    SELECT
        DATE_PART('week', date) AS week_number,
        AVG(amount_spent) AS mean_amount
    FROM user_purchases
    WHERE day_name = 'Friday' AND EXTRACT(QUARTER FROM date) = 1
    GROUP BY week_number
)
SELECT DISTINCT
    W.week_number,
    COALESCE(M.mean_amount, 0) AS mean_amount
FROM WeekNumbers W
LEFT JOIN MeanAmounts M ON W.week_number = M.week_number
ORDER BY W.week_number;
