/*
======================================================================
SQL FILE: Ola Booking Analysis 

DESCRIPTION:
    This SQL file contains a series of views for analyzing booking data.
    Each view corresponds to a specific query designed to extract 
    actionable insights from the dataset, such as booking trends, 
    ride cancellations, customer behaviors, driver performance, and 
    payment method analysis.

PURPOSE:
    - To structure complex queries into reusable and manageable views.
    - To facilitate efficient analysis and reporting on the booking dataset.

LIST OF VIEWS:
    1. **Successful_Bookings:**
       - Retrieves all successfully completed bookings.
    2. **ride_distance_for_each_vehicle:**
       - Calculates the average ride distance for each vehicle type.
    3. **cancelled_rides_by_customers:**
       - Provides the total number of rides canceled by customers.
    4. **Top_5_Customers:**
       - Lists the top 5 customers who booked the highest number of rides.
    5. **Rides_cancelled_by_Drivers_P_C_Issues:**
       - Shows the number of rides canceled by drivers due to personal and 
         car-related issues.
    6. **Max_Min_Driver_Rating:**
       - Finds the maximum and minimum driver ratings for Prime Sedan bookings.
    7. **UPI_Payment:**
       - Retrieves all rides where payment was made using UPI.
    8. **AVG_Cust_Rating:**
       - Calculates the average customer rating for each vehicle type.
    9. **total_successful_ride_value:**
       - Computes the total booking value of rides successfully completed.
    10. **Incomplete_Rides_Reason:**
        - Lists all incomplete rides along with the reasons for incompletion.
    11. **Percentage_ride_canceled:**
        - Finds the percentage of rides canceled due to "Personal & Car 
          related issues" for each vehicle type.
    12. **total_booking_value_by_each_payment_method:**
        - Calculates the total booking value for each payment method and 
          ranks them by popularity.
    13. **Avg_booking_value_per_km_successful_rides:**
        - Computes the average booking value per kilometer for successful 
          rides for each vehicle type.

NOTES:
    - Ensure the appropriate database is selected before running this file.
    - Modify database and table names as needed to align with your schema.
    - These views are designed for performance and reusability.

======================================================================
*/

CREATE DATABASE bookings;
USE bookings;

#1. Retrieve all successful bookings:
Create View Successful_Bookings As
SELECT * FROM bookings
WHERE Booking_Status = 'Success';

#2. Find the average ride distance for each vehicle type:
Create View ride_distance_for_each_vehicle As
SELECT Vehicle_Type, AVG(Ride_Distance)
as avg_distance FROM bookings
GROUP BY Vehicle_Type;

#3. Get the total number of cancelled rides by customers:
Create View cancelled_rides_by_customers As
SELECT COUNT(*) FROM bookings
WHERE Booking_Status = 'cancelled by Customer';

#4. List the top 5 customers who booked the highest number of rides:
Create View Top_5_Customers As
SELECT Customer_ID, COUNT(Booking_ID) as total_rides
FROM bookings
GROUP BY Customer_ID
ORDER BY total_rides DESC LIMIT 5;

#5. Get the number of rides cancelled by drivers due to personal and car-related issues:
Create View Rides_cancelled_by_Drivers_P_C_Issues As
SELECT COUNT(*) FROM bookings
WHERE Canceled_Rides_by_Driver = 'Personal & Car related issue';


#6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
Create View Max_Min_Driver_Rating As
SELECT MAX(Driver_Ratings) as max_rating,
MIN(Driver_Ratings) as min_rating
FROM bookings WHERE Vehicle_Type = 'Prime Sedan';

#7. Retrieve all rides where payment was made using UPI:
Create View UPI_Payment As
SELECT * FROM bookings
WHERE Payment_Method = 'UPI';

#8. Find the average customer rating per vehicle type:
Create View AVG_Cust_Rating As
SELECT Vehicle_Type, AVG(Customer_Rating) as avg_customer_rating
FROM bookings
GROUP BY Vehicle_Type;

#9. Calculate the total booking value of rides completed successfully:
Create View total_successful_ride_value As
SELECT SUM(Booking_Value) as total_successful_ride_value
FROM bookings
WHERE Booking_Status = 'Success';

#10. List all incomplete rides along with the reason:
Create View Incomplete_Rides_Reason As
SELECT Booking_ID, Incomplete_Rides_Reason
FROM bookings
WHERE Incomplete_Rides = 'Yes';

#11. Find the percentage of rides canceled due to "Personal & Car related issues" for each vehicle type.
Create View Percentage_ride_canceled As
SELECT Vehicle_Type,
       COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Bookings) AS Cancellation_Percentage
FROM Bookings
WHERE Canceled_Rides_by_Driver = 'Personal & Car related issue'
GROUP BY Vehicle_Type;

#12. Calculate the total booking value for each payment method and rank them by popularity.
Create View total_booking_value_by_each_payment_method As
SELECT Payment_Method,
       SUM(Booking_Value) AS Total_Booking_Value,
       COUNT(*) AS Number_of_Transactions
FROM Bookings
WHERE Payment_Method IS NOT NULL
GROUP BY Payment_Method
ORDER BY Number_of_Transactions DESC;

#13. For each vehicle type, compute the average booking value per kilometer for successful rides.
Create View Avg_booking_value_per_km_successful_rides As
SELECT Vehicle_Type,
       AVG(Booking_Value / NULLIF(Ride_Distance, 0)) AS Avg_Value_Per_KM
FROM Bookings
WHERE Booking_Status = 'Success'
GROUP BY Vehicle_Type;

#1. Retrieve all successful bookings:
Select * From Successful_Bookings;

#2. Find the average ride distance for each vehicle type:
Select * from ride_distance_for_each_vehicle;

#3. Get the total number of cancelled rides by customers:
Select * from cancelled_rides_by_customers;

#4. List the top 5 customers who booked the highest number of rides:
Select * from Top_5_Customers;

#5. Get the number of rides cancelled by drivers due to personal and car-related issues:
Select * from Rides_cancelled_by_Drivers_P_C_Issues;

#6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
Select * from Max_Min_Driver_Rating;

#7. Retrieve all rides where payment was made using UPI:
Select * from UPI_Payment;

#8. Find the average customer rating per vehicle type:
Select * from AVG_Cust_Rating;

#9. Calculate the total booking value of rides completed successfully:
Select * from total_successful_ride_value;

#10. List all incomplete rides along with the reason:
Select * from Incomplete_Rides_Reason;

#11. Find the percentage of rides canceled due to "Personal & Car related issues" for each vehicle type.
Select * from Percentage_ride_canceled; 

#12. Calculate the total booking value for each payment method and rank them by popularity.
Select * from total_booking_value_by_each_payment_method;

#13. For each vehicle type, compute the average booking value per kilometer for successful rides.
Select * from Avg_booking_value_per_km_successful_rides;