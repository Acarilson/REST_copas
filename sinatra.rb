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

get '/edicao/:id' do
	r = {}
	edicao = Edicoes.find(params[:id])
	return status 404 if edicao.nil?
	r[:edicoes]=edicao
	r.to_json
end

get '/selecao' do
	r = {}
	selecao = Selecoes.all
	return status 404 if selecao.nil?
	r[:titulos]=selecao
	r.to_json
end

get '/selecao/:nome' do
	r = {}
	selecao = Selecoes.find_by pais: (params[:nome])
	return status 404 if selecao.nil?
	r[:titulos]=selecao
	r.to_json
end