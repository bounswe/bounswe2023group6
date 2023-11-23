-- Drop all tables
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS password_reset_tokens;
DROP TABLE IF EXISTS sessions;

CREATE TABLE IF NOT EXISTS users
(
    user_id         BIGINT PRIMARY KEY,
    username        VARCHAR(255) NOT NULL,
    email           VARCHAR(255) NOT NULL,
    password        VARCHAR(255) NOT NULL,
    profile_picture VARCHAR(255),
    about           TEXT,
    password_hash   BYTEA        NOT NULL,
    salt            BYTEA        NOT NULL
);

CREATE TABLE IF NOT EXISTS games
(
    game_id         BIGINT PRIMARY KEY,
    title           VARCHAR(255) NOT NULL,
    description     TEXT         NOT NULL,
    genre           VARCHAR(255) NOT NULL,
    platform        VARCHAR(255) NOT NULL,
    avatar_details  VARCHAR(255) NOT NULL,
    player_number   VARCHAR(255) NOT NULL,
    release_year    INT          NOT NULL,
    universe        VARCHAR(255) NOT NULL,
    mechanics       VARCHAR(255) NOT NULL,
    playtime        VARCHAR(255) NOT NULL,
    map_information VARCHAR(255) NOT NULL,
    user_id         BIGINT REFERENCES users (user_id)
);

CREATE TABLE IF NOT EXISTS posts
(
    post_id       BIGINT PRIMARY KEY,
    content       TEXT         NOT NULL,
    creation_date TIMESTAMP    NOT NULL,
    upvotes       INT          NOT NULL,
    downvotes     INT          NOT NULL,
    category      VARCHAR(255) NOT NULL,
    annotations   TEXT,
    user_id       BIGINT REFERENCES users (user_id),
    game_id       BIGINT REFERENCES games (game_id)
);

CREATE TABLE IF NOT EXISTS lfgs
(
    lfg_id              BIGINT PRIMARY KEY,
    title               VARCHAR(255) NOT NULL,
    description         TEXT         NOT NULL,
    required_platform   VARCHAR(255) NOT NULL,
    required_language   VARCHAR(255) NOT NULL,
    mic_cam_requirement BOOLEAN      NOT NULL,
    member_capacity     INT          NOT NULL,
    creation_date       TIMESTAMP    NOT NULL,
    tags                VARCHAR(255),
    user_id             BIGINT REFERENCES users (user_id),
    game_id             BIGINT REFERENCES games (game_id)
);



CREATE TABLE IF NOT EXISTS comments
(
    comment_id    BIGINT PRIMARY KEY,
    content       TEXT      NOT NULL,
    creation_date TIMESTAMP NOT NULL,
    upvotes       INT       NOT NULL,
    downvotes     INT       NOT NULL,
    post_id       BIGINT REFERENCES posts (post_id),
    lfg_id        BIGINT REFERENCES lfgs (lfg_id),
    user_id       BIGINT REFERENCES users (user_id)
);

-- Add foreign key constraints for relationships
ALTER TABLE posts
    ADD CONSTRAINT fk_user_post
        FOREIGN KEY (user_id) REFERENCES users (user_id);

Alter table games
    ADD CONSTRAINT fk_user_game
        FOREIGN KEY (user_id) REFERENCES users (user_id);

ALTER TABLE lfgs
    ADD CONSTRAINT fk_user_lfg
        FOREIGN KEY (user_id) REFERENCES users (user_id);

-- Add foreign key constraints for relationships
ALTER TABLE comments
    ADD CONSTRAINT fk_lfg_comment
        FOREIGN KEY (lfg_id) REFERENCES lfgs (lfg_id);

-- Add foreign key constraints for relationships
ALTER TABLE lfgs
    ADD CONSTRAINT fk_game_lfg
        FOREIGN KEY (game_id) REFERENCES games (game_id);

CREATE TABLE IF NOT EXISTS hamburgers
(
    id          BIGINT PRIMARY KEY,
    name        VARCHAR(255)     NOT NULL,
    ingredients TEXT             NOT NULL,
    price       DOUBLE PRECISION NOT NULL
);

CREATE TABLE IF NOT EXISTS tags
(
    tag_id BIGINT PRIMARY KEY,
    name   VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS post_tags
(
    tag_id  BIGINT REFERENCES tags (tag_id),
    post_id BIGINT REFERENCES posts (post_id),
    PRIMARY KEY (tag_id, post_id)
);

CREATE TABLE IF NOT EXISTS lfg_tags
(
    tag_id BIGINT REFERENCES tags (tag_id),
    lfg_id BIGINT REFERENCES lfgs (lfg_id),
    PRIMARY KEY (tag_id, lfg_id)
);

CREATE TABLE IF NOT EXISTS user_tags
(
    tag_id  BIGINT REFERENCES tags (tag_id),
    user_id BIGINT REFERENCES users (user_id),
    PRIMARY KEY (tag_id, user_id)
);


CREATE TABLE IF NOT EXISTS password_reset_tokens
(
    token            VARCHAR(255) PRIMARY KEY,
    username         BIGINT    NOT NULL,
    expiry_timestamp TIMESTAMP NOT NULL,
    user_id          BIGINT REFERENCES users (user_id)
);

CREATE TABLE IF NOT EXISTS sessions
(
    id        UUID PRIMARY KEY,
    timestamp TIMESTAMP NOT NULL,
    user_id   BIGINT REFERENCES users (user_id)
);

