require './test/test_helper'
require './lib/employee'

class EmployeeTest < Minitest::Test
  def setup
    employee_id = '5'
    name = 'Sally Jackson'
    role = 'Engineer'
    start_date = '2015-01-01'
    end_date = '2018-01-01'
    @employee = Employee.new(employee_id, name, role, start_date, end_date)
  end

  def test_instantiation
    assert_instance_of Employee, @employee
  end

  def test_attributes
    expected_start_date = Date.new(2015, 1, 1)
    expected_end_date = Date.new(2018, 1, 1)

    assert_equal 5, @employee.id
    assert_equal Integer, @employee.id.class
    assert_equal 'Sally Jackson', @employee.name
    assert_equal 'Engineer', @employee.role
    assert_equal expected_start_date, @employee.start_date
    assert_equal expected_end_date, @employee.end_date
  end
end
