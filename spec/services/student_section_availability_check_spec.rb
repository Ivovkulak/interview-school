require 'rails_helper'

RSpec.describe StudentSectionAvailabilityCheck do
  describe '#perform' do
    # rubocop:enable RSpec/LetSetup

    subject { described_class.new(student1.student_profile, target_section).perform }

    let(:student1) { create(:user, :student) }
    let(:student2) { create(:user, :student) }
    let(:teacher1) { create(:user, :teacher) }
    let(:teacher2) { create(:user, :teacher) }
    let(:classroom1) { create(:classroom) }
    let(:classroom2) { create(:classroom) }
    let(:subject1) { create(:subject) }
    let(:subject2) { create(:subject) }

    # section's schedule:
    # section1: Monday 10:00 - 11:00, classroom1
    # section2: Monday 12:00 - 13:00, classroom1
    # section3: Friday 10:00 - 11:00, classroom2
    # section4: Friday 11:00 - 12:00, classroom2
    # section5: Friday 10:00 - 11:00, classroom1 (same time as section3, but different room)
    # section6: Friday 11:30 - 12:30, classroom1 (overlapping time with section4, but different room)
    # section7: Friday 09:30 - 11:30, classroom1 (wraps section3's time slot)
    # section8: Friday 10:15 - 10:45, classroom1 (wrapped by section3's time slot)
    let(:section1) do
      create(:section,
        classroom: classroom1,
        subject: subject1,
        teacher_profile: teacher1.teacher_profile,
        monday_start: Time.parse("10:00"),
        monday_end: Time.parse("11:00"))
    end
    let(:section2) do
      create(:section,
        classroom: classroom1,
        subject: subject2,
        teacher_profile: teacher2.teacher_profile,
        monday_start: Time.parse("12:00"),
        monday_end: Time.parse("13:00"))
    end
    let(:section3) do
      create(:section,
        classroom: classroom2,
        subject: subject1,
        teacher_profile: teacher1.teacher_profile,
        friday_start: Time.parse("10:00"),
        friday_end: Time.parse("11:00"))
    end
    let(:section4) do
      create(:section,
        classroom: classroom2,
        subject: subject2,
        teacher_profile: teacher2.teacher_profile,
        friday_start: Time.parse("11:00"),
        friday_end: Time.parse("12:00"))
    end
    let(:section5) do
      create(:section,
        classroom: classroom1,
        subject: subject2,
        teacher_profile: teacher2.teacher_profile,
        friday_start: Time.parse("10:00"),
        friday_end: Time.parse("11:00"))
    end
    let(:section6) do
      create(:section,
        classroom: classroom1,
        subject: subject2,
        teacher_profile: teacher1.teacher_profile,
        friday_start: Time.parse("11:30"),
        friday_end: Time.parse("12:30"))
    end

    let(:target_section) { section6 }

    # just to ensure that the underlying SQL queries don't count another student's data
    # rubocop:disable RSpec/LetSetup
    let!(:student_2_sections) do
        student2.student_profile.sections = [ section1, section2, section3, section4 ]
    end

    context 'when list of user sections is empty' do
      it 'availability check passes' do
        expect(subject).to be true
      end
    end

    context 'when user has sections on Monday and trying to add a section on Friday' do
      before do
        student1.student_profile.sections = [ section1, section2 ]
      end

      let(:target_section) { section3 }

      it 'availability check passes' do
        expect(subject).to be true
      end
    end

    context 'when user has sections on Monday and Friday and trying to add a section on Friday using free time slot' do
      before do
        student1.student_profile.sections = [ section1, section2, section3 ]
      end

      let(:target_section) { section4 }

      it 'availability check passes' do
        expect(subject).to be true
      end
    end

    context 'when user has sections on Monday and Friday and trying to add a section using occupied time slot' do
      before do
        student1.student_profile.sections = [ section1, section2, section3 ]
      end

      let(:target_section) { section5 }

      it 'availability check fails' do
        expect(subject).to be false
      end
    end

    context 'when user has sections on Monday and Friday and trying to add a section on Friday using overlapping time slot' do
      before do
        student1.student_profile.sections = [ section1, section2, section3, section4 ]
      end

      let(:target_section) { section6 }

      it 'availability check fails' do
        expect(subject).to be false
      end
    end

    context 'when trying to add a section wich covers the timeslot of the existing section' do
      before do
        student1.student_profile.sections = [ section1, section2, section3 ]
      end

      let(:target_section) do
        create(:section,
          classroom: classroom1,
          subject: subject2,
          teacher_profile: teacher1.teacher_profile,
          friday_start: Time.parse("09:30"),
          friday_end: Time.parse("11:30"))
      end

      it 'availability check fails' do
        expect(subject).to be false
      end
    end

    context 'when trying to add a section wich lays in-between of the timeslot of the existing section' do
      before do
        student1.student_profile.sections = [ section1, section2, section3 ]
      end

      let(:target_section) do
        create(:section,
          classroom: classroom1,
          subject: subject2,
          teacher_profile: teacher1.teacher_profile,
          friday_start: Time.parse("10:15"),
          friday_end: Time.parse("10:45"))
      end

      it 'availability check fails' do
        expect(subject).to be false
      end
    end
  end
end
