require 'mechanize'
require 'parallel'
require 'csv'
require 'auth/open_id_authenticator'
file2 = CSV.open("bloomberg_symbols.csv","r").to_a

Parallel.each(file2,:in_threads=>100) do |symbol|
  begin
    agent = Mechanize.new
    agent.max_history = 1
    url = "http://www.bloomberg.com/quote/#{symbol[0]}/profile"
    page = agent.get(url)
    puts url
    hash = { }
    hash[:name] = page.at('h4').text.strip
    nodes = page.search(".left_column/div")

    hash[:country] = nodes[-1].text.strip
    hash[:city],hash[:zip] = nodes[-2].text.split(',') if nodes[-2]
    hash[:zip] = hash[:zip].strip if hash[:zip]
    hash[:address1] = nodes[0..-3].map{|n|n.text}.join(',').strip
    page.search(".right_column/div").each do |node|
      case
      when node.text.match(/Phone:/)
        hash[:phone] = node.text.gsub(/Phone:/,"").strip
      when node.at("a")
        hash[:website] = node.at('a')['href'].strip
      end
    end


    page.search(".exchange_type/ul/li").each do |node|
      case
      when node.text.match(/Sector:/)
        hash[:sector] = node.text.gsub(/Sector:/,"").strip
      when node.text.match(/^Industry:/)
        hash[:industry] = node.text.gsub(/^Industry:/,"").strip
      end
    end

    hash[:desc] = page.at('#extended_profile').text.strip if page.at('#extended_profile')

    CSV.open('bloomberg_companies.csv','a+') do |file|
      file << %w(name address1 city zip country website phone sector industry desc).map{|t| hash[t.to_sym]}
    end

    contacts = []

    page.search(".executives_two_cols/tr/td").each do |node|
      if node.at('.name')
        h ={}
        h[:name] = node.at('.name').text.strip
        h[:title] = node.at('.title').text.strip
        contacts << h
      end
    end

    CSV.open('bloomberg_contacts.csv','a+') do |file|
      contacts.each do |h|
        file << [hash[:name],h[:name],h[:title]]
      end
    end

  rescue=>e
    p e
  end
end

authenticator = ::Auth::OpenIdAuthenticator.new("bloomberg", "https://bauth2.bloomberg.com/user", trusted: true)

auth_provider title: "Bloomberg",
              authenticator: authenticator,
              message: "Bloomberg"

              Parallel.each(COUNTRIES,:in_threads=>10) do |country|

  agent = Mechanize.new
  agent.max_history = 1
  page_no = 1
  url = "http://www.bloomberg.com/markets/companies/country/#{country.downcase.gsub(" ","-")}/#{page_no}/"
  page = agent.get(url)

  while page.search("tr/.symbol").first
    begin
      CSV.open('bloomberg_symbols.csv','a+') do |file|
        page.search("tr/.symbol").each do |sym|
          file << [sym.text]
        end
      end
      puts url
      url = "http://www.bloomberg.com/markets/companies/country/#{country.downcase.gsub(" ","-")}/#{page_no}/"
      page = agent.get(url)
      page_no+=1
    rescue=>e
      p e
    end
  end
end
