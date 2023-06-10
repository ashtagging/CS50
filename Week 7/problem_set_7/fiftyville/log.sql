-- Keep a log of any SQL queries you execute as you solve the mystery.
--Put this into a sql lite dataabse so queries may not be 100% correct

-- All you know is that the theft took place on July 28, 2021 and that it took place on Humphrey Street.

SELECT * FROM crime_scene_reports

SELECT * FROM crime_scene_reports
 WHERE month = 7
 AND day = 28
 AND street = 'Humphrey Street'

 -- Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery.
 -- Interviews were conducted today with three witnesses who were present at the time – each of their interview transcripts mentions the bakery.

SELECT * FROM interviews

SELECT * FROM interviews
WHERE month = 7
AND day = 28
AND transcript LIKE '%bakery%'

-- Ruth		Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away. If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.
-- Eugene	I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.
-- Raymond	As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight ticket.

-- 1. Car look for cctv within first 10 mins

SELECT * FROM bakery_security_logs

SELECT * FROM bakery_security_logs
WHERE month = 7
AND day = 28
AND hour = 10
AND minute < 25
AND activity = 'exit'
                                    -- Number plates
-- 260	2021	7	28	10	16	exit	5P2BI95
-- 261	2021	7	28	10	18	exit	94KL13X
-- 262	2021	7	28	10	18	exit	6P58WS2
-- 263	2021	7	28	10	19	exit	4328GD8
-- 264	2021	7	28	10	20	exit	G412CB7
-- 265	2021	7	28	10	21	exit	L93JTIZ
-- 266	2021	7	28	10	23	exit	322W7JE
-- 267	2021	7	28	10	23	exit	0NTHK55

-- 2. ATM leggett street thief withdrawing money before theft

SELECT * FROM atm_transactions

SELECT * FROM atm_transactions
WHERE month = 7
AND day = 28
AND atm_location LIKE '%Leggett%'
AND transaction_type = 'withdraw'

    -- account_number
-- 246	28500762	2021	7	28	Leggett Street	withdraw	48
-- 264	28296815	2021	7	28	Leggett Street	withdraw	20
-- 266	76054385	2021	7	28	Leggett Street	withdraw	60
-- 267	49610011	2021	7	28	Leggett Street	withdraw	50
-- 269	16153065	2021	7	28	Leggett Street	withdraw	80
-- 288	25506511	2021	7	28	Leggett Street	withdraw	20
-- 313	81061156	2021	7	28	Leggett Street	withdraw	30
-- 336	26013199	2021	7	28	Leggett Street	withdraw	35

SELECT * FROM bank_accounts

SELECT * FROM bank_accounts
JOIN

-- 3. Talked to someone on the phone for less than a minute earliest flight out of Fiftyville on 29th

SELECT * FROM phone_calls

SELECT * FROM phone_calls
WHERE month = 7
AND day = 28
AND duration < 60

        --caller           reciever

-- 221	(130) 555-0289	(996) 555-8899	2021	7	28	51
-- 224	(499) 555-9472	(892) 555-8872	2021	7	28	36
-- 233	(367) 555-5533	(375) 555-8161	2021	7	28	45
-- 251	(499) 555-9472	(717) 555-1342	2021	7	28	50
-- 254	(286) 555-6063	(676) 555-6554	2021	7	28	43
-- 255	(770) 555-1861	(725) 555-3243	2021	7	28	49
-- 261	(031) 555-6622	(910) 555-3251	2021	7	28	38
-- 279	(826) 555-1652	(066) 555-9701	2021	7	28	55
-- 281	(338) 555-6650	(704) 555-2131	2021	7	28	54

-- Earliest flight out of fiftyville on the 29th

SELECT fl.*, ar1.city as origin_city, ar2.city as destination_city
FROM flights as fl
JOIN airports as ar1 ON fl.origin_airport_id = ar1.id
JOIN airports as ar2 ON fl.destination_airport_id = ar2.id
WHERE fl.month = 7 AND fl.day = 29
ORDER BY fl.hour ASC;

-- 36	8	4	2021	7	29	8	20	Fiftyville	New York City
-- 43	8	1	2021	7	29	9	30	Fiftyville	Chicago
-- 23	8	11	2021	7	29	12	15	Fiftyville	San Francisco
-- 53	8	9	2021	7	29	15	20	Fiftyville	Tokyo
-- 18	8	6	2021	7	29	16	0	Fiftyville	Boston

-- THE Earliest flight is at 8:20 to New York City so that is the destination city

SELECT * FROM people AS p
JOIN atm_transactions AS atm ON ba.account_number = atm.account_number
JOIN bank_accounts AS ba ON p.id = ba.person_id
JOIN bakery_security_logs AS bsl ON p.license_plate = bsl.license_plate
JOIN phone_calls AS pc ON pc.caller = p.phone_number
WHERE bsl.month = 7
AND bsl.day = 28
AND bsl.hour = 10
AND bsl.minute < 25
AND bsl.activity = 'exit'
AND atm.month = 7
AND atm.day = 28
AND atm.atm_location LIKE '%Leggett%'
AND atm.transaction_type = 'withdraw'
AND pc.duration < 60
AND pc.month = 7
AND pc.day = 28

-- 686048	Bruce	(367) 555-5533	5773159633	94KL13X	267	49610011	2021	7	28	Leggett Street	withdraw	50	49610011	686048	2010	261	2021	7	28	10	18	exit	94KL13X	233	(367) 555-5533	(375) 555-8161	2021	7	28	45
-- 514354	Diana	(770) 555-1861	3592750733	322W7JE	336	26013199	2021	7	28	Leggett Street	withdraw	35	26013199	514354	2012	266	2021	7	28	10	23	exit	322W7JE	255	(770) 555-1861	(725) 555-3243	2021	7	28	49

-- Thief is either Bruce or Diana

-- The thief asked the reciever to purchase them the flight ticket and the thief flew to new york city id 4

-- Updated QUERY

SELECT * FROM people AS p
JOIN atm_transactions AS atm ON ba.account_number = atm.account_number
JOIN bank_accounts AS ba ON p.id = ba.person_id
JOIN bakery_security_logs AS bsl ON p.license_plate = bsl.license_plate
JOIN phone_calls AS pc ON pc.caller = p.phone_number
JOIN passengers as pass ON pass.passport_number = p.passport_number
JOIN flights as fl ON fl.id = pass.flight_id
WHERE bsl.month = 7
AND bsl.day = 28
AND bsl.hour = 10
AND bsl.minute < 25
AND bsl.activity = 'exit'
AND atm.month = 7
AND atm.day = 28
AND atm.atm_location LIKE '%Leggett%'
AND atm.transaction_type = 'withdraw'
AND pc.duration < 60
AND pc.month = 7
AND pc.day = 28
AND destination_airport_id = 4

-- 686048	Bruce	(367) 555-5533	5773159633	94KL13X	267	49610011	2021	7	28	Leggett Street	withdraw	50	49610011	686048	2010	261	2021	7	28	10	18	exit	94KL13X	233	(367) 555-5533	(375) 555-8161	2021	7	28	45	36	5773159633	4A	36	8	4	2021	7	29	8	20

-- The thief is BRUCE!! Need to work out accompliss

SELECT * FROM people as p
JOIN phone_calls as pc ON p.phone_number = pc.receiver
WHERE pc.duration < 60
AND pc.month = 7
AND pc.day = 28
AND caller = '(367) 555-5533'

-- 864400	Robin	(375) 555-8161		4V16VO0	233	(367) 555-5533	(375) 555-8161	2021	7	28	45

-- The thiefs accomplice is Robin !



