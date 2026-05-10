UPDATE users
SET
    password = '',
    updated_at = NOW()
WHERE id = 3;