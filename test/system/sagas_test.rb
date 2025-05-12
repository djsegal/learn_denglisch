require "application_system_test_case"

class SagasTest < ApplicationSystemTestCase
  setup do
    @saga = sagas(:one)
  end

  test "visiting the index" do
    visit sagas_url
    assert_selector "h1", text: "Sagas"
  end

  test "should create saga" do
    visit sagas_url
    click_on "New saga"

    fill_in "Name", with: @saga.name
    click_on "Create Saga"

    assert_text "Saga was successfully created"
    click_on "Back"
  end

  test "should update Saga" do
    visit saga_url(@saga)
    click_on "Edit this saga", match: :first

    fill_in "Name", with: @saga.name
    click_on "Update Saga"

    assert_text "Saga was successfully updated"
    click_on "Back"
  end

  test "should destroy Saga" do
    visit saga_url(@saga)
    click_on "Destroy this saga", match: :first

    assert_text "Saga was successfully destroyed"
  end
end
