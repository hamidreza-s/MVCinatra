module Controllers
	class Main < Base
		get '/' do
			redirect '/note'
		end
	end
end
