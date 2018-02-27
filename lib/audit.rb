require './modules/date_handler'

# Audits company and verifies valid time to project to employee relationships
class Audit
  attr_reader :company

  def load_company(company)
    @company ||= company
  end

  def were_invalid_days_worked
    header = "```\nInvalid Days Worked:\n"
    body = @company.timesheets.map do |timesheet|
      data = {}
      data[:employee] = @company.find_by_employee_id(timesheet.employee_id)
      data[:project] = @company.find_by_project_id(timesheet.project_id)
      data[:timesheet_date] = timesheet.date
      data[:date_in_range] = check_date(data)
      report_builder(data)
    end.uniq.compact.join("\n")
    body = 'none' if body = ''
    footer = "\n```"
    header + body + footer
  end

  def report_builder(data)
    if data[:employee].nil?
      "Invalid employee ID for work on #{data[:project].name} on"\
      " #{data[:timesheet_date]}"
    elsif data[:project].nil?
      "#{data[:employee].name} worked on invalid project on"\
      " #{data[:timesheet_date]}"
    elsif !data[:date_in_range]
      "#{data[:employee].name} worked on #{data[:project].name} on"\
      " #{data[:timesheet_date]},"\
      " which was outside project start and end dates"
    else
      nil
    end
  end

  def check_date(data)
    project = data[:project]
    timesheet_date = DateHandler::DHDate.new(data[:timesheet_date])
    timesheet_date.date_between(project.start_date, project.end_date)
  end
end
