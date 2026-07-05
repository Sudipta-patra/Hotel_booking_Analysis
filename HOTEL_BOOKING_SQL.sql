select * from hotel_data 

--Q1. Find out the average 
SELECT AVG(is_canceled)
FROM hotel_data 

--Q2.Find the average of total guest per booking for each hotel
SELECT hotel,
	AVG(adults + COALESCE(children,0)+babies) as total_guest
FROM hotel_data 
GROUP BY hotel
limit 10;

--Q3.total special requst trend
SELECT arrival_date_year,
	sum(total_of_special_requests)
FROM hotel_data
GROUP BY arrival_date_year
ORDER BY arrival_date_year DESC;

--Q4.Total bookings with children or babies
SELECT COUNT(*) AS family_bookings
FROM hotel_data
WHERE children >0 OR babies >0

--Q5. Lenght of stay analysis difference weekends and weekdays
SELECT hotel,
ROUND(AVG(stays_in_weekend_nights + stays_in_week_nights),2) AS avg_len_stay
FROM hotel_data
WHERE is_canceled =0
GROUP BY hotel;

--Q6.what are the reservation_status acordi 
SELECT month, count(reservation_status_date),
	count(is_canceled)
FROM hotel_data
GROUP BY month
ORDER BY month;


--Q7.Find Reservation status count 
SELECT is_canceled, COUNT(*) AS counts,
    ROUND(COUNT(*)::NUMERIC / SUM(COUNT(*)) OVER() * 100, 2) AS percentage_for_both
FROM hotel_data
GROUP BY is_canceled;

--Q8. Reservation status in different hotels
SELECT hotel,
    COUNT(CASE WHEN is_canceled = 0 THEN 1 END) AS not_canceled,
    COUNT(CASE WHEN is_canceled = 1 THEN 1 END) AS canceled,
    COUNT(*) AS total_reservations
FROM hotel_data
GROUP BY hotel;

--Q9. find the cancelation rate for City Hotel 
WITH hotel_data AS (
    SELECT is_canceled 
    FROM hotel_data 
    WHERE hotel = 'City Hotel'
)
SELECT is_canceled,
    COUNT(*) AS counts,
    COUNT(*)::NUMERIC / (SELECT COUNT(*) FROM hotel_data) AS proportion
FROM hotel_data
GROUP BY is_canceled;

--Q10. find the cancelation rate for Resort Hotel 
WITH hotel_data AS (
    SELECT is_canceled 
    FROM hotel_data 
    WHERE hotel = 'Resort Hotel'
)
SELECT is_canceled,
    COUNT(*) AS counts,
    COUNT(*)::NUMERIC / (SELECT COUNT(*) FROM hotel_data) AS proportion
FROM hotel_data
GROUP BY is_canceled;
