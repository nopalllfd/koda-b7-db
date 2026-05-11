INSERT INTO transactions (
    sender_wallet_id,
    receiver_wallet_id,
    type,
    amount,
    tax_amount,
    admin_fee,
    discount_amount,
    total,
    method_id,
    reference_code,
    status,
    description,
    created_at
) VALUES (
    2,
    1,
    'transfer',
    100000,
    1000,
    2500,
    0,
    103500,
    1,
    'TRX-0003',
    'pending',
    'Transfer via BRI',
    NOW()
);

-- Update transaction status
UPDATE transactions
SET status = 'success'
WHERE id = 1
AND status = 'pending';

-- Deduct sender balance
UPDATE wallets
SET balance = balance - 103500
WHERE id = 2;

-- Add receiver balance
UPDATE wallets
SET balance = balance + 100000
WHERE id = 1;