# frozen_string_literal: true

class Users < ROM::Relation[:sql]
  schema(infer: true) do
    associations do
      has_many :node_revisions, combine_key: :uid, override: true, view: :for_users
      has_many :nodes, combine_key: :uid, override: true, view: :for_users
      has_many :comments, combine_key: :uid, override: true, view: :for_users
    end

    def first
      order { created.desc }
    end

    def last
      order { created.asc }
    end
  
  end
end
