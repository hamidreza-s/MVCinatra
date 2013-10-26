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
        # meta:
        meta = {}
        meta[:current] = page.to_i # current page
        meta[:rows] = 2 # rows per page
        meta[:start] = meta[:rows] * (meta[:current] - 1) # start row
        meta[:count] = count conditions # all record count
        meta[:pages] = meta[:count] / meta[:rows] # all pages count
        meta[:first] = 1 # first page
        meta[:last] = meta[:pages] # last page
        meta[:adjacent] = 4 # adjacent page number
        meta[:left] = (meta[:first]..meta[:current]).to_a.last(meta[:adjacent])[0..-2].to_a
        meta[:right] = (meta[:current]..meta[:last]).to_a.first(meta[:adjacent])[1..-1].to_a
        # records:
        records = all conditions.merge limit: meta[:rows], offset: meta[:start]
        # return
        {records: records, meta: meta}
      end
    end

  end  
end
