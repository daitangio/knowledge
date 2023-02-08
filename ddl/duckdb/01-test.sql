-- create a table and fill it with text data
CREATE TABLE documents(document_identifier VARCHAR, text_content VARCHAR, author VARCHAR, doc_version INTEGER);
INSERT INTO documents
VALUES ('doc1', 'The mallard is a dabbling duck that breeds throughout the temperate.','Hannes Mühleisen', 3),
       ('doc2', 'The cat is a domestic species of small carnivorous mammal.', 'Laurens Kuiper', 2),
       ('doc3', 'La pizza e'' stata inventata a Napoli','GG',1);
-- build the index (make both the 'text_content' and 'author' columns searchable)
PRAGMA create_fts_index('documents', 'document_identifier', 'text_content', 'author', stemmer='italian');
-- search the 'author' field index for documents that are written by Hannes - this retrieves 'doc1'
SELECT text_content, score
FROM (SELECT *, fts_main_documents.match_bm25(document_identifier, 'Muhleisen', fields := 'author') AS score
      FROM documents) sq
WHERE score IS NOT NULL
  AND doc_version > 2
ORDER BY score DESC;
-- search for documents about 'small cats' - this retrieves 'doc2'
SELECT text_content, score
FROM (SELECT *, fts_main_documents.match_bm25(document_identifier, 'small cats') AS score
      FROM documents) sq
WHERE score IS NOT NULL
ORDER BY score DESC;

-- Stemming at work
SELECT text_content, score
FROM (SELECT *, fts_main_documents.match_bm25(document_identifier, 'pizze') AS score
      FROM documents) sq
WHERE score IS NOT NULL
ORDER BY score DESC;

