# frozen_string_literal: true

class Section < ApplicationRecord
  belongs_to :subject
  belongs_to :classroom
  belongs_to :teacher_profile

  has_many :section_students, dependent: :destroy
  has_many :student_profiles, through: :section_students
end
