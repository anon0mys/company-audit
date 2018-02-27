require './modules/date_handler'

# Audits company and verifies valid time to project to employee relationships
class Audit
  attr_reader :company

  def load_company(company)
    @company ||= company
  end

  def were_invalid_days_worked
    @company.timesheets.map do |timesheet|
      data[:employee] = @company.find_by_employee_id(timesheet.employee_id)
      data[:project] = @company.find_by_project_id(timesheet.project_id)
      data[:timesheet_date] = DHDate.new(timesheet.date)
      # data[:date_in_range] = check_date(data)
      report_builder(data)
    end
  end

  def report_builder(data)
    header = "'''\nInvalid Days Worked:\n"
    if data[:employee].nil?
      "Invalid employee ID for work on #{data[:project].name} on"\
      " #{data[:timesheet_date]}"
    elsif data[:project].nil?
      "#{data[:employee].name} worked on invalid project on"\
      " #{data[:timesheet_date]}"
    elsif timesheet_date.date_between(project.start_date, project.end_date)
      "#{employee} worked on #{project} on #{timesheet_date},"\
      " which was outside project start and end dates"
    else
      "none"
    end
  end
end
