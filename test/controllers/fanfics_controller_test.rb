require 'test_helper'

class FanficsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fanfic = fanfics(:one)
  end

  test "should get index" do
    get fanfics_url
    assert_response :success
  end

  test "should get new" do
    get new_fanfic_url
    assert_response :success
  end

  test "should create fanfic" do
    assert_difference('Fanfic.count') do
      post fanfics_url, params: { fanfic: { description: @fanfic.description, genre: @fanfic.genre, title: @fanfic.title, user_id: @fanfic.user_id } }
    end

    assert_redirected_to fanfic_url(Fanfic.last)
  end

  test "should show fanfic" do
    get fanfic_url(@fanfic)
    assert_response :success
  end

  test "should get edit" do
    get edit_fanfic_url(@fanfic)
    assert_response :success
  end

  test "should update fanfic" do
    patch fanfic_url(@fanfic), params: { fanfic: { description: @fanfic.description, genre: @fanfic.genre, title: @fanfic.title, user_id: @fanfic.user_id } }
    assert_redirected_to fanfic_url(@fanfic)
  end

  test "should destroy fanfic" do
    assert_difference('Fanfic.count', -1) do
      delete fanfic_url(@fanfic)
    end

    assert_redirected_to fanfics_url
  end
end
