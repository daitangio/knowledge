-- Default structures
PRAGMA journal_mode = wal;
PRAGMA foreign_keys=true;


PRAGMA integrity_check;  -- Reports corrupted data

.mode box
-- Using the porter tokenizer english stemming is supported
Create virtual table if not exists doc using fts5(path,body, upd_date, tokenize='porter');


create table if not exists file_to_load (fullpath);
create table if not exists url_to_load (url,content);