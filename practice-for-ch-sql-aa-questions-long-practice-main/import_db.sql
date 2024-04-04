PRAGMA foreign_keys = ON;

DROP TABLE if exists questions; 

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT,
    body TEXT,
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE if exists users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

DROP TABLE if exists question_follows;

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    questions_id INTEGER,
    users_id INTEGER,

    FOREIGN KEY (questions_id) REFERENCES questions(id),
    FOREIGN KEY (users_id) REFERENCES users(id)
);

DROP TABLE if exists replies;

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    body TEXT,
    question_id INTEGER,
    parent_id INTEGER,
    users_id INTEGER,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (parent_id) REFERENCES replies(id),
    FOREIGN KEY (users_id) REFERENCES users(id)
);

DROP TABLE if exists question_likes;

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    users_id INTEGER,
    question_id INTEGER,
    liked INTEGER,

    FOREIGN KEY (users_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
    users(fname, lname)
VALUES
    ('Henry', 'Ford'),
    ('Arthur', 'Miller');

INSERT INTO
    questions(title, body, author_id)
VALUES
    ('wheels', 'can I use four of them?', (SELECT id FROM users WHERE fname = 'Henry' AND lname = 'Ford'));

INSERT INTO 
    replies(body)
VALUES
    ('yes');