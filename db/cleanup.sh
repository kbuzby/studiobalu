#!/bin/bash
sqlite3 <PUT_FILE_HERE> "DELETE FROM orders WHERE (datetime(orders.updated_at, '+1 day') < datetime('now') AND status is not 'ordered');"
sqlite3 <PUT_FILE_HERE> "UPDATE products SET order_id = null WHERE NOT EXISTS (SELECT * FROM orders WHERE products.order_id == orders.id);"
