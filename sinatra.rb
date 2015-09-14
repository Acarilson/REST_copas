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


get '/edicoes' do
	return_message = {}
	edicoes = Edicoes.all
	return_message[:edicoes]=edicoes
	return_message.to_json
end


get '/edicoes/:id' do
	r = {}
	edicoes = Edicoes.find(params[:id])
	return status 404 if edicoes.nil?
	r[:edicao]=edicoes
	r.to_json
end


get '/edicoes/edicao/:nome' do
	r = {}
	edicoes = Edicoes.where(sede: params[:nome])
	if edicoes.length==0
		return status 404
	end
	r[:sede]=edicoes
	r.to_json

end


get '/selecoes' do
	r = {}
	selecoes = Selecoes.all
	return status 404 if selecoes.nil?
	r[:campeoes]=selecoes
	r.to_json
end


get '/selecoes/selecao/:nome' do
	r = {}
	selecoes = Selecoes.where(pais: params[:nome])
	if selecoes.length==0
		return status 404
	end
	r[:campeao]=selecoes
	r.to_json
end


error 404 do
  'Esta Nacao nunca foi campea nem sediou alguma copa'
end