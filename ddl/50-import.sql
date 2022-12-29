
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


insert into doc(doc) VALUES('optimize');
select count(*) from doc;






.quit