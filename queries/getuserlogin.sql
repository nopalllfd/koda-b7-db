SELECT
    p.full_name,
    u.email,
    p.photo
FROM users u
JOIN profiles p ON p.user_id = u.id
WHERE u.id = 1;