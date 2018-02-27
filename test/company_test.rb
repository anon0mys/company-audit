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

  def test_it_handles_bad_data
    filename = './data/bad_employees.csv'
    company = Company.new
    expected = { success: false, errors: 'bad data' }

    assert_equal expected, company.load_employees(filename)
    assert_empty company.employees
  end

  def test_it_can_read_csv
    filename = './data/employees.csv'
    company = Company.new
    expected = [['1', 'Susan Smith', 'Manager', '2016-01-01', '2018-02-20'],
                ['2', 'John Smith', 'Engineer', '2016-01-01', '2018-02-20']]

    assert_equal expected, company.load_csv(filename)
  end

  def test_status_method
    company = Company.new
    good_data = company.load_csv('./data/employees.csv')
    bad_data = company.load_csv('./data/bad_employees.csv')
    expected_success = { success: true, errors: nil }
    expected_failure = { success: false, errors: 'bad data' }

    assert_equal expected_success, company.status(good_data, 4)
    assert_equal expected_failure, company.status(bad_data, 4)
  end
end
