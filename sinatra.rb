require 'sinatra'
require 'json'
require 'active_record'

ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'w'))

ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => 'copas'
)


class Edicoes < ActiveRecord::Base
  include ActiveModel::Serializers::JSON
  include ActiveModel::Serializers::Xml
end

class Selecoes < ActiveRecord::Base
  include ActiveModel::Serializers::JSON
  include ActiveModel::Serializers::Xml
end


get '/' do
  "Hello World"
end


get '/xml/edicoes' do
	edicoes = Edicoes.all
	edicoes.to_xml
end

get '/json/edicoes' do
	edicoes = Edicoes.all
	edicoes.to_json
end


get '/xml/edicoes/:id' do
	edicoes = Edicoes.find(params[:id])
	return status 404 if edicoes.nil?
	edicoes.to_xml
end

get '/json/edicoes/:id' do
	edicoes = Edicoes.find(params[:id])
	return status 404 if edicoes.nil?
	edicoes.to_json
end


get '/xml/edicoes/edicao/:nome' do
	edicoes = Edicoes.where(sede: params[:nome])
	if edicoes.length==0
		return status 404
	end
	edicoes.to_xml
end


get '/json/edicoes/edicao/:nome' do
	edicoes = Edicoes.where(sede: params[:nome])
	if edicoes.length==0
		return status 404
	end
	edicoes.to_json
end


get '/xml/selecoes' do
	selecoes = Selecoes.all
	return status 404 if selecoes.nil?
	selecoes.to_xml
end


get '/json/selecoes' do
	selecoes = Selecoes.all
	return status 404 if selecoes.nil?
	selecoes.to_json
end


get '/xml/selecoes/selecao/:nome' do
	selecoes = Selecoes.where(pais: params[:nome])
	if selecoes.length==0
		return status 404
	end
	selecoes.to_xml
end


get '/json/selecoes/selecao/:nome' do
	selecoes = Selecoes.where(pais: params[:nome])
	if selecoes.length==0
		return status 404
	end
	selecoes.to_json
end


error 404 do
  'Esta Nacao nunca foi campea nem sediou alguma copa'
end