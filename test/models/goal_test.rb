require 'test_helper'

class GoalTest < ActiveSupport::TestCase

  def setup
    @goal = Goal.new(objective: 'Decrease average hold time', due_date: '05/05/2017')
  end

  test "should be valid" do
    assert @goal.valid?
  end

  test "objective should be present" do
    @goal.objective = ' '
    assert_not @goal.valid?
  end

  test "objective should be at least 10 characters" do
    @goal.objective = 'a' * 9
    assert_not @goal.valid?
  end

  test "due date should be present" do
    @goal.due_date = ' '
    assert_not @goal.valid?
  end

  test "current should default to true" do
    assert_equal @goal.current, true
  end
end
