USE moltbook_observatory;

SELECT COUNT(*) FROM submolts;

#DATA VERIFICATION

##AGENTS

 SELECT id, COUNT(*) FROM agents
GROUP BY id, name
HAVING COUNT(*) >1
LIMIT 18446744073709551615;

INSERT IGNORE INTO agents
SELECT * FROM agents_tmp;
TRUNCATE agents_tmp;

##POSTS

 SELECT id, COUNT(*) FROM posts
GROUP BY id, agent_name
HAVING COUNT(*) >1
LIMIT 18446744073709551615;

###Use this command to insert after reading parquet files into "post_tmp", then delete data from posts_tmp for faster clean data reading next time
INSERT IGNORE INTO posts
SELECT * FROM posts_tmp;
TRUNCATE TABLE posts_tmp;


##COMMENTS
###Use this after reading parquet files into comments_tmp, and then delete data from comments_tmp for faster clean data reading next time
INSERT IGNORE INTO comments
SELECT * FROM comments_tmp;
TRUNCATE TABLE comments_tmp;

SELECT id, COUNT(*) FROM comments
GROUP BY id, content
HAVING COUNT(*) >1
LIMIT 18446744073709551615;



##SUBMOLTS
INSERT IGNORE INTO submolts
SELECT * FROM submolts_tmp;
TRUNCATE TABLE submolts_tmp;

SELECT name, COUNT(*) FROM submolts
GROUP BY name, description
HAVING COUNT(*) >1
LIMIT 18446744073709551615;