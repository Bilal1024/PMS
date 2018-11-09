# frozen_string_literal: true

class Client < ApplicationRecord
  has_one :attachment, as: :attachable, dependent: :destroy
  has_many :projects, dependent: :destroy

  validates :attachment, presence: true
  validates :name, presence: true, uniqueness: { case_sensitive: false }, format: { with: /^[a-zA-Z0-9 _\.]*$/, multiline: true }
  accepts_nested_attributes_for :attachment, allow_destroy: true
end
