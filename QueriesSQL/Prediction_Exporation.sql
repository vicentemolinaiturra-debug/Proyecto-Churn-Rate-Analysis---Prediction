SELECT 
    c."Customer ID",
    c."gender",
    c."contract",
    c."Monthly Charge",
    ROUND(CAST(p."Churn_Risk_Probability" * 100 AS numeric), 2) AS "Risk_Percentage",
    p."Churn_Prediction_Flag"
FROM vw_joindata c
JOIN fact_churn_predictions p 
  ON c."Customer ID" = p."Customer ID"
ORDER BY p."Churn_Risk_Probability" DESC;