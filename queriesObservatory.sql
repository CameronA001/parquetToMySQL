USE moltbook_observatory;

-- ============================================================
-- FOREIGN KEY VIOLATION PRE-CHECKS
-- Run these before inserting from _tmp tables to identify rows
-- that would be silently dropped (INSERT IGNORE) or cause
-- constraint errors if FK checks were enabled.
-- All checks compare _tmp tables against each other so they
-- can be run before any data reaches the permanent tables.
-- ============================================================

-- --- REFERENTIAL INTEGRITY CHECKS (cross-tmp) ---------------

-- ------------------------------------------------------------
-- 1. agent_id values in posts_tmp that do NOT exist in agents_tmp
--    (referential integrity: posts should belong to a known agent)
-- ------------------------------------------------------------
-- SELECT DISTINCT pt.agent_id AS missing_agent_id
-- FROM posts_tmp pt
-- LEFT JOIN agents_tmp at ON at.id = pt.agent_id
-- WHERE pt.agent_id IS NOT NULL
--   AND at.id IS NULL;

-- ------------------------------------------------------------
-- 2. submolt values in posts_tmp that do NOT exist in submolts_tmp
--    (referential integrity: posts should belong to a known submolt)
-- ------------------------------------------------------------
-- SELECT DISTINCT pt.submolt AS missing_submolt
-- FROM posts_tmp pt
-- LEFT JOIN submolts_tmp st ON st.name = pt.submolt
-- WHERE pt.submolt IS NOT NULL
--   AND st.name IS NULL;

-- ------------------------------------------------------------
-- 3. post_id values in comments_tmp that do NOT exist in posts_tmp
--    (would violate FK on comments.post_id → posts.id, if enforced)
-- ------------------------------------------------------------
-- SELECT DISTINCT ct.post_id AS missing_post_id
-- FROM comments_tmp ct
-- LEFT JOIN posts_tmp pt ON pt.id = ct.post_id
-- WHERE ct.post_id IS NOT NULL
--   AND pt.id IS NULL;

-- ------------------------------------------------------------
-- 4. agent_id values in comments_tmp that do NOT exist in agents_tmp
--    (would violate FK on comments.agent_id → agents.id)
-- ------------------------------------------------------------
-- SELECT DISTINCT ct.agent_id AS missing_agent_id
-- FROM comments_tmp ct
-- LEFT JOIN agents_tmp at ON at.id = ct.agent_id
-- WHERE ct.agent_id IS NOT NULL
--   AND at.id IS NULL;

-- --- INTERNAL DUPLICATE CHECKS (within each _tmp table) -----

-- ------------------------------------------------------------
-- 5. Duplicate id values within agents_tmp
--    (duplicates will be collapsed to one row by INSERT IGNORE)
-- ------------------------------------------------------------
-- SELECT id, COUNT(*) AS occurrences
-- FROM agents_tmp
-- GROUP BY id
-- HAVING COUNT(*) > 1;

-- ------------------------------------------------------------
-- 6. Duplicate id values within posts_tmp
--    (duplicates will be collapsed to one row by INSERT IGNORE)
-- ------------------------------------------------------------
-- SELECT id, COUNT(*) AS occurrences
-- FROM posts_tmp
-- GROUP BY id
-- HAVING COUNT(*) > 1;

-- ------------------------------------------------------------
-- 7. Duplicate id values within comments_tmp
--    (duplicates will be collapsed to one row by INSERT IGNORE)
-- ------------------------------------------------------------
-- SELECT id, COUNT(*) AS occurrences
-- FROM comments_tmp
-- GROUP BY id
-- HAVING COUNT(*) > 1;

-- ------------------------------------------------------------
-- 8. Duplicate name values within submolts_tmp
--    (duplicates will be collapsed to one row by INSERT IGNORE)
-- ------------------------------------------------------------
-- SELECT name, COUNT(*) AS occurrences
-- FROM submolts_tmp
-- GROUP BY name
-- HAVING COUNT(*) > 1;

-- ============================================================
-- DATA LOADING
-- _sling_loaded_at is excluded from all inserts: the permanent
-- tables retain their own value; staging columns are left in
-- their _tmp tables as-is.
-- ============================================================

-- ------------------------------------------------------------
-- AGENTS
-- ------------------------------------------------------------
INSERT IGNORE INTO agents (
    id,
    name,
    description,
    karma,
    follower_count,
    following_count,
    is_claimed,
    owner_x_handle,
    first_seen_at,
    last_seen_at,
    created_at,
    avatar_url,
    dump_date
)
SELECT
    id,
    name,
    description,
    karma,
    follower_count,
    following_count,
    is_claimed,
    owner_x_handle,
    first_seen_at,
    last_seen_at,
    created_at,
    avatar_url,
    dump_date
FROM agents_tmp;


-- ------------------------------------------------------------
-- POSTS
-- NOTE: posts has no PRIMARY KEY or UNIQUE constraint, so
-- INSERT IGNORE cannot deduplicate on its own. Consider adding
-- a UNIQUE index on `id` to make deduplication effective.
-- ------------------------------------------------------------
INSERT IGNORE INTO posts (
    id,
    agent_id,
    agent_name,
    submolt,
    title,
    content,
    url,
    score,
    comment_count,
    created_at,
    fetched_at,
    is_pinned,
    dump_date
)
SELECT
    id,
    agent_id,
    agent_name,
    submolt,
    title,
    content,
    url,
    score,
    comment_count,
    created_at,
    fetched_at,
    is_pinned,
    dump_date
FROM posts_tmp;

-- ------------------------------------------------------------
-- COMMENTS
-- ------------------------------------------------------------
INSERT IGNORE INTO comments (
    id,
    post_id,
    agent_id,
    agent_name,
    parent_id,
    content,
    score,
    created_at,
    fetched_at,
    dump_date
)
SELECT
    id,
    post_id,
    agent_id,
    agent_name,
    parent_id,
    content,
    score,
    created_at,
    fetched_at,
    dump_date
FROM comments_tmp;


-- ------------------------------------------------------------
-- SUBMOLTS
-- ------------------------------------------------------------
INSERT IGNORE INTO submolts (
    name,
    display_name,
    description,
    subscriber_count,
    post_count,
    created_at,
    first_seen_at,
    avatar_url,
    banner_url,
    dump_date
)
SELECT
    name,
    display_name,
    description,
    subscriber_count,
    post_count,
    created_at,
    first_seen_at,
    avatar_url,
    banner_url,
    dump_date
FROM submolts_tmp;


-- ==========================================
-- TRUNCATE TABLES
-- Only use once you verify data has transferred correctly
-- ==========================================
-- TRUNCATE submolts_tmp;
-- TRUNCATE agents_tmp;
-- TRUNCATE post_tmp;
-- TRUNCATE comments_tmp;
