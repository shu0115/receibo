# coding: utf-8
class Item < ActiveRecord::Base
  WDAYS = ["日", "月", "火", "水", "木", "金", "土"]

  belongs_to :user

#  validates :name, :presence => true
  validates :price, :presence => true
  validates :price, :numericality => true, :allow_blank => true
end
