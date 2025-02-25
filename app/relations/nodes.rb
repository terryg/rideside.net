# frozen_string_literal: true

# Nodes relation has node revisions and comments, as well as a user
class Nodes < ROM::Relation[:sql]
  schema(:node, infer: true, as: :nodes) do
    associations do
      has_many :node_revisions
      has_one :user
      has_many :comments, combine_key: :nid, override: true, view: :for_nodes
    end

    def first
      order { created.desc }
    end

    def last
      order { created.asc }
    end
  end
end
