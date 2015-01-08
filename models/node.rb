require 'dm-core'

require './models/node_revision'
require './models/node_user'

class Node
	include DataMapper::Resource

	storage_names[:default] = 'node'

	property :id, Serial, :field => 'nid'
	property :type, String, :length => 1..32
	property :title, String, :length => 1..255
	property :created, Integer

	has n, :node_revisions, :child_key => [ :nid ]
	has 1, :user, :model => 'NodeUser', :child_key => [ :uid ]
end