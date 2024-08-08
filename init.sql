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
    created_at DATETIME NOT NULL,
    image_data LONGBLOB NOT NULL,
    user_id INT NOT NULL,
    prompt_id INT,
    INDEX (id),
    CONSTRAINT fk_result_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_result_prompt FOREIGN KEY (prompt_id) REFERENCES prompts(id) ON DELETE SET NULL
);

-- Create collections table
CREATE TABLE collections (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    INDEX (id),
    CONSTRAINT fk_collection_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Create collection_results table
CREATE TABLE collection_result (
    collection_id INT NOT NULL,
    result_id INT NOT NULL,
    PRIMARY KEY (collection_id, result_id),
    CONSTRAINT fk_collection FOREIGN KEY (collection_id) REFERENCES collections(id) ON DELETE CASCADE,
    CONSTRAINT fk_result FOREIGN KEY (result_id) REFERENCES results(id)
);