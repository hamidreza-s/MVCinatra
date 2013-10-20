module RouteHelper

  def no_record
    halt 404, 'not found record'
  end
    
end
