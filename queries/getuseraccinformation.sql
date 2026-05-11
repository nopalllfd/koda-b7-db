SELECT 
    w.balance,

    (
        SELECT SUM(t.amount)
        FROM transactions t
        WHERE t.receiver_wallet_id = w.id
        AND t.status = 'success'
    ) AS income,

    (
        SELECT SUM(t.amount)
        FROM transactions t
        WHERE t.sender_wallet_id = w.id
        AND t.status = 'success'
    ) AS expense

FROM wallets w
WHERE w.user_id = 1;