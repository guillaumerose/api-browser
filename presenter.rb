class Presenter
  attr_reader :user, :password
  
  def initialize params
    @user = params["user"] || ""
    @password = params["password"] || ""
  end
   
  protected
  def payload_for(user, password, url, type = "json")
    begin
    fetcher = Fetcher.new
    fetcher.fetch(user, password, url, type)
    rescue
    "Connection problem"
    end
  end
end

