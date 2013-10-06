module Controllers
  class User < Base

    set_view to: self.name

    get '/signin' do
      @title = 'Sign In'
      redirect '/note' if session['username']
      haml :signin, :layout => BLANK_LAYOUT
    end
    
    post '/signin' do
      user = Model::User.first :username => params[:username], :password => params[:password]
      if user
        session['username'] = user.username
        redirect '/note'
      else
        redirect '/user/signin'
      end  
    end
    
    get '/signout' do
    
    end
    
    get '/signup' do

    end
    
    post '/signup' do
    
    end
    
  end
end
