class Project
  attr_reader :id,
              :name,
              :start_date,
              :end_date

  def initialize(id, name, start_date, end_date)
    @id = id.to_i
    @name = name
    @start_date = Time.parse(start_date)
    @end_date = Time.parse(end_date)
  end
end
