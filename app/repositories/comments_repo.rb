# frozen_string_literal: true

class CommentsRepo < ROM::Repository[:nodes]

  def by_id(id)
    nodes.by_pk(id).one!
  end

end
