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
      redirect to '/tasks'
    ensure
      db.close
    end
  end
erb :new_task
end

get '/tasks/?:id?' do
  db = PG.connect(dbname: 'todo_database', host: 'localhost')
  begin
    if params[:id]
      task_id = params[:id].to_i
      sql = "select * from todo where id = #{task_id};"
      @result = db.exec(sql)
      erb :task_detail
    else
      sql = "select * from todo"
      @results = db.exec(sql)
      erb :tasks
    end
  ensure
    db.close
  end
end

get '/tasks/:id/task_delete' do
  db = PG.connect(dbname: 'todo_database', host: 'localhost')
  begin
    if params[:id]
      task_id = params[:id].to_i
      sql = "delete from todo where id = #{task_id};"
      db.exec(sql)
      redirect to '/tasks'
    end
  ensure
    db.close
  end
end

# get '/tasks/:id/task_update' do
#   db = PG.connect(dbname: 'todo_database', host: 'localhost')
#   begin
#     if params[:id]
#       task_id = params[:id].to_i
#       sql = "select * from todo where id = #{task_id};"
#       @result = db.exec(sql)
#     end
#     begin
#       if params[:id]
#        db = PG.connect(dbname: 'todo_database', host: 'localhost')
#       @name = params[:name]
#       @owner = params[:owner]
#       @due_date = params[:due_date]
#       @details = params[:details]
#       @priority = params[:priority]
#       @assigned_to = params[:assigned_to]
#   parameter =
#     #   sql = "update todo set #{parameter} from todo where id = #{task_id};"
#     #   db.exec(sql)
#      # redirect to '/tasks/:id/'
#   ensure
#     db.close
#   end
#        erb :task_update
# end
