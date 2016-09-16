DROP TABLE IF EXISTS schools;
DROP TABLE IF EXISTS users;

CREATE TABLE schools(
  unitid INTEGER,
  instnm VARCHAR(255),
  stabbr VARCHAR(255),
  fip	VARCHAR(255),
  fips INTEGER,
  webaddr	VARCHAR(255),
  countycd INTEGER,
  countynm VARCHAR(255),
  enrollment2015 INTEGER,
  merge VARCHAR(255)
);

CREATE TABLE users(
  id SERIAL PRIMARY KEY,
  email VARCHAR(255),
  domain VARCHAR(255),
  status VARCHAR(255)
)
