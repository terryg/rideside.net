require './models/node_user'

class NodeRevision
	include DataMapper::Resource

	belongs_to :node, :child_key => [ :nid ]
	belongs_to :user, :model => 'NodeUser', :child_key => [ :uid ]

	property :id, Serial, :field => 'vid'
	property :title, String, :length => 1..255
	property :body, String
	property :timestamp, Integer

	def posted_at
		Time.at(timestamp)
	end
end