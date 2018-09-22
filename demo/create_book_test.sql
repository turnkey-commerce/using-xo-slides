CREATE TABLE authors (
  author_id SERIAL PRIMARY KEY,
  name text NOT NULL DEFAULT '' UNIQUE
);
CREATE INDEX authors_name_idx ON authors(name);
CREATE TYPE book_type AS ENUM (
  'FICTION',
  'NONFICTION'
);
CREATE TABLE books (
  book_id SERIAL PRIMARY KEY,
  author_id integer NOT NULL REFERENCES authors(author_id),
  isbn text NOT NULL DEFAULT '' UNIQUE,
  booktype book_type NOT NULL DEFAULT 'FICTION',
  title text NOT NULL DEFAULT '',
  year integer NOT NULL DEFAULT 2000,
  available timestamp with time zone NOT NULL DEFAULT 'NOW()',
  tags varchar[] NOT NULL DEFAULT '{}'
);
CREATE INDEX books_title_idx ON books(title, year);
CREATE FUNCTION say_hello(text) RETURNS text AS $$
BEGIN
  RETURN CONCAT('hello ', $1);
END;
$$ LANGUAGE plpgsql;
CREATE INDEX books_title_lower_idx ON books(title);


INSERT INTO public.authors (author_id, name)
VALUES (1,'Charles Dickens');
INSERT INTO public.authors (author_id,name)
VALUES (2,'Herman Melville');
INSERT INTO public.authors (author_id,name)
VALUES (3,'James Joyce');
INSERT INTO public.authors (author_id,name)
VALUES (4,'Henry David Thoreau');


INSERT INTO public.books (book_id,author_id, isbn, booktype, title, year, available)
VALUES (1,1,9783862311088,'FICTION','Oliver Twist',	1837, '1839-01-01 00:00:00-05:50:36');
INSERT INTO public.books (book_id,author_id, isbn, booktype, title, year, available)
VALUES (2,1,9789953581668,'FICTION','A Tale of Two Cities',	1859,	'1860-01-01 00:00:00-05:50:36');
INSERT INTO public.books (book_id,author_id, isbn, booktype, title, year, available)
VALUES (3,1,9788809033726,'FICTION','A Christmas Carol',	1843,	'1844-01-01 00:00:00-05:50:36');
INSERT INTO public.books (book_id,author_id, isbn, booktype, title, year, available)
VALUES (4,2,9787806261279,'FICTION','Moby Dick',	1851,	'1852-01-01 00:00:00-05:50:36');
INSERT INTO public.books (book_id,author_id, isbn, booktype, title, year, available)
VALUES (5,3,9783518455944,'FICTION','Ulysses',	1922,	'1922-02-02 00:00:00-06');
INSERT INTO public.books (book_id,author_id, isbn, booktype, title, year, available)
VALUES (6,4,9781977648907,'NONFICTION','Walden',	1854,	'1854-08-09 00:00:00-05:50:36');

SELECT setval('public.authors_author_id_seq', 4, true);
SELECT setval('public.books_book_id_seq', 6, true);