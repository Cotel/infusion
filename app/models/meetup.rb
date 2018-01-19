class Meetup < ApplicationRecord
  has_many :holdings, dependent: :destroy
  has_many :hosts, through: :holdings, source: :user

  has_and_belongs_to_many :categories

  has_many :attachments, dependent: :destroy
  has_many :photos, dependent: :destroy

  accepts_nested_attributes_for :holdings, allow_destroy: true

  accepts_nested_attributes_for :attachments, allow_destroy: true

  accepts_nested_attributes_for :photos, allow_destroy: true

  has_many :assistances, dependent: :destroy
  has_many :assistants, through: :assistances, source: :user

  validates :title, presence: true
  validates :description, presence: true
  validates :requirements, presence: true

  def taking_place?
    !date.nil?
  end

  def average_rating
    marks = assistances.where.not(mark: nil).pluck(:id)
    if marks.count > 0
      marks.sum / marks.count
    else
      0
    end
  end
end
