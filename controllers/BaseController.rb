module Controllers
  class Base < Sinatra::Base

    # constants
    APP_NAME = "Reminder"
    CONTROLLER_DIR = File.dirname(__FILE__)
    ROOT_DIR = CONTROLLER_DIR + '/..'
    CURRENT_TIME = Time.now
    NOTE_PER_PAGE = 20
    
    # layouts
    MAIN_LAYOUT = :"../Base/layout"
    BLANK_LAYOUT = :"../Base/blank"

    #defaults
    enable :sessions
    set :session_secret, 'super secret'
    enable :method_override
    enable :static
    set :public_folder, ROOT_DIR + '/public'
    
    # before filter
    before do
      @default_layout = MAIN_LAYOUT
      @title = "Page"
    end
    
    # after filter
    after do
      # not yet!
    end

    # set helpers
    helpers RouteHelper, ViewHelper
    
    # methods
    def self.set_view where
      set :views, 
        ROOT_DIR + '/views/' + where[:to].split('::').last || ''		
    end

  end
end
