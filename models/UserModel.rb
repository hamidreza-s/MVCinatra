module Model
  class User
    include DataMapper::Resource
    property :id, Serial
    property :username, Text, :required => true
    property :password, Text, :required => true
    property :created_at, DateTime
    property :updated_at, DateTime
  end
end
