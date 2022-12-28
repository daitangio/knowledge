
PRAGMA journal_mode = wal;
PRAGMA foreign_keys=true;
PRAGMA integrity_check;  -- Reports corrupted data

.print Importing...

.mode box
delete from doc where path in (select fullpath from file_to_load); 

-- BUG: each file must be split in lines and imported as separate one
insert into doc(path,body)
    select fullpath as path, readfile(fullpath) as body from file_to_load;

insert into doc(doc) VALUES('optimize');

select count(*) from doc;
delete from file_to_load;

.quit