# How do you profile a customer base that includes guests?

FastKitchen is a fictional Midwest takeout restaurant. The manager
needed a picture of the customer base: ticket size, order type,
registered vs guest, and spend by zip. Guests never create an
account, so any join that drops `NULL` user_ids would describe the
loyalty program instead of the business.

Two tables: `fastkitchen.orders` and `fastkitchen.users`. The queries
in [`queries/`](queries/) are the ones I wrote. Totals below are what
I recorded from the course SQL app.

## Guests are the larger group

Average ticket is **$22.20**. Carryout gets a bit more in tips than
the other order types.

[`01_avg_ticket.sql`](queries/01_avg_ticket.sql) ·
[`02_by_order_type.sql`](queries/02_by_order_type.sql) ·
[`03_registered_orders.sql`](queries/03_registered_orders.sql) ·
[`04_guest_orders.sql`](queries/04_guest_orders.sql)

**Non-registered customers place more orders** than registered ones.
A likely reason is speed of checkout: order, then leave, without
creating an account. Any conversion program that slows that path
will tax the larger half of volume.

## Allen is the user capital because it has more zips

[`05_users_by_city.sql`](queries/05_users_by_city.sql) ·
[`06_users_by_city_zip.sql`](queries/06_users_by_city_zip.sql)

**Allen** has the most registered users, **212**. Grouping by city
*and* zip shows why: Allen contains more zip areas, not necessarily
denser demand in a single neighborhood. A city ranking without zip
would have overstated one place.

## Finding — a LEFT JOIN is what keeps guests in the picture

```sql
SELECT *
FROM fastkitchen.orders
LEFT JOIN fastkitchen.users
    ON orders.user_id = users.user_id;
```

[`07_left_join_orders.sql`](queries/07_left_join_orders.sql)

The grain is **an order**. Guest tickets have `user_id` NULL. An
inner join would drop them and make registered customers look like
the whole business.

The highest-spending registered user lives in zip **63222**. Average
order value by zip, registered only: **3 zip codes** spend more on
average than non-registered guests.

[`08_top_spender_zip.sql`](queries/08_top_spender_zip.sql) ·
[`09_avg_by_zip.sql`](queries/09_avg_by_zip.sql)

Most registered zips do **not** beat guest ticket size. Registration
is not the high-value segment by default.

## Recommendation

1. **Do not join away the guests.** They are the larger order group
   and most zips do not outspend them.
2. Convert guests without slowing checkout — the thing that makes
   guest volume high is speed.
3. Treat Allen as a **multi-zip market**, not a single neighborhood,
   and treat zip **63222** as a whale, not as the typical registered
   customer.

## Limitations

- FastKitchen is a constructed GCA dataset that emulates a real
  restaurant, not production POS data.
- Guest vs registered counts and the "3 zips above guest average"
  figure were read from query output; I do not have the guest
  average stored as its own recorded number here.
- No menu, item, or promo columns, so this is a customer-base
  profile, not a product mix.

## How I used AI on this project

I wrote the `LEFT JOIN` and guest/registered counts myself. The original
lab asked ChatGPT why guests might order more; speed of checkout is the
reason I kept. Cursor packaged the Google Doc into this folder without
changing those details.

## Skills demonstrated

`LEFT JOIN` from the fact table · `IS NULL` / `IS NOT NULL` as the
guest vs registered split · `GROUP BY` city then city × zip ·
filtering after a join so guests are not treated as a fake user ·
average order value at zip grain

## Data

GCA Querying Data track. Tables: `fastkitchen.orders`,
`fastkitchen.users`. The course SQL app is not public, so this folder
ships the queries and the result totals I recorded rather than a
copy of the warehouse.
