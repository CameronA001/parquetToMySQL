Reads in parquet files from moltbook-observatory into a mysql database using sling. The paramaters are determined in the attached yml files, and sling is run in terminal.

This repo is meant to work with sling, follow the setup guide here: https://slingdata.io/articles/sling-load-local-parquet-to-mysql/

Make a copy of the hugging face repo (https://huggingface.co/datasets/SimulaMet/moltbook-observatory-archive) on a level above this one, and pull ocassionally in order to get new parquet files. Data is located under "C:.../moltbook-observatory-archive/data/(table name)/\*.parquet". You will have to change the path individually for each yml file depending on your system.

In order to deal with duplicates data is read into temporary tables, and then SQL commands are used to insert ignore into the permanent table. After reading into the permanent tables, truncate the temporary ones. This ensures faster/cleaner reads from the parquet files on the next file pull.

sling run agents.yml
sling run comments.yml
sling run posts.yml
sling run submolts.yml
