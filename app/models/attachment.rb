# frozen_string_literal: true

class Attachment < ApplicationRecord
  belongs_to :attachable, polymorphic: true

  has_attached_file :avatar
  do_not_validate_attachment_file_type :avatar

  validate :validate_avatar_type
  validates :avatar, presence: true, attachment_presence: true

  def validate_avatar_type
    if attachable_type == 'User' && !avatar_content_type.match(%r{\Aimage\/.*\z})
      errors.add(:avatar_content_type, 'must be an image')
    elsif attachable_type == 'Project' && !['application/pdf'].include?(avatar_content_type)
      errors.add(:avatar_content_type, 'must be pdf')
    end
  end
end
