require "easy_static_google_map/version"
require'rubygems'
require'net/http'
require'json'

module EasyStaticGoogleMap

	def self.geocode(address)
		address = URI.encode(address)
		hash = Hash.new
		baseUrl = "http://maps.google.com/maps/api/geocode/json"
		reqUrl = "#{baseUrl}?address=#{address}&sensor=false&language=ja"
		response = Net::HTTP.get_response(URI.parse(reqUrl))
		status = JSON.parse(response.body)
		hash['lat'] = status['results'][0]['geometry']['location']['lat']
		hash['lng'] = status['results'][0]['geometry']['location']['lng']
		return hash
	end

	def self.map_url(address,options = {})
		# location = self.geocode(address)
		url = "http://maps.googleapis.com/maps/api/staticmap?"

		width = options[:width] || 400
		height = options[:height] || 400
		zoom = options[:zoom] || 16
		scale = options[:scale] || 1
		address = URI.encode(address)

		params = "zoom=#{zoom}&size=#{width}x#{height}&markers=#{address}&scale=#{scale}&sensor=false&language=ja"
	
		return url + params
	end

end

# p EasyStaticGoogleMap.methods
# p EasyStaticGoogleMap.geocode('福岡市博多区')
# p EasyStaticGoogleMap.map_url('福岡市博多区',{scale: 2})