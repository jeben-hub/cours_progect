require "application_system_test_case"

class FanficsTest < ApplicationSystemTestCase
  setup do
    @fanfic = fanfics(:one)
  end

  test "visiting the index" do
    visit fanfics_url
    assert_selector "h1", text: "Fanfics"
  end

  test "creating a Fanfic" do
    visit fanfics_url
    click_on "New Fanfic"

    fill_in "Description", with: @fanfic.description
    fill_in "Genre", with: @fanfic.genre
    fill_in "Title", with: @fanfic.title
    fill_in "User", with: @fanfic.user_id
    click_on "Create Fanfic"

    assert_text "Fanfic was successfully created"
    click_on "Back"
  end

  test "updating a Fanfic" do
    visit fanfics_url
    click_on "Edit", match: :first

    fill_in "Description", with: @fanfic.description
    fill_in "Genre", with: @fanfic.genre
    fill_in "Title", with: @fanfic.title
    fill_in "User", with: @fanfic.user_id
    click_on "Update Fanfic"

    assert_text "Fanfic was successfully updated"
    click_on "Back"
  end

  test "destroying a Fanfic" do
    visit fanfics_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Fanfic was successfully destroyed"
  end
end
