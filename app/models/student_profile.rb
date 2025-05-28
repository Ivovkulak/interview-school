# frozen_string_literal: true

class StudentProfile < ApplicationRecord
  has_one :user, dependent: :nullify, inverse_of: :student_profile

  has_many :section_students, dependent: :destroy
  has_many :sections, through: :section_students
end
