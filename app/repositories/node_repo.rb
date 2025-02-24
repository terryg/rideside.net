# frozen_string_literal: true

class NodesRepo < ROM::Repository[:nodes]

  def by_id(id)
    nodes.by_pk(id).one!
  end
  
  def nodes_with_revisions(locator)
    nodes.where(locator: locator).combine(:node_revisions)
  end

end
