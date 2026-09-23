-- Data Exploration – Check Distinct Values
SELECT gender , Count(gender) as TotalCount,
Count(gender) * 1.0 / (Select Count(*) from churn_behavior )  as Percentage
from churn_behavior
Group by gender

SELECT contract, Count(contract) as TotalCount,
Count(contract) * 1.0 / (Select Count(*) from churn_behavior)  as Percentage
from churn_behavior
Group by contract

SELECT "Churn Label", Count("Churn Label") as TotalCount,
Count("Churn Label") * 1.0 / (Select Count(*) from churn_behavior)  as Percentage
from churn_behavior
Group by "Churn Label"

SELECT "Churn Category", Count("Churn Category") as TotalCount,
Count("Churn Category") * 1.0 / (Select Count(*) from churn_behavior)  as Percentage
from churn_behavior
Group by "Churn Category"


SELECT "Customer Status", Count("Customer Status") as TotalCount, Sum("Total Revenue") as TotalRev,
Sum("Total Revenue") / (Select sum("Total Revenue") from churn_behavior) * 100  as RevPercentage
from churn_behavior
Group by "Customer Status"


SELECT city, Count(city) as TotalCount,
Count(city) * 1.0 / (Select Count(*) from churn_behavior)  as Percentage
from churn_behavior
Group by city
Order by Percentage desc


-- Data Exploration – Check Nulls-- 
SELECT 

    SUM(CASE WHEN "Customer ID" IS NULL OR TRIM("Customer ID"::TEXT) = '' THEN 1 ELSE 0 END) AS id_missing,
    SUM(CASE WHEN "gender" IS NULL OR TRIM("gender"::TEXT) = '' THEN 1 ELSE 0 END) AS gender_missing,
    SUM(CASE WHEN "Under 30" IS NULL OR TRIM("Under 30"::TEXT) = '' THEN 1 ELSE 0 END) AS under30_missing,
    SUM(CASE WHEN "Senior Citizen" IS NULL OR TRIM("Senior Citizen"::TEXT) = '' THEN 1 ELSE 0 END) AS senior_missing,
    SUM(CASE WHEN "married" IS NULL OR TRIM("married"::TEXT) = '' THEN 1 ELSE 0 END) AS married_missing,
    SUM(CASE WHEN "dependents" IS NULL OR TRIM("dependents"::TEXT) = '' THEN 1 ELSE 0 END) AS dependents_missing,
    SUM(CASE WHEN "country" IS NULL OR TRIM("country"::TEXT) = '' THEN 1 ELSE 0 END) AS country_missing,
    SUM(CASE WHEN "state" IS NULL OR TRIM("state"::TEXT) = '' THEN 1 ELSE 0 END) AS state_missing,
    SUM(CASE WHEN "city" IS NULL OR TRIM("city"::TEXT) = '' THEN 1 ELSE 0 END) AS city_missing,
    SUM(CASE WHEN "Zip Code" IS NULL OR TRIM("Zip Code"::TEXT) = '' THEN 1 ELSE 0 END) AS zip_missing,
    SUM(CASE WHEN "quarter" IS NULL OR TRIM("quarter"::TEXT) = '' THEN 1 ELSE 0 END) AS quarter_missing,
    SUM(CASE WHEN "Referred a Friend" IS NULL OR TRIM("Referred a Friend"::TEXT) = '' THEN 1 ELSE 0 END) AS referred_missing,
    SUM(CASE WHEN "offer" IS NULL OR TRIM("offer"::TEXT) = '' THEN 1 ELSE 0 END) AS offer_missing,
    SUM(CASE WHEN "Phone Service" IS NULL OR TRIM("Phone Service"::TEXT) = '' THEN 1 ELSE 0 END) AS phone_missing,
    SUM(CASE WHEN "Multiple Lines" IS NULL OR TRIM("Multiple Lines"::TEXT) = '' THEN 1 ELSE 0 END) AS mult_lines_missing,
    SUM(CASE WHEN "Internet Service" IS NULL OR TRIM("Internet Service"::TEXT) = '' THEN 1 ELSE 0 END) AS int_service_missing,
    SUM(CASE WHEN "Internet Type" IS NULL OR TRIM("Internet Type"::TEXT) = '' THEN 1 ELSE 0 END) AS int_type_missing,
    SUM(CASE WHEN "Online Security" IS NULL OR TRIM("Online Security"::TEXT) = '' THEN 1 ELSE 0 END) AS sec_missing,
    SUM(CASE WHEN "Online Backup" IS NULL OR TRIM("Online Backup"::TEXT) = '' THEN 1 ELSE 0 END) AS backup_missing,
    SUM(CASE WHEN "Device Protection Plan" IS NULL OR TRIM("Device Protection Plan"::TEXT) = '' THEN 1 ELSE 0 END) AS dev_prot_missing,
    SUM(CASE WHEN "Premium Tech Support" IS NULL OR TRIM("Premium Tech Support"::TEXT) = '' THEN 1 ELSE 0 END) AS tech_supp_missing,
    SUM(CASE WHEN "Streaming TV" IS NULL OR TRIM("Streaming TV"::TEXT) = '' THEN 1 ELSE 0 END) AS stream_tv_missing,
    SUM(CASE WHEN "Streaming Movies" IS NULL OR TRIM("Streaming Movies"::TEXT) = '' THEN 1 ELSE 0 END) AS stream_mov_missing,
    SUM(CASE WHEN "Streaming Music" IS NULL OR TRIM("Streaming Music"::TEXT) = '' THEN 1 ELSE 0 END) AS stream_mus_missing,
    SUM(CASE WHEN "Unlimited Data" IS NULL OR TRIM("Unlimited Data"::TEXT) = '' THEN 1 ELSE 0 END) AS unlim_data_missing,
    SUM(CASE WHEN "contract" IS NULL OR TRIM("contract"::TEXT) = '' THEN 1 ELSE 0 END) AS contract_missing,
    SUM(CASE WHEN "Paperless Billing" IS NULL OR TRIM("Paperless Billing"::TEXT) = '' THEN 1 ELSE 0 END) AS paperless_missing,
    SUM(CASE WHEN "Payment Method" IS NULL OR TRIM("Payment Method"::TEXT) = '' THEN 1 ELSE 0 END) AS payment_missing,
    SUM(CASE WHEN "Customer Status" IS NULL OR TRIM("Customer Status"::TEXT) = '' THEN 1 ELSE 0 END) AS cust_status_missing,
    SUM(CASE WHEN "Churn Label" IS NULL OR TRIM("Churn Label"::TEXT) = '' THEN 1 ELSE 0 END) AS churn_label_missing,
    SUM(CASE WHEN "Churn Category" IS NULL OR TRIM("Churn Category"::TEXT) = '' THEN 1 ELSE 0 END) AS churn_cat_missing,
    SUM(CASE WHEN "Churn Reason" IS NULL OR TRIM("Churn Reason"::TEXT) = '' THEN 1 ELSE 0 END) AS churn_reason_missing,
    SUM(CASE WHEN "age" IS NULL THEN 1 ELSE 0 END) AS age_missing,
    SUM(CASE WHEN "Number of Dependents" IS NULL THEN 1 ELSE 0 END) AS num_dep_missing,
    SUM(CASE WHEN "latitude" IS NULL THEN 1 ELSE 0 END) AS lat_missing,
    SUM(CASE WHEN "longitude" IS NULL THEN 1 ELSE 0 END) AS long_missing,
    SUM(CASE WHEN "population" IS NULL THEN 1 ELSE 0 END) AS pop_missing,
    SUM(CASE WHEN "Number of Referrals" IS NULL THEN 1 ELSE 0 END) AS num_ref_missing,
    SUM(CASE WHEN "Tenure in Months" IS NULL THEN 1 ELSE 0 END) AS tenure_missing,
    SUM(CASE WHEN "Avg Monthly Long Distance Charges" IS NULL THEN 1 ELSE 0 END) AS avg_long_dist_missing,
    SUM(CASE WHEN "Avg Monthly GB Download" IS NULL THEN 1 ELSE 0 END) AS avg_gb_missing,
    SUM(CASE WHEN "Monthly Charge" IS NULL THEN 1 ELSE 0 END) AS monthly_chg_missing,
    SUM(CASE WHEN "Total Charges" IS NULL THEN 1 ELSE 0 END) AS total_chg_missing,
    SUM(CASE WHEN "Total Refunds" IS NULL THEN 1 ELSE 0 END) AS total_ref_missing,
    SUM(CASE WHEN "Total Extra Data Charges" IS NULL THEN 1 ELSE 0 END) AS total_extra_data_missing,
    SUM(CASE WHEN "Total Long Distance Charges" IS NULL THEN 1 ELSE 0 END) AS total_ld_chg_missing,
    SUM(CASE WHEN "Total Revenue" IS NULL THEN 1 ELSE 0 END) AS total_rev_missing,
    SUM(CASE WHEN "Satisfaction Score" IS NULL THEN 1 ELSE 0 END) AS sat_score_missing,
    SUM(CASE WHEN "Churn Score" IS NULL THEN 1 ELSE 0 END) AS churn_score_missing,
    SUM(CASE WHEN "cltv" IS NULL THEN 1 ELSE 0 END) AS cltv_missing
FROM churn_behavior;

-- Update New Data

UPDATE churn_behavior
SET "Churn Category" = 'N/A'
WHERE "Churn Category" IS NULL OR TRIM("Churn Category"::TEXT) = '';

UPDATE churn_behavior
SET "Churn Reason" = 'N/A'
WHERE "Churn Reason" IS NULL OR TRIM("Churn Reason"::TEXT) = '';

-- Create View for Power BI

CREATE VIEW vw_ChurnData as
	SELECT * FROM churn_behavior WHERE "Customer Status" In ('Churned', 'Stayed')


CREATE VIEW vw_JoinData as
	SELECT * FROM churn_behavior WHERE "Customer Status" = 'Joined'
	
-- Define primary key
	
ALTER TABLE churn_behavior ADD PRIMARY KEY ("Customer ID");

