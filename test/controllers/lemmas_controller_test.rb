require "test_helper"

class LemmasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lemma = lemmas(:one)
  end

  test "should get index" do
    get lemmas_url
    assert_response :success
  end

  test "should get new" do
    get new_lemma_url
    assert_response :success
  end

  test "should create lemma" do
    assert_difference("Lemma.count") do
      post lemmas_url, params: { lemma: { audio: @lemma.audio, name: @lemma.name, type: @lemma.type, word_id: @lemma.word_id } }
    end

    assert_redirected_to lemma_url(Lemma.last)
  end

  test "should show lemma" do
    get lemma_url(@lemma)
    assert_response :success
  end

  test "should get edit" do
    get edit_lemma_url(@lemma)
    assert_response :success
  end

  test "should update lemma" do
    patch lemma_url(@lemma), params: { lemma: { audio: @lemma.audio, name: @lemma.name, type: @lemma.type, word_id: @lemma.word_id } }
    assert_redirected_to lemma_url(@lemma)
  end

  test "should destroy lemma" do
    assert_difference("Lemma.count", -1) do
      delete lemma_url(@lemma)
    end

    assert_redirected_to lemmas_url
  end
end
