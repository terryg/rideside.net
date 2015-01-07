require './node_revision'

class Node
	include DataMapper::Resource

	storage_names[:default] = 'node'

	property :id, Serial, :field => 'nid'
	property :type, String, :length => 32
	property :title, String, :length => 255

	has n, :node_revision
end

