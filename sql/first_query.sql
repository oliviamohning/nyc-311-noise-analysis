SELECT
  noise_complaints.descriptor,
  noise_complaints.created_date,
  noise_complaints.borough,
  complaint_codes.severity_level
FROM noise_complaints
LEFT JOIN complaint_codes
  ON noise_complaints.descriptor = complaint_codes.descriptor
LIMIT 20;
