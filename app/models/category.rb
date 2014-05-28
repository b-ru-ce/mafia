class Category < ActiveRecord::Base
  include PathWithAlias
  has_ancestry

  validates :title, presence: true

  default_scope {order('sort')}

  has_and_belongs_to_many :articles
end
