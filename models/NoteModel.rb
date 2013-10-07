module Model
  class Note
    include DataMapper::Resource
    property :id, Serial
    property :content, Text, :required => true
    property :complete, Boolean, :required => true, :default => false
    property :user_id, Integer, :required => true
    property :created_at, DateTime
    property :updated_at, DateTime
    belongs_to :user
  end
end
