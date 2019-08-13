CREATE TABLE db_users (id INTEGER PRIMARY KEY AUTOINCREMENT, username STRING NOT NULL UNIQUE, email STRING NOT NULL, password STRING NOT NULL, create_ts DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL, update_ts DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL);