# -*- encoding : utf-8 -*-
class PhotoGallery < ActiveRecord::Base
  include PathWithAlias

  has_ancestry

  validates :title, presence: true

  has_many :photos, dependent: :destroy
  accepts_nested_attributes_for :photos, :allow_destroy => true

  default_scope { order('date DESC') }

  def main_photo
    photos.main.first || photos.first
  end
end

# == Schema Information
#
# Table name: photo_galleries
#
#  id              :integer          not null, primary key
#  title           :text
#  sort            :integer
#  ancestry        :string(255)
#  title_of_window :string(255)
#  meta            :text
#  created_at      :datetime
#  updated_at      :datetime
#  text            :text
#  date            :date
#
# Indexes
#
#  index_photo_galleries_on_ancestry  (ancestry)
#
