-- Schema built from the ER diagram (3NF): customers, orders, products, order_items.
-- Tables only, without data.

CREATE DATABASE IF NOT EXISTS goit_rdb_hw02
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE goit_rdb_hw02;

CREATE TABLE customers (
    customer_id   INT UNSIGNED NOT NULL AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    address       VARCHAR(255) NOT NULL,
    PRIMARY KEY (customer_id)
);

CREATE TABLE products (
    product_id   INT UNSIGNED NOT NULL AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (product_id),
    UNIQUE KEY uq_products_product_name (product_name)
);

CREATE TABLE orders (
    order_id    INT UNSIGNED NOT NULL AUTO_INCREMENT,
    order_date  DATE         NOT NULL,
    customer_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (order_id),
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE order_items (
    order_id   INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    quantity   INT UNSIGNED NOT NULL,
    PRIMARY KEY (order_id, product_id),
    CONSTRAINT fk_order_items_order
        FOREIGN KEY (order_id) REFERENCES orders (order_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_order_items_product
        FOREIGN KEY (product_id) REFERENCES products (product_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_order_items_quantity CHECK (quantity > 0)
);
