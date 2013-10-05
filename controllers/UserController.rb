module Controllers
  class User < Base

    set_view to: self.name

    get '/signin' do
    
    end
    
    post '/signin' do
    
    end
    
    get '/signout' do
    
    end
    
    get '/signup' do
      @title = "Signup"
      haml :signup
    end
    
    post '/signup' do
    
    end
    
  end
end
