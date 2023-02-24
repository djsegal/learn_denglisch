require "application_system_test_case"

class LemmasTest < ApplicationSystemTestCase
  setup do
    @lemma = lemmas(:one)
  end

  test "visiting the index" do
    visit lemmas_url
    assert_selector "h1", text: "Lemmas"
  end

  test "should create lemma" do
    visit lemmas_url
    click_on "New lemma"

    fill_in "Audio", with: @lemma.audio
    fill_in "Name", with: @lemma.name
    fill_in "Type", with: @lemma.type
    fill_in "Word", with: @lemma.word_id
    click_on "Create Lemma"

    assert_text "Lemma was successfully created"
    click_on "Back"
  end

  test "should update Lemma" do
    visit lemma_url(@lemma)
    click_on "Edit this lemma", match: :first

    fill_in "Audio", with: @lemma.audio
    fill_in "Name", with: @lemma.name
    fill_in "Type", with: @lemma.type
    fill_in "Word", with: @lemma.word_id
    click_on "Update Lemma"

    assert_text "Lemma was successfully updated"
    click_on "Back"
  end

  test "should destroy Lemma" do
    visit lemma_url(@lemma)
    click_on "Destroy this lemma", match: :first

    assert_text "Lemma was successfully destroyed"
  end
end
