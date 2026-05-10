SELECT
    u.id,
    u.email,
    u.password,
    p.full_name,
    p.photo,
    w.balance
FROM users u
JOIN profiles p ON p.user_id = u.id
JOIN wallets w ON w.user_id = u.id
WHERE u.email = 'john@example.com';
