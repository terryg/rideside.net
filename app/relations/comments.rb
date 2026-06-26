# frozen_string_literal: true

# Comments relation. Belongs to Nodes and Users.
class Comments < ROM::Relation[:sql]
  schema(infer: true) do
    associations do
      belongs_to :nodes, as: :node
      belongs_to :users, as: :user
    end
  end

  def by_nid(nid)
    where(nid:)
  end

  def for_nodes(_assoc, nodes)
    restrict(nid: nodes.map { |n| n[:nid] })
  end

  def for_users(_assoc, users)
    restrict(uid: users.map { |u| u[:uid] })
  end
end
