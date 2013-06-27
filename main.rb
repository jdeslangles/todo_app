require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'httparty'
require 'pg'


get '/' do
  erb :home
end

get '/new_task' do
  if params.any?
  db = PG.connect(dbname: 'todo_database', host: 'localhost')
  begin
  @name = params[:name]
  @owner = params[:owner]
  @due_date = params[:due_date]
  @details = params[:details]
  @priority = params[:priority]
  @assigned_to = params[:assigned_to]
    sql = "insert into todo (name, owner, due_date, details, priority, assigned_to) values ('#{@name}', '#{@owner}', '#{@due_date}', '#{@details}', '#{@priority}', '#{@assigned_to}')"
    db.exec(sql)
  ensure
  db.close
  end
end
erb :new_task
end


get '/tasks' do
 db = PG.connect(dbname: 'todo_database', host: 'localhost')
 begin
    sql = "select * from todo"
  @results = db.exec(sql)

ensure
  db.close
end

erb :tasks
end