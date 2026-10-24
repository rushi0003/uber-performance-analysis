
CREATE TABLE uber_mumbai_rides (
    ride_id VARCHAR(20),
    booking_datetime TIMESTAMP,
    customer_id VARCHAR(12),
    driver_id VARCHAR(12),
    vehicle_type VARCHAR(20),
    pickup_zone VARCHAR(20),
    pickup_area VARCHAR(25),
    drop_zone VARCHAR(20),
    drop_area VARCHAR(25),
    pickup_lat DECIMAL(9,5),
    pickup_lng DECIMAL(9,5),
    distance_km DECIMAL(6,1),
    trip_duration_min INT,
    wait_time_min INT,
    weather VARCHAR(15),
    surge_multiplier DECIMAL(3,1),
    base_fare_inr DECIMAL(9,2),
    toll_fee_inr DECIMAL(7,2),
    promo_code VARCHAR(15),
    discount_inr DECIMAL(7,2),
    total_fare_inr DECIMAL(9,2),
    payment_method VARCHAR(12),
    booking_status VARCHAR(25),
    cancellation_reason VARCHAR(40),
    customer_rating INT,
    driver_avg_rating DECIMAL(3,2),
    driver_earning_inr DECIMAL(9,2),
    booking_source VARCHAR(10),

    -- Excel Helper Columns
    "Hour" INT,
    "Weekday" VARCHAR(10),
    "Month" VARCHAR(8),
    "Time_Band" VARCHAR(20),
    "Completed" INT,
    "Fare_per_km" DECIMAL(10,2),
    "Area_Type" VARCHAR(20),
    "Airport / Non-Airport" VARCHAR(15)
);

SELECT *FROM uber_mumbai_rides;

SELECT COUNT(*) AS total_rows
FROM uber_mumbai_rides;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT ride_id) AS unique_rides,
    COUNT(*) - COUNT(DISTINCT ride_id) AS duplicate_rows
FROM uber_mumbai_rides;

CREATE OR REPLACE VIEW rides_clean AS
SELECT *
FROM (
    SELECT
        r.*,
        ROW_NUMBER() OVER (
            PARTITION BY ride_id
            ORDER BY booking_datetime
        ) AS rn
    FROM uber_mumbai_rides r
) t
WHERE rn = 1
  AND (
      booking_status <> 'Completed'
      OR (
          distance_km > 0
          AND trip_duration_min > 0
          AND distance_km /
              (trip_duration_min / 60.0) >= 4
      )
  );

  SELECT
    COUNT(*) AS clean_rows,
    COUNT(DISTINCT ride_id) AS unique_rides
FROM rides_clean;


SELECT
    COUNT(*) AS total_bookings,

    SUM(
        CASE
            WHEN booking_status = 'Completed' THEN 1
            ELSE 0
        END
    ) AS completed_rides,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN booking_status = 'Completed' THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS completion_rate_pct,

    ROUND(SUM(total_fare_inr), 0)
        AS gross_booking_value_inr,

    ROUND(AVG(total_fare_inr), 2)
        AS avg_fare_inr,

    ROUND(AVG(distance_km), 2)
        AS avg_distance_km,

    ROUND(
        SUM(total_fare_inr) / NULLIF(SUM(distance_km), 0),
        2
    ) AS fare_per_km

FROM rides_clean;

--Are you Growining ?


WITH monthly_data AS (
    SELECT
        EXTRACT(YEAR FROM booking_datetime)::INT AS yr,
        EXTRACT(MONTH FROM booking_datetime)::INT AS mth,

        SUM(
            CASE
                WHEN booking_status = 'Completed' THEN 1
                ELSE 0
            END
        ) AS completed_rides,

        ROUND(SUM(total_fare_inr), 0) AS gbv

    FROM rides_clean
    GROUP BY
        EXTRACT(YEAR FROM booking_datetime),
        EXTRACT(MONTH FROM booking_datetime)
),
monthly_comparison AS (
    SELECT
        yr,
        mth,
        completed_rides,
        gbv,

        LAG(completed_rides) OVER (
            ORDER BY yr, mth
        ) AS previous_month_rides

    FROM monthly_data
)
SELECT
    yr,
    mth,
    completed_rides,
    gbv,
    previous_month_rides,

    ROUND(
        100.0 * (completed_rides - previous_month_rides)
        / NULLIF(previous_month_rides, 0),
        1
    ) AS mom_growth_pct

FROM monthly_comparison
ORDER BY yr, mth;

--Rank areas by demand and service quality


SELECT
    pickup_area,
    pickup_zone,

    COUNT(*) AS bookings,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN booking_status = 'Completed' THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(*), 0),
        1
    ) AS completion_pct,

    ROUND(
        AVG(
            CASE
                WHEN booking_status = 'Completed'
                THEN total_fare_inr
            END
        ),
        0
    ) AS avg_fare,

    ROUND(AVG(wait_time_min), 1) AS avg_wait_min,

    RANK() OVER (
        ORDER BY COUNT(*) DESC
    ) AS demand_rank

FROM rides_clean

GROUP BY pickup_area, pickup_zone

ORDER BY demand_rank, pickup_area;

--Best time to push offers?


SELECT
    EXTRACT(HOUR FROM booking_datetime)::INT AS hr,

    SUM(
        CASE
            WHEN EXTRACT(ISODOW FROM booking_datetime) IN (6, 7)
            THEN 1
            ELSE 0
        END
    ) AS weekend_bookings,

    SUM(
        CASE
            WHEN EXTRACT(ISODOW FROM booking_datetime) BETWEEN 1 AND 5
            THEN 1
            ELSE 0
        END
    ) AS weekday_bookings

FROM rides_clean

GROUP BY EXTRACT(HOUR FROM booking_datetime)
ORDER BY hr;

--Cost of rain?


SELECT
    COALESCE(weather, 'Unknown') AS weather,
    COUNT(*) AS bookings,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN booking_status = 'Completed' THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(*), 0),
        1
    ) AS completion_pct,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN booking_status = 'No Driver Found' THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(*), 0),
        1
    ) AS no_driver_pct,

    ROUND(AVG(wait_time_min), 1) AS avg_wait,

    ROUND(AVG(surge_multiplier), 2) AS avg_surge,

    ROUND(AVG(customer_rating), 2) AS avg_rating

FROM rides_clean

GROUP BY COALESCE(weather, 'Unknown')

ORDER BY bookings DESC;

--Why do drivers cancel?


SELECT
    CASE
        WHEN distance_km < 2.5 THEN '1. Under 2.5 km'
        WHEN distance_km < 8 THEN '2. 2.5 - 8 km'
        WHEN distance_km < 18 THEN '3. 8 - 18 km'
        ELSE '4. Above 18 km'
    END AS distance_bucket,

    COUNT(*) AS bookings,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN booking_status = 'Cancelled by Driver'
                THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(*), 0),
        1
    ) AS driver_cancel_pct

FROM rides_clean
GROUP BY 1
ORDER BY 1;

--UPI adoption?


SELECT
    EXTRACT(YEAR FROM booking_datetime)::INT AS yr,
    EXTRACT(MONTH FROM booking_datetime)::INT AS mth,

    ROUND(
        100.0 * SUM(
            CASE WHEN payment_method = 'UPI'
                 THEN 1 ELSE 0 END
        ) / NULLIF(COUNT(*), 0),
        1
    ) AS upi_pct,

    ROUND(
        100.0 * SUM(
            CASE WHEN payment_method = 'Cash'
                 THEN 1 ELSE 0 END
        ) / NULLIF(COUNT(*), 0),
        1
    ) AS cash_pct

FROM rides_clean
WHERE booking_status = 'Completed'
  AND payment_method IS NOT NULL

GROUP BY
    EXTRACT(YEAR FROM booking_datetime),
    EXTRACT(MONTH FROM booking_datetime)

ORDER BY yr, mth;

--Are promos efficient?


SELECT
    COALESCE(promo_code, 'No promo') AS promo,
    COUNT(*) AS rides,

    ROUND(
        AVG(base_fare_inr * surge_multiplier),
        0
    ) AS avg_gross_fare,

    ROUND(
        AVG(discount_inr),
        1
    ) AS avg_discount,

    ROUND(
        100.0 * SUM(discount_inr)
        / NULLIF(
            SUM(base_fare_inr * surge_multiplier),
            0
        ),
        1
    ) AS discount_pct_of_gross

FROM rides_clean
WHERE booking_status = 'Completed'

GROUP BY COALESCE(promo_code, 'No promo')
ORDER BY rides DESC;

--How dependent are we on top drivers?


WITH d AS (
    SELECT
        driver_id,
        COUNT(*) AS rides
    FROM rides_clean
    WHERE booking_status = 'Completed'
      AND driver_id IS NOT NULL
    GROUP BY driver_id
),
x AS (
    SELECT
        driver_id,
        rides,
        NTILE(10) OVER (ORDER BY rides DESC) AS decile
    FROM d
)
SELECT
    decile,
    COUNT(*) AS drivers,
    SUM(rides) AS rides,
    ROUND(
        100.0 * SUM(rides) /
        NULLIF((SELECT SUM(rides) FROM d), 0),
        1
    ) AS share_pct
FROM x
GROUP BY decile
ORDER BY decile;

--Who are our best customers?


WITH c AS (
    SELECT
        customer_id,
        COUNT(*) AS rides,
        SUM(total_fare_inr) AS spend
    FROM rides_clean
    WHERE booking_status = 'Completed'
      AND customer_id IS NOT NULL
    GROUP BY customer_id
)
SELECT
    CASE
        WHEN rides = 1 THEN '1 ride (one-time)'
        WHEN rides <= 3 THEN '2-3 rides (occasional)'
        WHEN rides <= 8 THEN '4-8 rides (regular)'
        ELSE '9+ rides (loyal)'
    END AS segment,

    COUNT(*) AS customers,
    ROUND(SUM(spend), 0) AS total_spend,

    ROUND(
        100.0 * SUM(spend) /
        NULLIF((SELECT SUM(spend) FROM c), 0),
        1
    ) AS spend_share_pct

FROM c
GROUP BY 1
ORDER BY 1;

--Which corridors matter?


SELECT
    pickup_area,
    drop_area,
    COUNT(*) AS rides,
    ROUND(AVG(total_fare_inr), 0) AS avg_fare
FROM rides_clean
WHERE booking_status = 'Completed'
  AND pickup_area <> drop_area
GROUP BY pickup_area, drop_area
ORDER BY rides DESC
LIMIT 10;

--Find days the service broke?


SELECT
    CAST(booking_datetime AS DATE) AS d,
    COUNT(*) AS bookings,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN booking_status = 'No Driver Found'
                THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(*), 0),
        1
    ) AS no_driver_pct

FROM rides_clean

GROUP BY CAST(booking_datetime AS DATE)

HAVING
    100.0 * SUM(
        CASE
            WHEN booking_status = 'No Driver Found'
            THEN 1
            ELSE 0
        END
    ) / NULLIF(COUNT(*), 0) > 12

ORDER BY no_driver_pct DESC
LIMIT 10;

--Where do riders travel?


SELECT
    pickup_zone,
    drop_zone,
    COUNT(*) AS rides
FROM rides_clean
WHERE booking_status = 'Completed'
GROUP BY pickup_zone, drop_zone
ORDER BY pickup_zone, rides DESC;

--Vehicle-wise Fare, Surge and Driver Share


SELECT
    vehicle_type,
    ROUND(AVG(total_fare_inr), 0) AS avg_fare,

    ROUND(
        100.0 * SUM(
            CASE WHEN surge_multiplier > 1 THEN 1 ELSE 0 END
        ) / COUNT(*), 1
    ) AS surge_rides_pct,

    ROUND(
        AVG(driver_earning_inr / NULLIF(total_fare_inr, 0)) * 100,
        1
    ) AS driver_share_pct

FROM rides_clean
WHERE booking_status = 'Completed'
GROUP BY vehicle_type
ORDER BY avg_fare DESC;
