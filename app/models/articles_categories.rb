class ArticlesCategories < ActiveRecord::Base
end

# == Schema Information
#
# Table name: articles_categories
#
#  id          :integer          not null, primary key
#  article_id  :integer
#  category_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#
