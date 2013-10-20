module Controllers
  class Note < Base

    set_view to: self.name
    
    before do
      redirect '/signin' unless session[:ui]
    end
    
    get '/:page?' do |page|
      # default page = 1
      @notes = Model::Note.paginate page || 1,
        user_id: session[:ui], 
        archive: 0, 
        order: :created_at.desc
      @title = "All Notes"
      completed = []
      uncompleted = []
      @notes.each do |item|
        completed << item if item.complete
        uncompleted << item unless item.complete
    end
      @notes = uncompleted.concat completed
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
      redirect '/'
    end

    get '/archive' do
      @notes = Model::Note.all user_id: session[:ui], 
        archive: 1, order: :created_at.desc 
      @title = "Archived Notes"
      haml :archive
    end

    get '/edit/:id' do
      @note = Model::Note.first id: params[:id], 
        user_id: session[:ui]
      no_record unless @note
      @title = "Edit note ##{params[:id]}"
      haml :edit
    end

    put '/edit/:id' do
      note = Model::Note.first id: params[:id], 
        user_id: session[:ui]
      no_record unless note
      note.content = params[:content]
      note.tags = params[:tags]
      note.must_do_at = params[:must_do_at]
      note.frequency = params[:frequency]
      note.updated_at = Time.now
      note.save
      redirect '/'
    end

    get '/delete/:id' do
      @note = Model::Note.first id: params[:id], 
        user_id: session[:ui]
      no_record unless @note
      @title = "Confirm deletion of note ##{params[:id]}"
      haml :delete
    end

    delete '/:id' do
      note = Model::Note.first id: params[:id], 
        user_id: session[:ui]
      no_record unless note
      note.destroy
      redirect request.referrer
    end

    get '/archive/:id' do
      note = Model::Note.first id: params[:id], 
        user_id: session[:ui]
      no_record unless note
      note.archive = note.archive ? 0 : 1
      note.save
      redirect request.referrer
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
      redirect request.referrer
    end

  end
end
