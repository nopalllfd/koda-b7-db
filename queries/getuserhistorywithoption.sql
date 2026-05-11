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