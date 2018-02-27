require './test/test_helper'
require './lib/audit'

class AuditTest < Minitest::Test
  def test_instantiation
    audit = Audit.new

    assert_instance_of Audit, audit
  end

  def test_it_loads_a_company
    audit = Audit.new
    mock_company = mock

    assert_equal mock_company, audit.load_company(mock_company)
    assert_equal mock_company, audit.company
  end

  def test_were_invalid_days_worked
    company = Company.new
    company.load_employees('./lib/employees.csv')
    company.load_projects('./lib/projects.csv')
    company.load_timesheets('./lib/timesheets.csv')
    audit = Audit.new
    audit.load_company(company)
    expected = "```\nInvalid Days Worked:\n\n```"

    assert_equal expected, audit.were_invalid_days_worked
  end

  def test_were_invalid_days_worked_none
    audit = Audit.new
    expected = "```\nInvalid Days Worked:\nNone\n```"

    assert_equal expected, audit.were_invalid_days_worked
  end

  def test_report_builder
    audit = Audit.new
    data = { employee: stub(name: 'someone'),
             project: stub(name: 'something'),
             timesheet_date: Date.new(2018, 1, 1),
             date_in_range: true }
    expected = "```\nInvalid Days Worked:\nNone\n```"

    assert_equal expected, audit.report_builder(data)
  end
  #
  # def test_check_employee_ids
  #   audit = Audit.new
  #   employee = mock
  #   company = stub(find_by_employee_id: nil, find_by_project_id: 'Widgets')
  #   audit.load_company(company)
  #   expected = 'Invalid employee ID for work on Widgets on 2016-02-20'
  #
  #   assert_equal employee, audit.check_employee_id('id')
  # end
end
