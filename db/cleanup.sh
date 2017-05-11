#!/bin/bash
sqlite3 <PUT_FILE_HERE> "DELETE FROM orders WHERE date(orders.updated_at, '+1 day') < date('now');"
sqlite3 <PUT_FILE_HERE> "UPDATE products SET order_id = null WHERE NOT EXISTS (SELECT * FROM orders WHERE products.order_id == orders.id);"
