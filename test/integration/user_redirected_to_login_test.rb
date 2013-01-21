require 'test_helper'

class UserRedirectedToLoginTest < ActionDispatch::IntegrationTest

  test "User ends up on login page when they try to log in" do
    # Given: we're on the home page
    get "/"

   # assert_equal zB 'title' mit text bla sie sind auf der login seite...
    assert_select 'title', "Ruby on Rails: Welcome aboard"

    # is the login link present
    assert_select 'a', {:html => 'log in'}, "The page has a link with the text log in"
    
    assert_select 'a', {:html => /log in/i} do | all_links_with_this_html |
      # line above returns an array with one element
      assert_select all_links_with_this_html.first, "[href=?]", "/login"
    end


    # # When: we click the login button
    # # check login button is there
    assert_select "a[href]", /log in/i do |login_node|
      assert_select login_node.first, "[href=?]", "/login"
    end
    
    #easiest way
    assert_select "a[href=/login]", /log in/i


    get '/login'

    # Then we end up on the login page
    assert_response :success
    
    puts "+---------------------------------+"
    puts path   # url escaped
    puts URI.unescape(path)

    assert_equal '/login.html', URI.unescape(path)
  end

  test "User ends up on register page when they try to register" do
    #GIVEN
    get "/"

    #WHEN
    assert_select 'a', {:html => /register/i} do | all_links_with_this_html |
      assert_select all_links_with_this_html.first, "[href=?]", "/register" 

    #THEN
    get '/register'

    assert_response :success

    puts "+---------------------------------+"
    puts path   # url escaped
    assert_equal '/register.html' , URI.unescape(path)

    end
  end

end
