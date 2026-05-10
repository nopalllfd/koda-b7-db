SELECT
    p.full_name,
    p.phone,
    u.email
FROM users u
JOIN profiles p
    ON p.user_id = u.id
WHERE (
    p.full_name ILIKE '%nopl%' 
    OR p.phone ILIKE '%0232%'
)
AND u.id != 1
LIMIT 10 OFFSET 0;
