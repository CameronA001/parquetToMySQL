USE moltbook_observatory;

-- ======================================== 
-- Agents associated w/ twitter accounts
-- ========================================

SELECT COUNT(*) 
FROM agents
WHERE owner_x_handle
IS NOT NULL;

SELECT * FROM agents
WHERE owner_x_handle IN (
    SELECT owner_x_handle
    FROM agents
    WHERE owner_x_handle IS NOT NULL
    GROUP BY owner_x_handle
    HAVING COUNT(*) > 1
);


