require "faraday"
require "pry"
require 'optparse'

options = {
  limit: 50
}

OptionParser.new do |opts|
  opts.on("--term=nightlife" "Search Term") do |v|
    options[:term] = v
  end

  opts.on("--location=chicago", "The location") do |v|
    options[:location] = v
  end

  opts.on("--limit=20", "how many results you want returned") do |v|
    options[:limit] = v
  end
end.parse!

res = Faraday.get("https://api.yelp.com/v3/businesses/search", options) do |req|
  req.headers["Authorization"] = "Bearer " + ENV["YELP_TOKEN_SECRET"]
end

businesses = JSON.parse(res.body)["businesses"]
puts businesses.map {|b| b["name"]}.join("\n")
