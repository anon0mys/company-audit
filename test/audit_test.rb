require './test/test_helper'
require './lib/audit'
require './modules/date_handler'

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
    company.load_employees('./data/employees.csv')
    company.load_projects('./data/projects.csv')
    company.load_timesheets('./data/timesheets.csv')
    audit = Audit.new
    audit.load_company(company)
    expected = "```\nInvalid Days Worked:\nnone\n```"

    assert_equal expected, audit.were_invalid_days_worked
  end

  def test_report_builder
    audit = Audit.new
    data = { employee: stub(name: 'someone'),
             project: stub(name: 'something'),
             timesheet_date: Date.new(2018, 1, 1),
             date_in_range: true }

    assert_nil audit.report_builder(data)
  end

  def test_report_builder_with_no_employee
    audit = Audit.new
    data = { employee: nil,
             project: stub(name: 'something'),
             timesheet_date: Date.new(2018, 1, 1),
             date_in_range: true }
    expected = 'Invalid employee ID for work on something on 2018-01-01'

    assert_equal expected, audit.report_builder(data)
  end

  def test_report_builder_with_no_project
    audit = Audit.new
    data = { employee: stub(name: 'Someone'),
             project: nil,
             timesheet_date: Date.new(2018, 1, 1),
             date_in_range: true }
    expected = 'Someone worked on invalid project on 2018-01-01'

    assert_equal expected, audit.report_builder(data)
  end

  def test_report_builder_with_bad_date
    audit = Audit.new
    data = { employee: stub(name: 'Someone'),
             project: stub(name: 'something'),
             timesheet_date: Date.new(2010, 1, 1),
             date_in_range: false }
    expected = 'Someone worked on something on 2010-01-01,'\
               ' which was outside project start and end dates'

    assert_equal expected, audit.report_builder(data)
  end

  def test_check_bad_date
    audit = Audit.new
    data = { project: stub(start_date: Date.new(2015, 1, 1),
                           end_date: Date.new(2018, 1, 1)),
             timesheet_date: Date.new(2014, 1, 1) }
    expected = false

    assert_equal expected, audit.check_date(data)
  end

  def test_check_good_date
    audit = Audit.new
    data = { project: stub(start_date: Date.new(2015, 1, 1),
                           end_date: Date.new(2018, 1, 1)),
             timesheet_date: Date.new(2016, 1, 1) }
    expected = true

    assert_equal expected, audit.check_date(data)
  end
end
