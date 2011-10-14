class Fuzzer < Sinatra::Base
  get '/' do
    @presenter = GetPresenter.new(params)
    erb :page
  end  
  
  post '/' do
    if params["page"].include?("?")
      redirect "/?q=#{params["page"]}"
    end
    
    @presenter = PostPresenter.new(params)
    erb :page
  end  
end

