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

  def test_it_can_load_projects
    filename = './data/projects.csv'
    company = Company.new
    expected = { success: true, errors: nil }

    assert_equal expected, company.load_projects(filename)
    assert_instance_of Project, company.projects[0]
  end

  def test_it_can_load_timesheets
    filename = './data/timesheets.csv'
    company = Company.new
    expected = { success: true, errors: nil }

    assert_equal expected, company.load_timesheets(filename)
    assert_instance_of Timesheet, company.timesheets[0]
  end

  def test_it_handles_bad_employee_data
    filename = './data/bad_employees.csv'
    company = Company.new
    expected = { success: false, errors: 'bad data' }

    assert_equal expected, company.load_employees(filename)
    assert_empty company.employees
  end

  def test_it_handles_bad_timesheet_data
    filename = './data/bad_timesheets.csv'
    company = Company.new
    expected = { success: false, errors: 'bad data' }

    assert_equal expected, company.load_timesheets(filename)
    assert_empty company.timesheets
  end

  def test_it_handles_bad_project_data
    filename = './data/bad_projects.csv'
    company = Company.new
    expected = { success: false, errors: 'bad data' }

    assert_equal expected, company.load_projects(filename)
    assert_empty company.projects
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

    assert_equal expected_success, company.status(good_data, 5)
    assert_equal expected_failure, company.status(bad_data, 5)
  end

  def test_find_by_employee_id
    filename = './data/employees.csv'
    company = Company.new
    company.load_employees(filename)
    expected = 'John Smith'

    assert_instance_of Employee, company.find_by_employee_id(2)
    assert_equal expected, company.find_by_employee_id(2).name
    assert_nil company.find_by_employee_id(10)
  end

  def test_find_by_project_id
    filename = './data/projects.csv'
    company = Company.new
    company.load_projects(filename)
    expected = 'Acme Project'

    assert_instance_of Project, company.find_by_project_id(3)
    assert_equal expected, company.find_by_project_id(3).name
    assert_nil company.find_by_project_id(10)
  end
end
