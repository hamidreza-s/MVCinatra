module Controllers
  class Base < Sinatra::Base

    # constants
    APP_NAME = "Reminder"
    CONTROLLER_DIR = File.dirname(__FILE__)
    ROOT_DIR = CONTROLLER_DIR + '/..'
    CURRENT_TIME = Time.now
    
    # layouts
    MAIN_LAYOUT = :"../Base/layout"
    BLANK_LAYOUT = :"../Base/blank"

    #defaults
    enable :sessions
    set :session_secret, 'super secret'
    enable :method_override
    enable :static
    set :public_folder, ROOT_DIR + '/public'  
    
    # filters
    before do
      @default_layout = MAIN_LAYOUT
    end
    
    after do
      # not yet!
    end

    
    # methods
    def self.set_view where
      set :views, 
        ROOT_DIR + '/views/' + where[:to].split('::').last || ''		
    end

  end
end
