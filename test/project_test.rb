require './test/test_helper'
require './lib/project'

class ProjectTest < Minitest::Test
  def setup
    project_id = '123'
    name = 'Widget Maker'
    start_date = '2015-01-01'
    end_date = '2018-01-01'
    @project = Project.new(project_id, name, start_date, end_date)
  end

  def test_instantiation
    assert_instance_of Project, @project
  end

  def test_attributes
    expected_start_date = Date.new(2015, 1, 1)
    expected_end_date = Date.new(2018, 1, 1)

    assert_equal 123, @project.id
    assert_equal Integer, @project.id.class
    assert_equal 'Widget Maker', @project.name
    assert_equal expected_start_date, @project.start_date
    assert_equal expected_end_date, @project.end_date
  end
end
