SELECT Count(a.student_id) AS stu_count,
       a.primary_level_class_id,
       c.college_id,
       CASE
           WHEN date_part('year', age(b.birth_date))::int >= '18'
               AND date_part('year', age(b.birth_date))::int < '24' THEN '18_to_23'
           WHEN date_part('year', age(b.birth_date))::int >= '24'
              AND date_part('year', age(b.birth_date))::int < '30' THEN '24_to_29'
           WHEN date_part('year', age(b.birth_date))::int >= '30' THEN '30_and_above'
           END AS age_band
       FROM export.student_term_level a
       LEFT JOIN export.student b
              ON a.student_id = b.student_id
       LEFT JOIN export.academic_programs c
              ON c.program_id = a.primary_program_id
       WHERE a.term_id = '202320'
             AND a.is_enrolled =  TRUE
             AND a.is_primary_level = TRUE
             AND a.student_type_code != 'H' -- exclude HS students
             AND a.is_degree_seeking = TRUE -- only Degree Seeking students
             AND date_part('year', age(b.birth_date))::int >= '18' -- exclude 18 year olds from survey samples
             AND b.confidential_status_code != 'Y'
group by a.primary_level_class_id,
       c.college_id,
       CASE
           WHEN date_part('year', age(b.birth_date))::int >= '18'
               AND date_part('year', age(b.birth_date))::int < '24' THEN '18_to_23'
           WHEN date_part('year', age(b.birth_date))::int >= '24'
              AND date_part('year', age(b.birth_date))::int < '30' THEN '24_to_29'
           WHEN date_part('year', age(b.birth_date))::int >= '30' THEN '30_and_above'
           END;