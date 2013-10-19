module Controllers
  class Note < Base

    set_view to: self.name
    
    before do
      redirect '/signin' unless session[:ui]
    end
    
    get '/' do
      @notes = Model::Note.all user_id: session[:ui], archive: 0, order: :created_at.desc
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
      n = Model::Note.new
      n.content = params[:content]
      n.tags = params[:tags]
      n.must_do_at = params[:must_do_at]
      n.frequency = params[:frequency]
      n.created_at = Time.now
      n.updated_at = Time.now
      n.user_id = session[:ui]
      n.save
      redirect '/'
    end

    get '/archive' do
      @notes = Model::Note.all user_id: session[:ui], archive: 1, order: :created_at.desc 
      @title = "Archived Notes"
      haml :archive
    end

    get '/:id/edit' do
      @note = Model::Note.get params[:id]
      @title = "Edit note ##{params[:id]}"
      haml :edit
    end

    put '/:id/edit' do
      n = Model::Note.get params[:id]
      n.content = params[:content]
      n.tags = params[:tags]
      n.must_do_at = params[:must_do_at]
      n.frequency = params[:frequency]
      n.updated_at = Time.now
      n.save
      redirect '/'
    end

    get '/:id/delete' do
      @note = Model::Note.get params[:id]
      @title = "Confirm deletion of note ##{params[:id]}"
      haml :delete
    end

    delete '/:id' do
      n = Model::Note.get params[:id]
      n.destroy
      redirect request.referrer
    end

    get '/:id/archive' do
      n = Model::Note.get params[:id]
      n.archive = n.archive ? 0 : 1
      n.save
      redirect request.referrer
    end

    get '/:id/complete' do
      n = Model::Note.get params[:id]
      if n.complete
        n.complete = 0
        n.have_done_at = nil
      else
        n.complete = 1
        n.have_done_at = Time.now
      end
      n.updated_at = Time.now
      n.save
      redirect request.referrer
    end

  end
end
