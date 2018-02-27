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

  def load_employees(filename)
    status = { success: true, errors: nil }
    data = load_csv(filename)
    data.each do |row|
      status[:errors] = 'bad data' if row.length < 4
      @employees << Employee.new(row[0], row[1], row[2], row[3], row[4])
    end
    status[:success] = false unless status[:errors].nil?
    status
  end

  def load_csv(filename)
    CSV.open(filename, headers: false, header_converters: :symbol)
  end
end
