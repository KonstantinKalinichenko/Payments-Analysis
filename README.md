# Payments-Analysis

A project to analyze payments on a fictitious streaming platform using SQL.
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

**fact_gifts**: Contain the information about all gifts which were sent in Streamora, such as sender id (gifter),
recipient id (creator), timestamp of gift, coins spent (by gifter), diamonds earned (by creator).

**fact_purchases**: Contains the information about all successful purchasers of gifters such as purchase id,
account id (gifter), country of purchaser (gifter), timestamp of purchase, usd amount, coins amount.

**dim_user_country**: Contains the information about the user (both creators and gifters) and their country:
account_id and country.

<img width="742" height="395" alt="schema" src="https://github.com/user-attachments/assets/a6945cea-9273-4873-9af9-ece00847e66c" />

