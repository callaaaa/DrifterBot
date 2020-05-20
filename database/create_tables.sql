CREATE TABLE Bot(
  screen_name VARCHAR(50) NOT NULL,
  twitter_banner_name VARCHAR(50),
  password VARCHAR(50),
  bot_id INTEGER PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
  twitter_user_id VARCHAR(50) NOT NULL,
  init_friend json,
  init_timestamp TIMESTAMP,
  param json  -- store parameters used in bot activities
);

CREATE TABLE tweet (
     tweet_id varchar(50) PRIMARY KEY,
     user_id varchar(50) NOT NULL,
     tweet_obj JSON NOT NULL,
     created_at timestamp NOT NULL,
     url_score numeric,
     hashtag_score numeric,
     low_cred_score numeric,
     resolved_urls TEXT []
);

CREATE TABLE home_timeline (
     id    integer PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
     bot_id integer NOT NULL,
     checked_at   timestamp NOT NULL,
     FOREIGN KEY (bot_id) REFERENCES bot (bot_id)
);

CREATE TABLE home_timeline_tweets (
    htl_id integer,
    tw_id varchar(40),
    PRIMARY KEY (htl_id, tw_id),
    FOREIGN KEY (tw_id) REFERENCES tweet (tweet_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (htl_id) REFERENCES home_timeline (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Action(
  bot_id INTEGER REFERENCES Bot(bot_id),
  source VARCHAR(20) NOT NULL,
  action VARCHAR(20) NOT NULL,
  timestamp TIMESTAMP NOT NULL DEFAULT NOW(),
  result json not null,
  tl_id INTEGER REFERENCES home_timeline(id)
);

CREATE TABLE Connections(
  t_usr_id_ego varchar(50),
  t_usr_id_conn varchar(50),
  time TIMESTAMP NOT NULL DEFAULT NOW(),
  conn_tweet_update_time TIMESTAMP,  -- the last time we saved user timeline of t_usr_id_conn  
  conn_type boolean, -- 0 friend, 1 follower
  no_connctions boolean default false -- 0 connected, 1 not connected
);


CREATE INDEX timestamp_idx ON tweet (created_at);
CREATE INDEX user_timeline_idx ON tweet (user_id, created_at);
CREATE INDEX home_timeline_idx ON home_timeline (bot_id, checked_at);
