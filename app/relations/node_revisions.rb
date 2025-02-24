# frozen_string_literal: true

class NodeRevisions < ROM::Relation[:sql]
  schema(infer: true) do
    associations do
      belongs_to :node
      belongs_to :user
    end
  end

  def for_nodes(_assoc, users)
    restrict(uid: users.map { |u| u[:uid] })
  end
end
