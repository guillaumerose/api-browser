class PostPresenter < Presenter
  attr_reader :url
  
  def initialize params
    super(params)
    
    @params = params
    @url = params["page"]
  end

  def payload
    printer = Printer.new
    printer.print(lazy_payload.last, @user, @password)
  end
  
  def code
    lazy_payload.first
  end
  
  def keys
    add_args("key", "new_key")
  end
  
  def values    
    add_args("value", "new_value")
  end  

  private
  def lazy_payload
    @payload ||= payload_for(@user, \
                             @password, \
                             url + "?" + keys.zip(values).map { |t| t.join("=") }.join("&"), \
                             type)
  end

  def type
    @params["load"].include?("json") ? "json" : "xml"
  end
  
  def add_args(prev, cur)
     nouveau = @params[cur].empty? ? [] : [@params[cur]]
    (@params[prev].nil? ? [] : @params[prev].values) + nouveau
  end
end

