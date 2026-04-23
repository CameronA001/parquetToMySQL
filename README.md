Reads in parquet files from moltbook-observatory into a mysql database using sling. The paramaters are determined in the attached yml files, and sling is run in terminal.

This repo is meant to work with sling, follow the setup guide here: https://slingdata.io/articles/sling-load-local-parquet-to-mysql/

Make a copy of the hugging face repo (https://huggingface.co/datasets/SimulaMet/moltbook-observatory-archive) on a level above this one, and pull ocassionally in order to get new parquet files. Data is located under "C:.../moltbook-observatory-archive/data/(table name)/\*.parquet". You will have to change the path individually for each yml file depending on your system.

In order to deal with duplicates and foreign key constraints, data is read into temporary tables, and then SQL commands are used to insert ignore into the permanent table. After reading into the permanent tables, truncate the temporary ones. This ensures faster/cleaner reads from the parquet files on the next file pull.

Run createTables.sql before doing anything as well. Sling auto creates tables, but mysql requires the permanent tables to be made in order to insert into them.

Should be such that once you have environment set up you are able to run the below command in terminal after you cd into the "yamlFiles" folder, and then run the whole "queries.sql" file after the sling command finishes.

MAKE SURE THAT THE TEMPORARY TABLES ARE EMPTY BEFORE READIGN IN THE PARQUET FILES. SLING DOES NOT HANDLE DUPLICATES.

sling run submolts.yml; sling run agents.yml; sling run posts.yml; sling run comments.yml
