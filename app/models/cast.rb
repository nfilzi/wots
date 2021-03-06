class Cast < ApplicationRecord
  belongs_to :user
  has_many :cast_sub_categories, dependent: :destroy
  has_many :sub_categories, through: :cast_sub_categories
  has_many :categories, through: :sub_categories
  has_many :comments
  has_one :portrait


  validates :format, inclusion: { in: %w[podcast minicast] }
  has_one_attached :photo
  has_one_attached :audio

  validates :title, presence: true
  validates :description, presence: true
  validates :localisation, presence: true
  validates :published_date, presence: true

  scope :podcasts, -> { where(format: "podcast") }
  scope :minicasts, -> { where(format: "minicast") }

  geocoded_by :localisation
  after_validation :geocode, if: :will_save_change_to_localisation?
end
