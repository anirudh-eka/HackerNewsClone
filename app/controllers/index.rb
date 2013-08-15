
get '/' do

  erb :index
end

get '/login' do
  redirect '/' if session[:user_id]
  @error = "Login Error" if params[:msg] == "login_error" 
  @error = "Create Account Error" if params[:msg] == "create_account_error"

  erb :login
end

post '/login' do
  user = User.find_by_username(params[:login_name]) rescue nil

  if user && user.password == params[:login_password]
    session[:user_id] = user.id
    redirect '/'
  else 
    redirect '/login?msg=login_error'
  end

end

post '/create_account' do
  # Look in app/views/index.erb
  session[:user] = params[:create_name]
  user = User.new(username: params[:create_name])
  user.password = params[:create_password]
  user.save
  @error = user.errors

  if @error.any?
    redirect '/login?msg=create_account_error'
  else
    session[:user_id] = user.id
    redirect '/'
  end
end

get '/posts/:post_id' do 
  @post = Post.find(params[:post_id])
  @comments = @post.comments
  erb :post 
end

post '/new_comment/:post_id' do
  redirect '/login' unless login_check
  
  comment = Comment.create(user_id: session[:user_id], content: params[:comment_text], post_id: params[:post_id])
  @error = comment.errors
  if @error.any?
    redirect "/posts/#{params[:post_id]}?msg=content_error"
  else
    redirect "/posts/#{params[:post_id]}"
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

get '/profile/:user_id' do
  @user = User.find(params[:user_id]) rescue nil
  @posts = @user.posts
  @comments = @user.comments

  erb :profile
end

