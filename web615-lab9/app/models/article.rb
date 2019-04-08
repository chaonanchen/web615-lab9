# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :text
#  content    :text
#  category   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  uuid       :string
#  slug       :string
#

class Article < ApplicationRecord
  #Add FriendlyID to the model
  extend FriendlyId
  friendly_id :uuid, use: [:slugged, :finders]

  #3. generate UUID before create
  before_create :generate_uuid

  #4. save slug after create
  after_create :manually_update_slug

  private
  def generate_uuid
    #preappend uuid with model name
    self.uuid = "#{self.model_name.name}-" + SecureRandom.uuid
  end

  def manually_update_slug
    self.update_column(:slug, self.uuid)
  end

  has_many :comments
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true
end
