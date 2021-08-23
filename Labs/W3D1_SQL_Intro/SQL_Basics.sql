-- Query 1
SELECT client_id FROM client WHERE district_id = 1 LIMIT 5;

-- Query 2
SELECT client_id FROM client WHERE district_id = 72 ORDER BY client_id DESC LIMIT 1;

-- Query 3
SELECT amount FROM loan ORDER BY amount ASC LIMIT 3;

-- Query 4
SELECT distinct status FROM loan ORDER BY status;

-- Query 5
SELECT loan_id FROM loan ORDER BY payments DESC LIMIT 1;

-- Query 6
SELECT account_id, amount FROM loan ORDER BY account_id ASC LIMIT 5;

-- Query 7
SELECT account_id FROM loan WHERE duration = 60 ORDER BY amount ASC LIMIT 5;

-- Query 8
SELECT distinct k_symbol FROM `order` ORDER BY k_symbol;

-- Query 9
SELECT order_id FROM `order` WHERE account_id = 34;

-- Query 10
SELECT distinct account_id FROM `order` WHERE order_id >= 29540 and order_id <= 29560;
-- or
select distinct account_id from bank.order where order_id between 29540 and 29560;

-- Query 11
SELECT distinct amount FROM bank.order WHERE account_to = 30067122;

-- Query 12
SELECT trans_id, date, type, amount FROM trans WHERE account_id = 793 ORDER BY date DESC LIMIT 10;

-- Query 13
SELECT district_id, count(distinct client_id) FROM client WHERE district_id < 10 GROUP BY district_id ORDER BY district_id;

-- Query 14
SELECT distinct type, count(card_id) AS occurence FROM card GROUP BY type ORDER BY occurence DESC;

-- Query 15
SELECT distinct account_id, sum(amount) AS loan_amount FROM loan GROUP BY account_id ORDER BY loan_amount DESC LIMIT 10;

-- Query 16
SELECT date, count(loan_id) FROM loan WHERE date < 930907 GROUP BY date ORDER BY date DESC LIMIT 5;

-- Query 17
SELECT date, duration, count(distinct loan_id) FROM loan WHERE date LIKE "9712%" GROUP BY date, duration ORDER BY date;

-- Query 18
SELECT account_id, type, sum(amount) as total_amount FROM trans WHERE account_id = 396 GROUP BY type ORDER BY type;

-- Query 19
SELECT account_id, if(type="PRIJEM", "INCOMING", "OUTGOING") as transaction_type, floor(sum(amount)) as total_amount FROM trans WHERE account_id = 396 GROUP BY type ORDER BY type;

-- Query 20
SELECT account_id,
sum(case when transaction_type = "INCOMING" THEN total_amount END) as incoming,
sum(case when transaction_type = "OUTGOING" THEN total_amount END) as outgoing,
(sum(case when transaction_type = "INCOMING" THEN total_amount END) - sum(case when transaction_type = "OUTGOING" THEN total_amount END)) as balance
FROM
	(SELECT account_id, if(type="PRIJEM", "INCOMING", "OUTGOING") as transaction_type, floor(sum(amount)) as total_amount FROM trans WHERE account_id = 396 GROUP BY type ORDER BY type) as table_b
GROUP BY account_id;

-- Query 21
SELECT account_id,
(sum(case when transaction_type = "INCOMING" THEN total_amount END) - sum(case when transaction_type = "OUTGOING" THEN total_amount END)) as balance
FROM
	(SELECT account_id, if(type="PRIJEM", "INCOMING", "OUTGOING") as transaction_type, floor(sum(amount)) as total_amount FROM trans GROUP BY account_id, type ORDER BY type) as table_b
GROUP BY account_id
ORDER BY account_id DESC
LIMIT 10;