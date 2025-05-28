# frozen_string_literal: true

class StudentSectionAvailabilityCheck
  def initialize(student_profile, section)
    @student_profile = student_profile
    @section = section
  end

  def perform
    # build where clause parts for each day of the week
    where_clause_parts = []
    where_clause_arguments = []
    Date::DAYNAMES.each do |d_name|
      day_name_start = "#{d_name.downcase}_start"
      day_name_end = "#{d_name.downcase}_end"
      target_start = @section.public_send(day_name_start)&.strftime("%H:%M")
      target_end = @section.public_send(day_name_end)&.strftime("%H:%M")

      next if target_start.blank? || target_end.blank?

      where_clause_parts <<
        "((#{day_name_start} <= ? AND #{day_name_end} > ?)" +
          " OR (#{day_name_start} < ? AND #{day_name_end} >= ?)" +
          " OR (#{day_name_start} >= ? AND #{day_name_end} <= ?))"

      where_clause_arguments << target_start
      where_clause_arguments << target_start
      where_clause_arguments << target_end
      where_clause_arguments << target_end
      where_clause_arguments << target_start
      where_clause_arguments << target_end
    end

    # rubocop:disable Security/SQLInjection
    !(@student_profile.sections.where(
      where_clause_parts.join(" OR "),
      *where_clause_arguments
    ).exists?)
    # rubocop:enable Security/SQLInjection
  end
end
