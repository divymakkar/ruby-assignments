require 'uri'
require 'net/http'
require 'openssl'
require 'json'

class Weather
  APIkey = 'f57e21961d767baa8824fde8502df50e'
  APIurl = 'https://api.openweathermap.org/data/2.5/weather'
  def getTemperature(place)
    uri = URI(APIurl)
    params = {
      appid: APIkey,
      q: place,
      units: 'metric'
    }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    data = JSON.parse(res.body)
    name = data['name']
    weather = data['weather'][0]['main']
    temp = data['main']['temp']
    temp_max = data['main']['temp_max']
    temp_min = data['main']['temp_min']
    temp_feels_like = data['main']['feels_like']
    humidity = data['main']['humidity']
    puts "Place -  #{name}"
    puts "Weather -  #{weather}"
    puts "Temperature -  #{temp} C"
    puts "Minimum Temperature -  #{temp_min} C"
    puts "Maximum Temperature -  #{temp_max} C"
    puts "Feels Like Temperature -  #{temp_feels_like} C"
    puts "Humidity -  #{humidity}"
  end
end

print 'Enter the place: '
place = gets.chomp.downcase
Weather.new.getTemperature(place)
