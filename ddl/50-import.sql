
PRAGMA journal_mode = wal;
PRAGMA foreign_keys=true;
PRAGMA integrity_check;  -- Reports corrupted data

.print Importing...

.mode box
delete from doc where path in (select fullpath from file_to_load); 

-- ? BUG: each file must be split in lines and imported as separate one
-- Refer to https://stackoverflow.com/a/65154328/75540 for complex workaround
insert into doc(path,body)
    select fullpath as path, readfile(fullpath) as body from file_to_load;

delete from file_to_load;

-- Same for URls
delete from doc where path in (select url from url_to_load); 
insert into doc(path,body)
    select url as path, readfile(content) as body from url_to_load;
delete from url_to_load;


/* This command merges all individual b-trees that currently make up the full-text index into a single large b-tree structure. 
This ensures that the full-text index consumes the minimum space within the database and is in the fastest form to query.
Ref https://www.sqlite.org/fts5.html#the_merge_command
*/
insert into doc(doc) VALUES('optimize');
select count(*) as total_documents from doc;

.quit