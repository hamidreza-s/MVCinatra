module Controllers
  class Main < Base
    
    set_view to: self.name
    
    get '/' do
      redirect '/note'
    end

    get '/signin' do
      @title = 'Sign In'
      redirect '/forbid' if session[:ui]
      haml :signin, :layout => settings.blank_layout
    end
    
    post '/signin' do
      user = Model::User.first username: params[:username], 
        password: params[:password]
      if user
        session[:ui] = user.id
        session[:un] = user.firstname
        redirect '/note'
      else
        redirect '/signin'
      end  
    end
    
    get '/signout' do
      session.clear
      redirect '/signin'
    end
    
    get '/signup' do
    end
    
    post '/signup' do
    end
    
    get '/forbid' do
      @title = "Forbid"
      haml :forbid, :layout => setting.blank_layout
    end  

  end
end
