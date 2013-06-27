create table todo
  (
    id serial4  primary key,
    name varchar(255),
    owner varchar(255),
    due_date date,
    details text,
    priority varchar(255),
    assigned_to text
    );