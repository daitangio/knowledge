-- Default structures
PRAGMA journal_mode = wal;
PRAGMA foreign_keys=true;


PRAGMA integrity_check;  -- Reports corrupted data

.mode box
-- Using the porter tokenizer english stemming is supported
Create virtual table if not exists doc using fts5(path,body, upd_date, tokenize='porter');

Create virtual table if not exists blog using fts5(title,url,body, tokenize='porter');

create table if not exists file_to_load (fullpath);