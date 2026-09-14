-- Recode pet-safe / child-safe free text the way SkillBuilder 2
-- teaches: ILIKE with several phrases, not one substring.
-- Compare against the already-coded reason_for_purchase column.

SELECT
    reason_for_purchase_free_response,
    reason_for_purchase
FROM terracotta.survey
WHERE reason_for_purchase_free_response ILIKE '%pet%'
   OR reason_for_purchase_free_response ILIKE '%dog%'
   OR reason_for_purchase_free_response ILIKE '%cat%'
   OR reason_for_purchase_free_response ILIKE '%toddler%'
   OR reason_for_purchase_free_response ILIKE '%child%'
   OR reason_for_purchase_free_response ILIKE '%kid%'
   OR reason_for_purchase_free_response ILIKE '%toxic%'
   OR reason_for_purchase_free_response ILIKE '%non-toxic%'
   OR reason_for_purchase_free_response ILIKE '%safe%';
