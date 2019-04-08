# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  message    :text
#  visible    :boolean          default(FALSE)
#  article_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  uuid       :string
#  slug       :string
#

class Comment < ApplicationRecord
  #1. Friendly Integration
  extend FriendlyId

  #2. Sane Friendly Fallback
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



  belongs_to :article
  belongs_to :user

  validates :message, presence: true
end
