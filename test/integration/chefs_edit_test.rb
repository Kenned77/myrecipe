require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  def setup 
    @chef = Chef.create!(chefname: "Kenneth", email: "kenneth@example.com",
                        password: "password", password_confirmation: "password") 
  end
  
  test "reject invalid edit" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
      patch chef_path(@chef), params: { chef: { chefname: " ", email: "kenneth@example.com" } }
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "accept valid edit" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
      patch chef_path(@chef), params: { chef: { chefname: "Kenneth1", email: "kenneth1@example.com" } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "Kenneth1", @chef.chefname
    assert_match "kenneth1@example.com", @chef.email
  end
end