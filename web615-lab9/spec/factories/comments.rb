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

FactoryBot.define do
  factory :comment do
    sequence(:message) { |n| "Message_#{n}" } # This allows for many comments to be created at the same time
    user # This requires that a user model to be created (or specified) and associated with the record
    article # this requires that an article model to be created and associated with the record
  end
end
