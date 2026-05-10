SELECT
    t.type,
    t.total,
    t.method_id,
    t.reference_code,
    t.status,
    t.created_at
FROM transactions t
JOIN wallets w
    ON t.receiver_wallet_id = w.id
WHERE w.user_id = 2
AND t.type = 'transfer'
AND t.created_at BETWEEN '2026-03-01'
AND '2026-05-11'
ORDER BY t.created_at DESC;

-- Expense
SELECT
    t.type,
    t.total,
    t.method_id,
    t.reference_code,
    t.status,
    t.created_at
FROM transactions t
JOIN wallets w
    ON t.sender_wallet_id = w.id
WHERE w.user_id = 1
AND t.type = 'transfer'
AND t.created_at BETWEEN '2026-05-01'
AND '2026-05-11'
ORDER BY t.created_at DESC;