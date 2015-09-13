require 'sinatra'
require 'json'


get '/' do
  "Hello World"
end

get '/edicoes' do
	return_message = {}
	edicoes = Edicoes.all
	return_message[:edicoes]=edicoes
	return_message.to_json
end