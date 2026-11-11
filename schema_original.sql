CREATE TABLE "user"(
    "id" INTEGER NOT NULL,
    "full_name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone_number" TEXT NOT NULL,
    "role" TEXT NOT NULL,
    "address" TEXT NULL,
    "password_hash" BIGINT NOT NULL
);
ALTER TABLE
    "user" ADD PRIMARY KEY("id");
CREATE TABLE "restaurants"(
    "id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "pincode" INTEGER NOT NULL,
    "status" INTEGER NOT NULL,
    "phone_number" INTEGER NULL
);
ALTER TABLE
    "restaurants" ADD PRIMARY KEY("id");
CREATE TABLE "menu_Items"(
    "id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "price" INTEGER NOT NULL,
    "availability" BOOLEAN NOT NULL,
    "restaurants_id" INTEGER NOT NULL,
    "description" TEXT NULL,
    "category" TEXT NOT NULL
);
ALTER TABLE
    "menu_Items" ADD PRIMARY KEY("id");
CREATE TABLE "orders"(
    "id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "restaurant_id" INTEGER NOT NULL,
    "status" TEXT NOT NULL,
    "payment_method" TEXT NOT NULL,
    "total_amount" INTEGER NOT NULL,
    "delivery_fees" INTEGER NOT NULL
);
ALTER TABLE
    "orders" ADD PRIMARY KEY("id");
CREATE TABLE "order_items"(
    "id" INTEGER NOT NULL,
    "order_id" INTEGER NOT NULL,
    "quantity" INTEGER NOT NULL,
    "menu_id" INTEGER NOT NULL,
    "price" INTEGER NOT NULL
);
ALTER TABLE
    "order_items" ADD PRIMARY KEY("id");
CREATE TABLE "delivery_assignment"(
    "id" INTEGER NOT NULL,
    "order_id" INTEGER NOT NULL,
    "agent_id" INTEGER NOT NULL,
    "status" TEXT NOT NULL,
    "assigned_at" TEXT NOT NULL,
    "pickup_at" TEXT NOT NULL,
    "delivered_at" TEXT NOT NULL
);
ALTER TABLE
    "delivery_assignment" ADD PRIMARY KEY("id");
CREATE TABLE "reviews"(
    "id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "agent_id" INTEGER NULL,
    "restaurant_id" INTEGER NULL,
    "rating" INTEGER NOT NULL,
    "comment" TEXT NOT NULL
);
ALTER TABLE
    "reviews" ADD PRIMARY KEY("id");
ALTER TABLE
    "delivery_assignment" ADD CONSTRAINT "delivery_assignment_id_foreign" FOREIGN KEY("id") REFERENCES "reviews"("agent_id");
ALTER TABLE
    "delivery_assignment" ADD CONSTRAINT "delivery_assignment_agent_id_foreign" FOREIGN KEY("agent_id") REFERENCES "user"("id");
ALTER TABLE
    "orders" ADD CONSTRAINT "orders_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "user"("id");
ALTER TABLE
    "orders" ADD CONSTRAINT "orders_restaurant_id_foreign" FOREIGN KEY("restaurant_id") REFERENCES "restaurants"("id");
ALTER TABLE
    "order_items" ADD CONSTRAINT "order_items_menu_id_foreign" FOREIGN KEY("menu_id") REFERENCES "menu_Items"("id");
ALTER TABLE
    "order_items" ADD CONSTRAINT "order_items_order_id_foreign" FOREIGN KEY("order_id") REFERENCES "orders"("id");
ALTER TABLE
    "restaurants" ADD CONSTRAINT "restaurants_id_foreign" FOREIGN KEY("id") REFERENCES "reviews"("restaurant_id");
ALTER TABLE
    "user" ADD CONSTRAINT "user_id_foreign" FOREIGN KEY("id") REFERENCES "reviews"("user_id");
ALTER TABLE
    "delivery_assignment" ADD CONSTRAINT "delivery_assignment_order_id_foreign" FOREIGN KEY("order_id") REFERENCES "orders"("id");
ALTER TABLE
    "menu_Items" ADD CONSTRAINT "menu_items_restaurants_id_foreign" FOREIGN KEY("restaurants_id") REFERENCES "restaurants"("id");
