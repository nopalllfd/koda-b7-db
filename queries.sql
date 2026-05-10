-- Login
SELECT
    id,
    email,
    password,
    full_name,
    photo,
    balance
FROM users
WHERE email = 'john@example.com';

SELECT
    id,
    email,
    full_name,
    photo,
    balance
FROM users
WHERE email = '' AND password = '';

-- Register
INSERT INTO users (email, password) VALUES ('nopal@gmail.com', '123456');

-- Get user login information(username, email, photo)
SELECT
  full_name,
  email,
  photo
FROM users
WHERE id = 1;

-- Get user PIN
SELECT pin FROM users
WHERE id = 1;

-- Get transaction history
SELECT 
t.type, 
t.total, 
t.reference_code, 
t.status,
t.created_at,

sender.full_name AS sender_name, 
receiver.full_name AS receiver_name

FROM transactions t
JOIN users sender ON t.sender_id = sender.id
JOIN users receiver ON t.receiver_id = receiver.id

WHERE (
  t.sender_id = 1 
OR t.receiver_id = 1
) 
-- AND t.type = 'transfer'

ORDER BY t.created_at DESC;

-- Get user history with option(income/expense, date range)
-- Income
SELECT type, total, method_id, reference_code, status
FROM transactions
WHERE receiver_id = 2
AND created_at BETWEEN '2026-03-01'
AND '2026-05-11'
ORDER BY created_at DESC;

-- Expense
SELECT type, total, method_id, reference_code, status, created_at
FROM transactions
WHERE sender_id = 1
AND type = 'transfer'
AND created_at BETWEEN '2026-05-01'
AND '2026-05-11'
ORDER BY created_at DESC;

-- Get user account information (balance, income, expense)
SELECT 
u.balance,

(
  SELECT COALESCE(SUM(amount), 0)
  FROM transactions
  WHERE receiver_id = 1
  AND status = 'success'
) AS income,

(
  SELECT COALESCE(SUM(amount), 0)
  FROM transactions
  WHERE sender_id = 1
  AND status = 'success'
) AS expense

FROM users u
WHERE id = 1;

-- Find receiver with pagination
SELECT full_name, phone, email
FROM users
WHERE (
  full_name ILIKE '%nopl%' 
  OR phone ILIKE '%0232%'
)
AND id != 1
LIMIT 10 OFFSET 0;

-- Create trx/topup
INSERT INTO transactions (
  sender_id,
  receiver_id,
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
  'success',
  'Transfer via BRI',
  NOW()
);

UPDATE transactions
SET status = 'success';

UPDATE users
SET balance = balance - 103500
WHERE id = 2;

UPDATE users
SET balance = balance + 40000
WHERE id = 1;

-- Get user profile
SELECT photo, full_name, phone, email
FROM users
WHERE id = 6;

-- Change pin
UPDATE users
SET pin = '1111', updated_at = NOW()
WHERE id = 6;

-- Change password
UPDATE users
SET password = '', updated_at = NOW()
WHERE id = 3;

-- Change user profile
UPDATE users
SET full_name = 'nopal', phone = '213123', photo = 'ppp', updated_at = NOW()
WHERE id = 6;