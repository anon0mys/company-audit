require './test/test_helper'
require './lib/timesheet'

class TimesheetTest < Minitest::Test
  def setup
    employee_id = '5'
    project_id = '7'
    date = '2015-01-01'
    minutes = '120'
    @timesheet = Timesheet.new(employee_id, project_id, date, minutes)
  end

  def test_instantiation
    assert_instance_of Timesheet, @timesheet
  end

  def test_attributes
    expected_date = Time.parse('2015-01-01')

    assert_equal 5, @timesheet.employee_id
    assert_equal Integer, @timesheet.employee_id.class
    assert_equal 7, @timesheet.project_id
    assert_equal Integer, @timesheet.project_id.class
    assert_equal expected_date, @timesheet.date
    assert_equal 120, @timesheet.minutes
    assert_equal Integer, @timesheet.minutes.class
  end
end
