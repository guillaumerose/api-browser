class GetPresenter < Presenter
  def initialize params
    super(params)
    
    coder = HTMLEntities.new
    @query = uri_for(coder.decode(params["q"]))
    @payload = payload_for(@user, @password, @query)
  end

  def url
    @query.split("?").first
  end
  
  def payload
    printer = Printer.new
    printer.print(@payload.last, @user, @password)
  end
  
  def code
    @payload.first
  end
  
  def keys
    debut, fin = @query.split("?")
    return [] unless fin
    fin.split("&").map { |t| t.split("=").first }.flatten
  end
  
  def values
    debut, fin = @query.split("?")
    return [] unless fin
    fin.split("&").map { |t| t.split("=").last }.flatten  
  end  

  private
  def uri_for query
    return "http://search.twitter.com/search.json?q=kitten&rpp=5&include_entities=true&with_twitter_user_id=true&result_type=mixed" if query.nil? || query == "" || query == "undefined"
    query
  end
end

