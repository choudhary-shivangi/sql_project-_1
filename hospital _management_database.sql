SELECT * FROM doctors;
SELECT * FROM patients;
SELECT * FROM appointments;
SELECT * FROM admissions;

-- total patients
SELECT COUNT(*) AS total_patients
FROM patients;

-- total doctors
SELECT COUNT(*) AS total_doctors
FROM doctors;

--total completed appointments
SELECT COUNT(*) AS completed_appointments
FROM appointments
WHERE status = 'Completed';

--total cancelled appointment
SELECT COUNT(*) AS cancelled_appointments
FROM appointments
WHERE status = 'Cancelled';

--average consultation fee
SELECT AVG(consultation_fee) AS avg_consultation_fee
FROM appointments;

--average treatment cost
SELECT AVG(treatment_cost) AS avg_treatment_cost
FROM admissions;

--doctor wise appintment required
SELECT d.doctor_name,
  COUNT(a.appointment_id)AS appointment_count
FROM doctors d
JOIN appointments a
ON d. doctor_id = a.doctor_id
GROUP BY d. doctor_name
ORDER BY appointment_count DESC;

--department wise revenue
SELECT d.department,
  SUM(CASE
	WHEN a.status = 'Completed' 
	THEN a.consultation_fee
	ELSE 0
	END
	)AS revenue
FROM doctors d
JOIN appointments a
ON d. doctor_id = a.doctor_id
GROUP BY d.department
ORDER BY revenue DESC;

--most common dignosis
SELECT diagnosis,
  COUNT(*)AS diagnosis_count
FROM admissions
GROUP BY diagnosis
ORDER BY diagnosis_count DESC,diagnosis;

-- length of hospital stay
SELECT AVG(discharge_date-admission_date)
 AS average_stay
 FROM admissions;

 --patient distribution by city
 SELECT city,
  COUNT(*)AS patient_count
FROM patients
GROUP BY city
ORDER BY patient_count DESC;

--patient treatment cost
SELECT patient_id,diagnosis, treatment_cost
FROM admissions
WHERE treatment_cost>(
SELECT AVG(treatment_cost)
FROM admissions
);

--highest treatment _cost
SELECT * FROM admissions
ORDER BY treatment_cost DESC
LIMIT 1;

--highest apointment doctor
SELECT d.doctor_name,
  COUNT(a.appointment_id)AS total_appointments
FROM doctors d
JOIN appointments a
ON d. doctor_id = a.doctor_id
GROUP BY d. doctor_name
ORDER BY total_appointments DESC
LIMIT 1;

--Patient who were admitted
SELECT DISTINCT p.patient_name
FROM patients p
JOIN admissions a 
ON p. patient_id = a.patient_id;

-- Patient who were never admitted
SELECT p.patient_id,p.patient_name
FROM patients p
 LEFT JOIN admissions a 
ON p. patient_id = a.patient_id
WHERE a.patient_id IS NULL;

--appointment completion rate
SELECT
ROUND(100.0*SUM(CASE WHEN status = 'Completed'THEN 1 ELSE 0 END)
/COUNT(*),
2
)AS completion_rate
FROM appointments;

--appointment cancellation rate
SELECT
ROUND(100.0*SUM(CASE WHEN status = 'Cancelled'THEN 1 ELSE 0 END)
/COUNT(*),
2
)AS concellation_rate
FROM appointments;

