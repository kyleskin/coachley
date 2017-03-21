require 'test_helper'

class ActionItemTest < ActiveSupport::TestCase
  def setup
    @rep = users(:rep)
    @action_item = @rep.action_items.build(objective: 'Increase awesome', due_date: '5/5/17')
  end

  test "should be valid" do
    assert @action_item.valid?
  end

  test "objective should be present" do
    @action_item.objective = ' '
    assert_not @action_item.valid?
  end

  test "objective should be at least 10 characters" do
    @action_item.objective = 'a' * 9
    assert_not @action_item.valid?
  end

  test "due date should be present" do
    @action_item.due_date = ' '
    assert_not @action_item.valid?
  end

  test "current should default to true" do
    assert_equal @action_item.current, true
  end

  test "user id should be present" do
    @action_item.user_id = nil
    assert_not @action_item.valid?
  end
end
