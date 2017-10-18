require 'sinatra'
require 'data_mapper' # metagem, requires common plugins too.

# need install dm-sqlite-adapter
# if on heroku, use Postgres database
# if not use sqlite3 database I gave you
if ENV['DATABASE_URL']
  DataMapper::setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
else
  DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/blog.db")
end

class Post
    include DataMapper::Resource
    property :id, Serial
    property :title, String
    property :body, Text
    property :created_at, DateTime
end

# Perform basic sanity checks and initialize all relationships
# Call this when you've defined all your models
DataMapper.finalize

# automatically create the post table
Post.auto_upgrade!

get '/new' do
	erb :new
end

post '/create' do
	newpos = Post.create(:title => params[:title], :body => params[:post])
	newpos.save
	"SUCCESS!!!1!!!1111!11one!111!!"
end

get '/' do
	#load all posts
	#display them
	@title = "All posts"
	@headline = "My life in blog"
	@paragraph = "Follow me plz. Follow 4 Follow."
	@posts = Post.all


	erb :index
end
