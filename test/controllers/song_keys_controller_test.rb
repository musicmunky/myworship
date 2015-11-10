require 'test_helper'

class SongKeysControllerTest < ActionController::TestCase
  setup do
    @song_key = song_keys(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:song_keys)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create song_key" do
    assert_difference('SongKey.count') do
      post :create, song_key: { capo_fret: @song_key.capo_fret, key_full_name: @song_key.key_full_name, key_modifier: @song_key.key_modifier, key_root: @song_key.key_root, key_symbol: @song_key.key_symbol }
    end

    assert_redirected_to song_key_path(assigns(:song_key))
  end

  test "should show song_key" do
    get :show, id: @song_key
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @song_key
    assert_response :success
  end

  test "should update song_key" do
    patch :update, id: @song_key, song_key: { capo_fret: @song_key.capo_fret, key_full_name: @song_key.key_full_name, key_modifier: @song_key.key_modifier, key_root: @song_key.key_root, key_symbol: @song_key.key_symbol }
    assert_redirected_to song_key_path(assigns(:song_key))
  end

  test "should destroy song_key" do
    assert_difference('SongKey.count', -1) do
      delete :destroy, id: @song_key
    end

    assert_redirected_to song_keys_path
  end
end
