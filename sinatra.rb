require 'sinatra'
require 'json'
require 'active_record'

ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'w'))

ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => 'copas'
)

# Edicoes de copas
class Edicoes < ActiveRecord::Base
end

# Selecoes vencedoras
class Selecoes < ActiveRecord::Base
end


get '/' do
  "Hello World"
end

get '/edicoes' do
	return_message = {}
	edicoes = Edicoes.all
	return_message[:edicoes]=edicoes
	return_message.to_json
end