INSERT INTO users (
    email,
    password
) VALUES (
    'nopal@gmail.com',
    '123456'
);

-- Create profile after register
INSERT INTO profiles (
    user_id
) VALUES (
    1
);

-- Create wallet after register
INSERT INTO wallets (
    user_id
) VALUES (
    1
);
