require 'test_helper'

class PhraseControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get phrase_index_url
    assert_response :success
  end

end
