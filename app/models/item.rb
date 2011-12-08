# coding: utf-8
class Item < ActiveRecord::Base
  WDAYS = ["日", "月", "火", "水", "木", "金", "土"]

  validates :name, :presence => true
  validates :price, :presence => true, :numericality => true
end
