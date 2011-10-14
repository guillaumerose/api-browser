class Printer
  def print(body, user, password)
    coder = HTMLEntities.new
    add_link(coder.encode(format_string(body)), user, password)
  end
  
  private
  def format_string(str)
    begin
    JSON.pretty_generate(JSON.parse(str))
    rescue
    begin 
      doc = REXML::Document.new str
      formatter = REXML::Formatters::Pretty.new
      formatter.compact = true
      formatter.write(doc.root, "")
    rescue Exception
    "Error parsing"
    end
    end
  end
  
  def add_link(str, user, password)
    add_link_with_quote(add_link_with_quote(str, user, password, "&quot;"), user, password, "&apos;")
  end
  
  def add_link_with_quote(str, user, password, quote)
    regex = quote + "(http:\/\/(.*?))" + quote
    output = str.clone
    str.scan(/#{regex}/).each do |l|
      output.gsub!(quote + l.first + quote, quote + "<a href=\'?user=" + user + "&password=" + password + "&q=" + CGI.escape(l.first) +"\'>" + l.first + "</a>" + quote)
    end
    output.gsub(/&quot;([a-zA-Z_]*?)&quot;:/, quote + '<b>\1</b>' + quote + ':')
  end
end

