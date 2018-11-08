# frozen_string_literal: true

class Client < ApplicationRecord
  has_many :projects, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }, format: { with: /^[a-zA-Z0-9 _\.]*$/, multiline: true }
end
