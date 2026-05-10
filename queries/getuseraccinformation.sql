SELECT 
    w.balance,

    (
        SELECT COALESCE(SUM(t.amount), 0)
        FROM transactions t
        WHERE t.receiver_wallet_id = w.id
        AND t.status = 'success'
    ) AS income,

    (
        SELECT COALESCE(SUM(t.amount), 0)
        FROM transactions t
        WHERE t.sender_wallet_id = w.id
        AND t.status = 'success'
    ) AS expense

FROM wallets w
WHERE w.user_id = 1;