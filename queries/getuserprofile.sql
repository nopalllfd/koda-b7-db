SELECT
    p.photo,
    p.full_name,
    p.phone,
    u.email
FROM users u
JOIN profiles p
    ON p.user_id = u.id
WHERE u.id = 6;