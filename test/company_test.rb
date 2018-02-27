require './test/test_helper'
require './lib/company'

class CompanyTest < Minitest::Test
  def test_instantiation
    company = Company.new

    assert_instance_of Company, company
  end

  def test_attributes
    company = Company.new

    assert_equal [], company.employees
    assert_equal [], company.timesheets
    assert_equal [], company.projects
  end

  def test_it_can_load_employees
    filename = './data/employees.csv'
    company = Company.new
    expected = { success: true, errors: nil }

    assert_equal expected, company.load_employees(filename)
    assert_instance_of Employee, company.employees[0]
  end

  def test_it_can_read_csv
    filename = './data/employees.csv'
    company = Company.new
    expected = company.load_csv(filename)

    assert_instance_of CSV, expected
  end
end
