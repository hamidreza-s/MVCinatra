module Model
  class User
    include DataMapper::Resource
    property :id, Serial
    property :username, String, :required => true, :unique => true
    property :password, String, :required => true
    property :firstname, String, :required => true
    property :lastname, String, :required => true
    property :created_at, DateTime
    property :updated_at, DateTime
    has n, :notes
  end
end
