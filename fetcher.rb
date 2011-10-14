class Fetcher
  def fetch user, password, url, type
    uri = URI.parse(url)

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    request.basic_auth(user, password) unless user.empty?
    request.add_field("Accept", "application/#{type}")
    
    response = http.request(request)
    
    return ["#{response.code} #{response.message}", response.body]
  end
end

