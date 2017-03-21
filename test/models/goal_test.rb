require 'test_helper'

class GoalTest < ActiveSupport::TestCase

  def setup
    @rep = users(:rep)
    @goal = @rep.goals.build(objective: "text text text", due_date: "5/1/17")
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

  test "user id should be present" do
    @goal.user_id = nil
    assert_not @goal.valid?
  end
end
