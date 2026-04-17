-- MySQL Workbench Forward Engineering
SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS,
    UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS,
    FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE,
    SQL_MODE = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema moltbook_observatory
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema moltbook_observatory
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `moltbook_observatory` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `moltbook_observatory`;
-- -----------------------------------------------------
-- Table `moltbook_observatory`.`agents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moltbook_observatory`.`agents` (
    `id` VARCHAR(255) NOT NULL,
    `name` MEDIUMTEXT NULL DEFAULT NULL,
    `description` MEDIUMTEXT NULL DEFAULT NULL,
    `karma` DOUBLE NULL DEFAULT NULL,
    `follower_count` BIGINT NULL DEFAULT NULL,
    `following_count` BIGINT NULL DEFAULT NULL,
    `is_claimed` BIGINT NULL DEFAULT NULL,
    `owner_x_handle` MEDIUMTEXT NULL DEFAULT NULL,
    `first_seen_at` MEDIUMTEXT NULL DEFAULT NULL,
    `last_seen_at` MEDIUMTEXT NULL DEFAULT NULL,
    `created_at` MEDIUMTEXT NULL DEFAULT NULL,
    `avatar_url` MEDIUMTEXT NULL DEFAULT NULL,
    `dump_date` MEDIUMTEXT NULL DEFAULT NULL,
    `_sling_loaded_at` INT NULL DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
-- -----------------------------------------------------
-- Table `moltbook_observatory`.`agents_tmp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moltbook_observatory`.`agents_tmp` (
    `id` MEDIUMTEXT NULL DEFAULT NULL,
    `name` MEDIUMTEXT NULL DEFAULT NULL,
    `description` MEDIUMTEXT NULL DEFAULT NULL,
    `karma` DOUBLE NULL DEFAULT NULL,
    `follower_count` BIGINT NULL DEFAULT NULL,
    `following_count` BIGINT NULL DEFAULT NULL,
    `is_claimed` BIGINT NULL DEFAULT NULL,
    `owner_x_handle` MEDIUMTEXT NULL DEFAULT NULL,
    `first_seen_at` DATETIME(6) NULL DEFAULT NULL,
    `last_seen_at` DATETIME(6) NULL DEFAULT NULL,
    `created_at` DATETIME(6) NULL DEFAULT NULL,
    `avatar_url` MEDIUMTEXT NULL DEFAULT NULL,
    `dump_date` MEDIUMTEXT NULL DEFAULT NULL,
    `_sling_loaded_at` INT NULL DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
-- -----------------------------------------------------
-- Table `moltbook_observatory`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moltbook_observatory`.`comments` (
    `id` VARCHAR(255) NOT NULL,
    `post_id` VARCHAR(255) NULL DEFAULT NULL,
    `agent_id` VARCHAR(255) NULL DEFAULT NULL,
    `agent_name` MEDIUMTEXT NULL DEFAULT NULL,
    `parent_id` MEDIUMTEXT NULL DEFAULT NULL,
    `content` MEDIUMTEXT NULL DEFAULT NULL,
    `score` BIGINT NULL DEFAULT NULL,
    `created_at` MEDIUMTEXT NULL DEFAULT NULL,
    `fetched_at` MEDIUMTEXT NULL DEFAULT NULL,
    `dump_date` MEDIUMTEXT NULL DEFAULT NULL,
    `_sling_loaded_at` INT NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_agent_id` (`agent_id` ASC) VISIBLE,
    INDEX `fk_post_id` (`post_id` ASC) VISIBLE,
    CONSTRAINT `fk_agent_id` FOREIGN KEY (`agent_id`) REFERENCES `moltbook_observatory`.`agents` (`id`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
-- -----------------------------------------------------
-- Table `moltbook_observatory`.`comments_tmp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moltbook_observatory`.`comments_tmp` (
    `id` MEDIUMTEXT NULL DEFAULT NULL,
    `post_id` MEDIUMTEXT NULL DEFAULT NULL,
    `agent_id` MEDIUMTEXT NULL DEFAULT NULL,
    `agent_name` MEDIUMTEXT NULL DEFAULT NULL,
    `parent_id` MEDIUMTEXT NULL DEFAULT NULL,
    `content` MEDIUMTEXT NULL DEFAULT NULL,
    `score` BIGINT NULL DEFAULT NULL,
    `created_at` DATETIME(6) NULL DEFAULT NULL,
    `fetched_at` DATETIME(6) NULL DEFAULT NULL,
    `dump_date` MEDIUMTEXT NULL DEFAULT NULL,
    `_sling_loaded_at` INT NULL DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
-- -----------------------------------------------------
-- Table `moltbook_observatory`.`posts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moltbook_observatory`.`posts` (
    `id` MEDIUMTEXT NULL DEFAULT NULL,
    `agent_id` MEDIUMTEXT NULL DEFAULT NULL,
    `agent_name` MEDIUMTEXT NULL DEFAULT NULL,
    `submolt` MEDIUMTEXT NULL DEFAULT NULL,
    `title` MEDIUMTEXT NULL DEFAULT NULL,
    `content` MEDIUMTEXT NULL DEFAULT NULL,
    `url` MEDIUMTEXT NULL DEFAULT NULL,
    `score` BIGINT NULL DEFAULT NULL,
    `comment_count` BIGINT NULL DEFAULT NULL,
    `created_at` DATETIME(6) NULL DEFAULT NULL,
    `fetched_at` DATETIME(6) NULL DEFAULT NULL,
    `is_pinned` BIGINT NULL DEFAULT NULL,
    `dump_date` MEDIUMTEXT NULL DEFAULT NULL,
    `_sling_loaded_at` INT NULL DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
-- -----------------------------------------------------
-- Table `moltbook_observatory`.`posts_tmp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moltbook_observatory`.`posts_tmp` (
    `id` MEDIUMTEXT NULL DEFAULT NULL,
    `agent_id` MEDIUMTEXT NULL DEFAULT NULL,
    `agent_name` MEDIUMTEXT NULL DEFAULT NULL,
    `submolt` MEDIUMTEXT NULL DEFAULT NULL,
    `title` MEDIUMTEXT NULL DEFAULT NULL,
    `content` MEDIUMTEXT NULL DEFAULT NULL,
    `url` MEDIUMTEXT NULL DEFAULT NULL,
    `score` BIGINT NULL DEFAULT NULL,
    `comment_count` BIGINT NULL DEFAULT NULL,
    `created_at` DATETIME(6) NULL DEFAULT NULL,
    `fetched_at` DATETIME(6) NULL DEFAULT NULL,
    `is_pinned` BIGINT NULL DEFAULT NULL,
    `dump_date` MEDIUMTEXT NULL DEFAULT NULL,
    `_sling_loaded_at` INT NULL DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
-- -----------------------------------------------------
-- Table `moltbook_observatory`.`posts_tmp_tmp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moltbook_observatory`.`posts_tmp_tmp` (
    `id` MEDIUMTEXT NULL DEFAULT NULL,
    `agent_id` MEDIUMTEXT NULL DEFAULT NULL,
    `agent_name` MEDIUMTEXT NULL DEFAULT NULL,
    `submolt` MEDIUMTEXT NULL DEFAULT NULL,
    `title` MEDIUMTEXT NULL DEFAULT NULL,
    `content` MEDIUMTEXT NULL DEFAULT NULL,
    `url` MEDIUMTEXT NULL DEFAULT NULL,
    `score` BIGINT NULL DEFAULT NULL,
    `comment_count` BIGINT NULL DEFAULT NULL,
    `created_at` DATETIME(6) NULL DEFAULT NULL,
    `fetched_at` DATETIME(6) NULL DEFAULT NULL,
    `is_pinned` BIGINT NULL DEFAULT NULL,
    `dump_date` MEDIUMTEXT NULL DEFAULT NULL,
    `_sling_loaded_at` INT NULL DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
-- -----------------------------------------------------
-- Table `moltbook_observatory`.`submolts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moltbook_observatory`.`submolts` (
    `name` VARCHAR(255) NOT NULL,
    `display_name` MEDIUMTEXT NULL DEFAULT NULL,
    `description` MEDIUMTEXT NULL DEFAULT NULL,
    `subscriber_count` BIGINT NULL DEFAULT NULL,
    `post_count` BIGINT NULL DEFAULT NULL,
    `created_at` DATETIME(6) NULL DEFAULT NULL,
    `first_seen_at` DATETIME(6) NULL DEFAULT NULL,
    `avatar_url` MEDIUMTEXT NULL DEFAULT NULL,
    `banner_url` MEDIUMTEXT NULL DEFAULT NULL,
    `dump_date` MEDIUMTEXT NULL DEFAULT NULL,
    `_sling_loaded_at` INT NULL DEFAULT NULL,
    PRIMARY KEY (`name`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
-- -----------------------------------------------------
-- Table `moltbook_observatory`.`submolts_tmp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moltbook_observatory`.`submolts_tmp` (
    `name` MEDIUMTEXT NULL DEFAULT NULL,
    `display_name` MEDIUMTEXT NULL DEFAULT NULL,
    `description` MEDIUMTEXT NULL DEFAULT NULL,
    `subscriber_count` BIGINT NULL DEFAULT NULL,
    `post_count` BIGINT NULL DEFAULT NULL,
    `created_at` DATETIME(6) NULL DEFAULT NULL,
    `first_seen_at` DATETIME(6) NULL DEFAULT NULL,
    `avatar_url` MEDIUMTEXT NULL DEFAULT NULL,
    `banner_url` MEDIUMTEXT NULL DEFAULT NULL,
    `dump_date` MEDIUMTEXT NULL DEFAULT NULL,
    `_sling_loaded_at` INT NULL DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;