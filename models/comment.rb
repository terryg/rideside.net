require 'dm-core'

require './models/node'
require './models/node_user'

class Comment
	include DataMapper::Resource

	belongs_to :node, :child_key => [ :nid ]
	belongs_to :user, :model => 'NodeUser', :child_key => [ :uid ]

	property :id, Serial, :field => 'cid'
	property :subject, String, :length => 1..64
	property :comment, String
	property :timestamp, Integer
	property :thread, String, :length => 1..255

	def posted_at
		Time.at(timestamp)
	end

end