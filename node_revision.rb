class NodeRevision
	include DataMapper::Resource

	belongs_to :node, :child_key => [ :nid ]

	property :id, Serial, :field => 'vid'
	property :title, String, :length => 255
	property :body, String
 
end