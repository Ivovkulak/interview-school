# frozen_string_literal: true

class TeacherProfile < ApplicationRecord
  has_one :user, dependent: :nullify, inverse_of: :teacher_profile

  has_many :sections, dependent: :destroy, inverse_of: :teacher_profile
end
