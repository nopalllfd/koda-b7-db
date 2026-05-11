-- Login
SELECT
    u.id,
    u.password
FROM users u
WHERE u.email = 'nopal@gmail.com';

-- Register
INSERT INTO users (
    email,
    password
) VALUES (
    'nopal@gmail.com',
    '123456'
);

-- Create profile
INSERT INTO profiles (
    user_id
) VALUES (
    1
);

-- Create wallet
INSERT INTO wallets (
    user_id
) VALUES (
    1
);

-- Get user login information
SELECT
    p.full_name,
    u.email,
    p.photo
FROM users u
JOIN profiles p
    ON p.user_id = u.id
WHERE u.id = 1;

-- Get user PIN
SELECT
    pin
FROM users
WHERE id = 1;

-- Get transaction history
SELECT
    t.id,
    t.type,
    t.reference_code,
    t.status,
    t.created_at,

    tf.amount AS transfer_amount,
    tp.amount AS topup_amount,

    sender_profile.full_name AS sender_name,
    receiver_profile.full_name AS receiver_name,

    pm.name AS payment_method

FROM transactions t

LEFT JOIN transfers tf
    ON tf.transaction_id = t.id

LEFT JOIN topups tp
    ON tp.transaction_id = t.id

LEFT JOIN wallets sender_wallet
    ON sender_wallet.id = tf.sender_wallet_id

LEFT JOIN wallets receiver_wallet
    ON receiver_wallet.id = tf.receiver_wallet_id

LEFT JOIN profiles sender_profile
    ON sender_profile.user_id = sender_wallet.user_id

LEFT JOIN profiles receiver_profile
    ON receiver_profile.user_id = receiver_wallet.user_id

LEFT JOIN payment_methods pm
    ON pm.id = tp.method_id

LEFT JOIN wallets topup_wallet
    ON topup_wallet.id = tp.wallet_id

WHERE (
    sender_wallet.user_id = 1
    OR receiver_wallet.user_id = 1
    OR topup_wallet.user_id = 1
)

ORDER BY t.created_at DESC;

-- Get transaction history option
-- Income
SELECT
    w.user_id,
    t.type,
    t.reference_code,
    t.status,
    t.created_at,

    tf.amount,
    tf.total

FROM transactions t

LEFT JOIN transfers tf
    ON tf.transaction_id = t.id
LEFT JOIN topups tp
    ON tp.transaction_id = t.id
JOIN wallets w
    ON w.id = tf.receiver_wallet_id

WHERE w.user_id = 1

AND t.created_at BETWEEN '2026-03-01'
AND '2026-05-14'

ORDER BY t.created_at DESC;


-- Expense
SELECT
    w.user_id,

    t.type,
    t.reference_code,
    t.status,
    t.created_at,

    tf.amount,
    tf.total

FROM transactions t

JOIN transfers tf
    ON tf.transaction_id = t.id

JOIN wallets w
    ON w.id = tf.sender_wallet_id

WHERE w.user_id = 1

AND t.created_at BETWEEN '2026-05-01'
AND '2026-05-14'

ORDER BY t.created_at DESC;

-- Get user account information
SELECT
    w.balance,

    (
        SELECT COALESCE(SUM(tf.amount), 0)

        FROM transfers tf

        JOIN transactions t
            ON t.id = tf.transaction_id

        WHERE tf.receiver_wallet_id = w.id
        AND t.status = 'success'

    ) AS income,

    (
        SELECT COALESCE(SUM(tf.amount), 0)

        FROM transfers tf

        JOIN transactions t
            ON t.id = tf.transaction_id

        WHERE tf.sender_wallet_id = w.id
        AND t.status = 'success'

    ) AS expense

FROM wallets w
WHERE w.user_id = 1;

-- Find receiver with pagination
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

-- Create transfer transaction
INSERT INTO transactions (
    type,
    reference_code,
    status,
    created_at
) VALUES (
    'transfer',
    'TRX-0003',
    'success',
    NOW()
);

-- Create transfer detail
INSERT INTO transfers (
    transaction_id,
    sender_wallet_id,
    receiver_wallet_id,
    amount,
    tax_amount,
    admin_fee,
    discount_amount,
    total,
    description
) VALUES (
    1,
    2,
    1,
    100000,
    1000,
    2500,
    0,
    103500,
    'Transfer via BRI'
);

-- Update transaction status
UPDATE transactions
SET
    status = 'success',
    updated_at = NOW()
WHERE id = 1;

-- Deduct sender balance
UPDATE wallets
SET
    balance = balance - 103500,
    updated_at = NOW()
WHERE id = 2;

-- Add receiver balance
UPDATE wallets
SET
    balance = balance + 100000,
    updated_at = NOW()
WHERE id = 1;

-- Get user profile
SELECT
    p.photo,
    p.full_name,
    p.phone,
    u.email

FROM users u

JOIN profiles p
    ON p.user_id = u.id

WHERE u.id = 6;

-- Change pin
UPDATE users
SET
    pin = '1111',
    updated_at = NOW()
WHERE id = 6;

-- Change password
UPDATE users
SET
    password = '',
    updated_at = NOW()
WHERE id = 3;

-- Change user profile
UPDATE profiles
SET
    full_name = 'nopal',
    phone = '213123',
    photo = 'ppp'
WHERE user_id = 6;