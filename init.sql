-- google test
DROP DATABASE IF EXISTS google_database;
CREATE DATABASE google_database;

-- Drop and recreate the database
DROP DATABASE IF EXISTS ohmyservice_database;
CREATE DATABASE ohmyservice_database;
USE ohmyservice_database;

-- Create users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    hashed_password VARCHAR(255) NOT NULL,
    INDEX (id)
);

-- Create prompts table
CREATE TABLE prompts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    created_at DATETIME NOT NULL,
    content VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    INDEX (id),
    CONSTRAINT fk_prompt_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Create results table
CREATE TABLE results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    prompt_id INT NOT NULL,
    user_id INT NOT NULL,
    image_data LONGBLOB NOT NULL,
    created_at DATETIME NOT NULL,
    INDEX (id),
    CONSTRAINT fk_result_prompt FOREIGN KEY (prompt_id) REFERENCES prompts(id),
    CONSTRAINT fk_result_user FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Create collections table
CREATE TABLE collections (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    collection_name VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL,
    INDEX (id),
    CONSTRAINT fk_collection_user FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Create collection_results table
CREATE TABLE collection_results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    collection_id INT NOT NULL,
    result_id INT NOT NULL,
    INDEX (id),
    CONSTRAINT fk_collection_result_collection FOREIGN KEY (collection_id) REFERENCES collections(id),
    CONSTRAINT fk_collection_result_result FOREIGN KEY (result_id) REFERENCES results(id)
);