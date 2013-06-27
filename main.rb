require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'httparty'
require 'json'
require 'pg'


get '/' do
  erb :home
end

get '/new_task' do
  db = PG.connect(dbname: 'todo_database', host: 'localhost')
  begin

  @name = params[:name]
  @owner = params[:owner]
  @due_date = params[:due_date]
  @details = params[:details]
  @priority = params[:priority]
  @assigned_to = params[:assigned_to]

    sql = "insert into todo (name, owner, due-date, details, priority, assigned_to) values ('#{@hash['Title']}', '#{@hash['Year']}', '#{@hash['Rated']}', '#{@hash['Released']}', '#{@hash['Runtime']}', '#{@hash['Genre']}', '#{@hash['Director']}', '#{@hash['Writer']}', '#{@hash['Actors']}', '#{@hash['Plot']}', '#{@hash['Poster']}')"

    db.exec(sql)


ensure
  db.close
end

erb :new_task
end