# frozen_string_literal: true

class TimeLog < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :hours, numericality: { greater_than_or_equal_to: 0 }, presence: true
end
