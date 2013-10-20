module Model
  class Note
    include DataMapper::Resource
    property :id, Serial
    property :content, Text, :required => true
    property :complete, Boolean, :required => true, :default => false
    property :user_id, Integer, :required => true
    property :archive, Boolean, :required => true, :default => false
    property :tags, String
		property :must_do_at, DateTime
		property :have_done_at, DateTime
		property :frequency, String # once, daily, weekly, monthly, annually
    property :created_at, DateTime
    property :updated_at, DateTime
    belongs_to :user

    class << self
      def paginate(page, conditions)
        note_per_page = 2
        start_row = note_per_page * (page.to_i - 1)
        all conditions.merge limit: note_per_page, offset: start_row
      end
    end

  end  
end
