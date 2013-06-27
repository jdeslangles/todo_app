create table todo
  (
    id serial4  primary key,
    name varchar(255),
    owner text,
    due_date varchar(4),
    details text,
    priority varchar(255),
    assigned_to text
    );