## ERD

![erd ewallet](ewallet-erd.png)

```sql
Table users {
  id int [pk, increment]

  email varchar(100) [not null, unique]
  password varchar(255) [not null]
  pin varchar(255)

  created_at timestamp [default: `now()`]
  updated_at timestamp
}

Table profiles {
  user_id int [not null, unique]

  full_name varchar(100)
  photo varchar(255)
  phone varchar(20) [unique]
}

Table wallets {
  id int [pk, increment]

  user_id int [not null, unique]

  balance numeric(15,2) [default: 0]

  created_at timestamp [default: `now()`]
  updated_at timestamp
}

Table payment_methods {
  id int [pk, increment]

  name varchar(50) [not null, unique]
  logo varchar(255) [not null]

  created_at timestamp [default: `now()`]
}

Table transactions {
  id int [pk, increment]

  sender_wallet_id int
  receiver_wallet_id int

  type varchar(20) [not null]

  amount numeric(15,2) [not null]
  tax_amount numeric(15,2) [default: 0]
  admin_fee numeric(15,2) [default: 0]
  discount_amount numeric(15,2) [default: 0]

  total numeric(15,2) [not null]

  method_id int

  reference_code varchar(50) [not null, unique]

  status varchar(20) [default: 'pending']

  description text

  created_at timestamp [default: `now()`]
  updated_at timestamp
}

Ref: profiles.user_id - users.id
Ref: wallets.user_id - users.id

Ref: transactions.sender_wallet_id > wallets.id
Ref: transactions.receiver_wallet_id > wallets.id

Ref: transactions.method_id > payment_methods.id
```
