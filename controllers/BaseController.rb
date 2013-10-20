module Controllers
  class Base < Sinatra::Base
    
    # layouts
    set :main_layout, :"../Base/layout"
    set :blank_layout, :"../Base/blank"
    
    # settings
    set :app_name, 'Reminder'
    set :controller_dir, File.dirname(__FILE__)
    set :root_dir, settings.controller_dir + '/..'

    # defaults
    enable :sessions
    set :session_secret, 'super secret'
    enable :method_override
    enable :static
    set :public_folder, settings.root_dir + '/public'
    
    # before filter
    before do
      @default_layout = settings.main_layout
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
        settings.root_dir + '/views/' + where[:to].split('::').last || ''		
    end

  end
end
