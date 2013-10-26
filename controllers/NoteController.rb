module Controllers
  class Note < Base

    set_view to: self.name

    before do
      redirect '/signin' unless session[:ui]
    end

    get '/' do
      # default format = html
      # default page = 1
      # default archive = all
      # default frequency = all
      result = Model::Note.paginate params[:page] || 1, 
        {
          :conditions => 
          {
            :user_id => session[:ui],
            :archive => params[:archive] || [0, 1],
            :frequency => 
              params[:frequency] ? 
              params[:frequency].split(',') : 
              ['annually', 'monthly', 'weekly','daily', 'once']
          },
          :order => :created_at.desc
        }
      @notes = result[:records]
      @meta = result[:meta]
      @title = "All Notes"
      completed = []
      uncompleted = []
      @notes.each do |item|
        completed << item if item.complete
        uncompleted << item unless item.complete
      end
      @notes = uncompleted.concat completed
      # render: 
      if params[:format] == 'json'
        content_type :json
        return result.to_json
      end
      haml :home
    end

    post '/' do
      note = Model::Note.new
      note.content = params[:content]
      note.tags = params[:tags]
      note.must_do_at = params[:must_do_at]
      note.frequency = params[:frequency]
      note.created_at = Time.now
      note.updated_at = Time.now
      note.user_id = session[:ui]
      note.save
      # render
      content_type :json
      note.to_json
    end
    
    put '/:id' do
      note = Model::Note.first id: params[:id],
        user_id: session[:ui]
      no_record unless note
      note.content = params[:content]
      note.tags = params[:tags]
      note.must_do_at = params[:must_do_at]
      note.frequency = params[:frequency]
      note.updated_at = Time.now
      note.save
      # render:
      content_type :json
      note.to_json
    end

    delete '/:id' do
      note = Model::Note.first id: params[:id],
        user_id: session[:ui]
      no_record unless note
      note.destroy
      # render:
      content_type :json
      note.to_json
    end

    get '/archive/:id' do
      note = Model::Note.first id: params[:id],
        user_id: session[:ui]
      no_record unless note
      note.archive = note.archive ? 0 : 1
      note.save
      # render:
      content_type :json
      note.to_json
    end

    get '/complete/:id' do
      note = Model::Note.first id: params[:id],
        user_id: session[:ui]
      no_record unless note
      if note.complete
        note.complete = 0
        note.have_done_at = nil
      else
        note.complete = 1
        note.have_done_at = Time.now
      end
      note.updated_at = Time.now
      note.save
      # render:
      content_type :json
      note.to_json
    end

  end
end
