-- ============================================================================
-- SQL Script to Convert LONGBLOB and BLOB Columns to TEXT
-- ============================================================================
-- Database: MySQL
-- Purpose: Convert all LONGBLOB columns to LONGTEXT and BLOB columns to TEXT
--          for better text handling and character encoding support
-- Date: 2026-05-09
--
-- IMPORTANT: 
-- - Backup your database before running these statements
-- - These operations may lock tables temporarily
-- - Consider running during off-peak hours for large tables
-- ============================================================================

-- View current LONGBLOB and BLOB columns
SELECT 
    TABLE_NAME, 
    COLUMN_NAME, 
    DATA_TYPE, 
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
    AND DATA_TYPE IN ('longblob', 'blob')
ORDER BY TABLE_NAME, COLUMN_NAME;

-- ============================================================================
-- Conversion Statements
-- ============================================================================

-- Table: admit_history
-- Columns: history (blob), differential (blob), final (blob)
ALTER TABLE `admit_history` 
MODIFY COLUMN `history` TEXT;

ALTER TABLE `admit_history` 
MODIFY COLUMN `differential` TEXT;

ALTER TABLE `admit_history` 
MODIFY COLUMN `final` TEXT;

-- Table: global_note
-- Column: note
ALTER TABLE `global_note` 
MODIFY COLUMN `note` LONGTEXT;

-- Table: opd_history
-- Column: content
ALTER TABLE `opd_history` 
MODIFY COLUMN `content` LONGTEXT;

-- Table: opd_notifications
-- Column: content
ALTER TABLE `opd_notifications` 
MODIFY COLUMN `content` LONGTEXT;

-- Table: opd_treatment
-- Column: content
ALTER TABLE `opd_treatment` 
MODIFY COLUMN `content` LONGTEXT;

-- Table: queue_history
-- Columns: more_info, score, comment, content, treatment
ALTER TABLE `queue_history` 
MODIFY COLUMN `more_info` LONGTEXT;

ALTER TABLE `queue_history` 
MODIFY COLUMN `score` LONGTEXT;

ALTER TABLE `queue_history` 
MODIFY COLUMN `comment` LONGTEXT;

ALTER TABLE `queue_history` 
MODIFY COLUMN `content` LONGTEXT;

ALTER TABLE `queue_history` 
MODIFY COLUMN `treatment` LONGTEXT;

-- ============================================================================
-- Verification Queries
-- ============================================================================

-- Verify conversions
SELECT 
    TABLE_NAME, 
    COLUMN_NAME, 
    DATA_TYPE, 
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
    AND COLUMN_NAME IN ('history', 'differential', 'final', 'note', 'content', 'more_info', 'score', 'comment', 'treatment')
    AND TABLE_NAME IN ('admit_history', 'global_note', 'opd_history', 'opd_notifications', 'opd_treatment', 'queue_history')
ORDER BY TABLE_NAME, COLUMN_NAME;

-- Check for any remaining LONGBLOB or BLOB columns
SELECT 
    TABLE_NAME, 
    COLUMN_NAME, 
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
    AND DATA_TYPE IN ('longblob', 'blob');

-- ============================================================================
-- Rollback Statements (if needed)
-- ============================================================================
-- Uncomment and run these if you need to revert the changes

/*
ALTER TABLE `admit_history` MODIFY COLUMN `history` BLOB;
ALTER TABLE `admit_history` MODIFY COLUMN `differential` BLOB;
ALTER TABLE `admit_history` MODIFY COLUMN `final` BLOB;
ALTER TABLE `global_note` MODIFY COLUMN `note` LONGBLOB;
ALTER TABLE `opd_history` MODIFY COLUMN `content` LONGBLOB;
ALTER TABLE `opd_notifications` MODIFY COLUMN `content` LONGBLOB;
ALTER TABLE `opd_treatment` MODIFY COLUMN `content` LONGBLOB;
ALTER TABLE `queue_history` MODIFY COLUMN `more_info` LONGBLOB;
ALTER TABLE `queue_history` MODIFY COLUMN `score` LONGBLOB;
ALTER TABLE `queue_history` MODIFY COLUMN `comment` LONGBLOB;
ALTER TABLE `queue_history` MODIFY COLUMN `content` LONGBLOB;
ALTER TABLE `queue_history` MODIFY COLUMN `treatment` LONGBLOB;
*/
