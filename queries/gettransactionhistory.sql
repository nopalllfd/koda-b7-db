SELECT 
    t.type, 
    t.total, 
    t.reference_code, 
    t.status,
    t.created_at,
    sender_wallet.user_id AS sender_id,
    receiver_wallet.user_id AS receiver_id,
    sender_profile.full_name AS sender_name, 
    receiver_profile.full_name AS receiver_name

FROM transactions t

JOIN wallets sender_wallet
    ON t.sender_wallet_id = sender_wallet.id

JOIN wallets receiver_wallet
    ON t.receiver_wallet_id = receiver_wallet.id

JOIN profiles sender_profile
    ON sender_profile.user_id = sender_wallet.user_id

JOIN profiles receiver_profile
    ON receiver_profile.user_id = receiver_wallet.user_id

WHERE (
    sender_wallet.user_id = 1
    OR receiver_wallet.user_id = 1
) 
--AND t.type = 'transfer'

ORDER BY t.created_at DESC;

