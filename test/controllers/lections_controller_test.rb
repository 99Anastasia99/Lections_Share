require 'test_helper'

class LectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lection = lections(:one)
  end

  test "should get index" do
    get lections_url
    assert_response :success
  end

  test "should get new" do
    get new_lection_url
    assert_response :success
  end

  test "should create lection" do
    assert_difference('Lection.count') do
      post lections_url, params: { lection: { body: @lection.body, description: @lection.description, speciality: @lection.speciality, tags: @lection.tags, title: @lection.title } }
    end

    assert_redirected_to lection_url(Lection.last)
  end

  test "should show lection" do
    get lection_url(@lection)
    assert_response :success
  end

  test "should get edit" do
    get edit_lection_url(@lection)
    assert_response :success
  end

  test "should update lection" do
    patch lection_url(@lection), params: { lection: { body: @lection.body, description: @lection.description, speciality: @lection.speciality, tags: @lection.tags, title: @lection.title } }
    assert_redirected_to lection_url(@lection)
  end

  test "should destroy lection" do
    assert_difference('Lection.count', -1) do
      delete lection_url(@lection)
    end

    assert_redirected_to lections_url
  end
end
