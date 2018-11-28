require "application_system_test_case"

class LectionsTest < ApplicationSystemTestCase
  setup do
    @lection = lections(:one)
  end

  test "visiting the index" do
    visit lections_url
    assert_selector "h1", text: "Lections"
  end

  test "creating a Lection" do
    visit lections_url
    click_on "New Lection"

    fill_in "Body", with: @lection.body
    fill_in "Description", with: @lection.description
    fill_in "Speciality", with: @lection.speciality
    fill_in "Tags", with: @lection.tags
    fill_in "Title", with: @lection.title
    click_on "Create Lection"

    assert_text "Lection was successfully created"
    click_on "Back"
  end

  test "updating a Lection" do
    visit lections_url
    click_on "Edit", match: :first

    fill_in "Body", with: @lection.body
    fill_in "Description", with: @lection.description
    fill_in "Speciality", with: @lection.speciality
    fill_in "Tags", with: @lection.tags
    fill_in "Title", with: @lection.title
    click_on "Update Lection"

    assert_text "Lection was successfully updated"
    click_on "Back"
  end

  test "destroying a Lection" do
    visit lections_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Lection was successfully destroyed"
  end
end
