class NodeUser
	include DataMapper::Resource

	storage_names[:default] = 'users'

	property :id, Serial, :field => 'uid'  
	property :name, String, :length => 1..60
end