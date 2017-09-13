require "test_helper"
class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = I18n.t("static_pages.help.title")
  end
  test "should get home" do
    get static_pages_home_url
    assert_response :success
    assert_select "title", "Home | #{@base_title}"
  end
  test "should get help" do
    get static_pages_help_url
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end
  test "should get about" do
    get static_pages_about_url
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end
end
