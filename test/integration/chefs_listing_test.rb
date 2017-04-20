require 'test_helper'

class ChefsListingTest < ActionDispatch::IntegrationTest
  def setup 
    @chef = Chef.create!(chefname: "Kenneth1", email: "kenneth1@example.com",
                        password: "password1", password_confirmation: "password1")
    @chef2 = Chef.create!(chefname: "Kenneth2", email: "kenneth2@example.com",
                        password: "password2", password_confirmation: "password2")
  end
  
  test "should get chefs listing" do
    get chefs_path
    assert_template 'chefs/index'
    assert_select "a[href=?]", chef_path(@chef), text: @chef.chefname.capitalize
    assert_select "a[href=?]", chef_path(@chef2), text: @chef2.chefname.capitalize
  end
  
   test "should delete chef" do
    sign_in_as(@chef2, "password2")
    get chefs_path
    assert_template 'chefs/index'
    assert_difference 'Chef.count', -1 do
      delete chef_path(@chef2)
    end
    assert_redirected_to chefs_path
    assert_not flash.empty?
  end
end
