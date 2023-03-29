require "test_helper"

class ChaptersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @chapter = chapters(:one)
    @country = countries(:one)
    @user = users(:organization_admin) # Create and organization_admin user
    @user.confirm
    sign_in(@user) # Sign in user
  end

  test "should get index" do
    get chapters_url
    assert_response :success
  end

  test "should get new" do
    get new_chapter_url
    assert_response :success
  end

  test "should create chapter" do
    assert_difference("Chapter.count") do
      post chapters_url, params: { chapter: {
        description: @chapter.description, location: @chapter.location,
        name: "#{@chapter.name}#{rand(9)}", country_id: Country.last.id
      } }
    end

    assert_redirected_to chapter_url(Chapter.last)
  end

  test "should show chapter" do
    get chapter_url(@chapter)
    assert_response :success
  end

  test "should get edit" do
    get edit_chapter_url(@chapter)
    assert_response :success
  end

  test "should update chapter" do
    patch chapter_url(@chapter), params: { chapter: {
      description: @chapter.description, location: @chapter.location,
      name: "#{@chapter.name}#{rand(9)}", country_id: Country.last.id
    } }
    assert_redirected_to chapter_url(@chapter)
  end

  test "should destroy chapter" do
    @chapter.users_chapters.destroy_all
    assert_difference("Chapter.count", -1) do
      delete chapter_url(@chapter)
    end

    assert_redirected_to chapters_url
  end
end
