-- Keep every order, including guests with no account.
-- LEFT JOIN from orders is the grain. An inner join would make
-- registered customers look like the whole business.

SELECT *
FROM fastkitchen.orders
LEFT JOIN fastkitchen.users
    ON orders.user_id = users.user_id;
