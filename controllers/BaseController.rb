module Controllers
  class Base < Sinatra::Base

    # constants
    CONTROLLER_DIR = File.dirname(__FILE__)
    ROOT_DIR = CONTROLLER_DIR + '/..'
    CURRENT_TIME = Time.now

    #defaults
    enable :method_override
    enable :static
    set :public_folder, ROOT_DIR + '/public'  
    
    # methods
    def self.set_view where
      set :views, 
        ROOT_DIR + '/views/' + where[:to].split('::').last || ''		
    end

  end
end
