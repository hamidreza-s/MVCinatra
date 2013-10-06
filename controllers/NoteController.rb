module Controllers
  class Note < Base

    set_view to: self.name
    
    before do
      redirect '/signin' unless session[:ui]
    end
    
    get '/' do
      @notes = Model::Note.all :order => :id.desc
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
      n.created_at = Time.now
      n.updated_at = Time.now
      n.save
      redirect '/'
    end

    get '/:id' do
      @note = Model::Note.get params[:id]
      @title = "Edit note ##{params[:id]}"
      haml :edit
    end

    put '/:id' do
      n = Model::Note.get params[:id]
      n.content = params[:content]
      n.complete = params[:complete] ? 1 : 0
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
      redirect '/'
    end

    get '/:id/complete' do
      n = Model::Note.get params[:id]
      n.complete = n.complete ? 0 : 1
      n.updated_at = Time.now
      n.save
      redirect '/'
    end

  end
end
