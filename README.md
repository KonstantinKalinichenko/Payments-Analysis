# Payments-Analysis

**Project Overview**

This project focuses on payment analysis for a fictional streaming platform (Streamora) using SQL.
It models the flow of virtual currency purchases, gift transactions between viewers and streamers, internal balances, and creator payouts, and uses SQL to extract insights and key metrics from the data.

**Streamora** is an online live-streaming platform.
In Streamora broadcasters (a.k.a. Streamers, creators, BCs) make live-streaming and the viewers (a.k.a. Gifters, gift senders) send them gifts.
Viewers purchased in-app currency (coins 🪙) for real money.
Each gift has a price in coins.

**Gift mechanics:**

Once the gift is sent: Streamora deducts coins🪙 (in amount of gift price) from the gifter, the nice animation of the gift is
shown on live-stream, and the broadcaster receives diamonds 💎 - a second type of in-app currency.
The conversion rate from coins to diamonds is x0.7

**Example:** viewer John sends gift Rose🌹(gift price is 1,000 coins🪙) to Andrew. Streamora deducts 1,000 coins🪙
from John, shows nice animation of Rose🌹on Andrew’s live-stream and deposit 1,000*0.7=700 diamonds💎 to
Andrew’s balance.

**Cash-out mechanics:**

The broadcaster can request the cash-out (a.k.a. withdrawal, redeem) of diamonds💎 to his bank account. The
conversion rate from diamonds💎 to USD💲 is x0.005 (divided by 200)

**Example:** Andrew has 25,000 diamonds💎 on his balance. He requested the cash-out of 20,000 diamonds💎(it is
possible to request the cash-out not for all diamonds💎). The total amount of USD💲would be 20,000/200=$100.

**Data Schema and Ǫuality**

**fact_redeems**: Contains the information about successful redeem requests of creators such as redeem id,
redeem request timestamp, creator id, creator registration date, amount in diamonds, amount in usd usd,
country of creator.

Example rows:

| redeem_id | timestamp               | creator_id | registration_date | amount_in_diamonds | amount_in_dollar | country_code |
| --------- | ----------------------- | ---------- | ----------------- | ------------------ | ---------------- | ------------ |
| 8862668   | 2023-06-30 05:25:09 UTC | 3196313945 | 2023-06-19        | 17800              | 89               | VN           |
| 8871850   | 2023-06-30 23:50:42 UTC | 2872999101 | 2022-05-22        | 36400              | 182              | RU           |

**fact_gifts**: Contain the information about all gifts which were sent in Streamora, such as sender id (gifter),
recipient id (creator), timestamp of gift, coins spent (by gifter), diamonds earned (by creator).

Example rows:

| sender_account_id | receipt_account_id | timestamp               | coins_spent | diamonds_earned |
| ----------------- | ------------------ | ----------------------- | ----------- | --------------- |
| 2535498772        | 2738098788         | 2023-05-06 08:57:19 UTC | 1200        | 840             |
| 3083868987        | 3107575159         | 2023-05-06 08:57:05 UTC | 358         | 250             |

**fact_purchases**: Contains the information about all successful purchasers of gifters such as purchase id,
account id (gifter), country of purchaser (gifter), timestamp of purchase, usd amount, coins amount.

Example rows:

| purchase_id | account_id | timestamp               | price_usd | coins_purchased |
| ----------- | ---------- | ----------------------- | --------- | --------------- |
| 45807332    | 2572397152 | 2023-01-10 19:07:19 UTC | 0.99      | 100             |
| 45807250    | 3067879511 | 2023-01-10 19:05:24 UTC | 0.99      | 200             |

**dim_user_country**: Contains the information about the user (both creators and gifters) and their country:
account_id and country.

Example rows:

| account_id | country      |
| ---------- | ------------ |
| 2572397152 | Saudi Arabia |
| 3067879511 | Malaysia     |


**Project Structure:**

Below is an overview of the main directories and files in this repository:

Payments-Analysis/
├── data/
├── results/
├── sql/
├── schema.png
├── tasks.md
└── README.md

**data**:

This directory contains the raw input data used for the payment analysis of a fictional streaming platform called Streamora.

**results:**

The results/ folder stores the outputs of the analysis, such as aggregated tables, query results, reports, or exported data produced as part of the SQL analysis.

**sql:**

This directory contains SQL scripts used to analyze the data.
The scripts typically include queries for data extraction, joins, aggregations, and calculations of business metrics related to payments, revenue, and user behavior.

**schema.png:**

schema.png is a database schema diagram that visualizes the data model.
It shows tables, relationships, and key fields, helping to understand how the data is structured and connected.

**tasks.md:**

The tasks.md file describes the project tasks and analytical goals.
It outlines the business questions to be answered and the objectives of the analysis, providing context for the SQL queries and results.

<img width="742" height="395" alt="schema" src="https://github.com/user-attachments/assets/a6945cea-9273-4873-9af9-ece00847e66c" />

