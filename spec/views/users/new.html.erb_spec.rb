require 'spec_helper'

describe "users/new" do
  before(:each) do
    assign(:user, stub_model(User,
      :company_name => "MyString",
      :taxi_count => 1
    ).as_new_record)
  end

  it "renders new user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", users_path, "post" do
      assert_select "input#user_company_name[name=?]", "user[company_name]"
      assert_select "input#user_taxi_count[name=?]", "user[taxi_count]"
    end
  end
end
