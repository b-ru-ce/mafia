class Category < ActiveRecord::Base
  include PathWithAlias
  has_ancestry

  validates :title, presence: true

  default_scope {order('sort')}

  has_and_belongs_to_many :articles
end

# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  sort       :integer
#  ancestry   :string(255)
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_categories_on_ancestry  (ancestry)
#
