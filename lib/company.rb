require 'csv'
require 'pry'

# A class for handling and importing csv data and managing repositories
class Company
  attr_reader :employees,
              :timesheets,
              :projects

  def initialize
    @employees = []
    @timesheets = []
    @projects = []
  end

  def status(data, length)
    status_report = { success: true, errors: nil }
    expected_length = length
    data.each do |row|
      status_report[:errors] = 'bad data' if row.length < expected_length
    end
    status_report[:success] = false unless status_report[:errors].nil?
    status_report
  end

  def load_employees(filename)
    data = load_csv(filename)
    status_report = status(data, 4)
    return status_report unless status_report[:success]
    data.each do |row|
      @employees << Employee.new(row[0], row[1], row[2], row[3], row[4])
    end
    status_report
  end

  def load_csv(filename)
    data = CSV.open(filename, headers: false, header_converters: :symbol)
    data.map do |row|
      row
    end
  end
end
