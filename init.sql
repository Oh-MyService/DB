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
    email VARCHAR(255) NOT NULL UNIQUE,
    reset_token VARCHAR(255) NULL, -- 비밀번호 재설정 토큰 추가
    reset_token_expires DATETIME NULL, -- 토큰 만료 시간 추가
    INDEX (id)
);

-- Create prompts table
CREATE TABLE prompts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    created_at DATETIME NOT NULL,
    content JSON NOT NULL,
    ai_option JSON NULL,
    task_id VARCHAR(255) NULL,
    status VARCHAR(50) NULL,
    user_id INT NOT NULL,
    INDEX (id),
    CONSTRAINT fk_prompt_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Create results table
CREATE TABLE results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    created_at DATETIME NOT NULL,
    image_data VARCHAR(500) NOT NULL,
    user_id INT NOT NULL,
    prompt_id INT NOT NULL,
    INDEX (id),
    CONSTRAINT fk_result_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_result_prompt FOREIGN KEY (prompt_id) REFERENCES prompts(id) ON DELETE CASCADE
);

-- Create collections table
CREATE TABLE collections (
    collection_id INT AUTO_INCREMENT PRIMARY KEY,
    created_at DATETIME NULL,
    user_id INT NULL,
    collection_name VARCHAR(255) NULL,
    INDEX (collection_id),
    CONSTRAINT fk_collection_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Create collection_results table
CREATE TABLE collection_results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    collection_id INT NULL,
    result_id INT NULL,
    INDEX (id),
    CONSTRAINT fk_collection FOREIGN KEY (collection_id) REFERENCES collections(collection_id) ON DELETE CASCADE,
    CONSTRAINT fk_result FOREIGN KEY (result_id) REFERENCES results(id) ON DELETE SET NULL
);
