require 'spec_helper'

describe "users/edit" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :company_name => "MyString",
      :taxi_count => 1
    ))
  end

  it "renders the edit user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", user_path(@user), "post" do
      assert_select "input#user_company_name[name=?]", "user[company_name]"
      assert_select "input#user_taxi_count[name=?]", "user[taxi_count]"
    end
  end
end
