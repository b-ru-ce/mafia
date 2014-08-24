# -*- encoding : utf-8 -*-
class Article < ActiveRecord::Base
  include PathWithAlias

  dragonfly_accessor :image

  validates :title, :presence => true
  validates :date, :presence => true

  paginates_per 3

  default_scope {order('date DESC')}
  scope :last_news, ->{ limit(3) }
  scope :useful, ->{ where(usefull: true).limit(6) }

  has_and_belongs_to_many :categories

  def self.monthes
    self.pluck(:date).map{|date| "#{date.month}-#{date.year}"}.uniq
  end

end

# == Schema Information
#
# Table name: articles
#
#  id              :integer          not null, primary key
#  title           :text
#  date            :date
#  image_uid       :string(255)
#  short_text      :text
#  text            :text
#  title_of_window :string(255)
#  meta            :text
#  created_at      :datetime
#  updated_at      :datetime
#  usefull         :boolean
#
