require File.dirname(__FILE__) + '/../spec_helper'

describe User do
    before(:each) do
        User.find(:all).each { |u| u.destroy_for_real }
        @user = User.new
    end
    
    describe "aware of whether its logged in" do
        before(:each) do
            @user = Factory.build( :user, :role => User::CURATOR )
        end
        
        it "should not be logged in" do
            @user.should_not be_logged_in
        end
    
        describe "once saved" do
            before(:each) do
                @user.save!
            end
        
            it "should be logged in" do
                @user.should be_logged_in
            end
        
            it "but then be turned off (i.e. not logged in)" do
                @user.log_out
                @user.should_not be_logged_in
            end
        end
    end

    describe "enforcing unique email" do
        before(:each) do
            @user = Factory.create(:user, :role => User::DIRECTOR )
        end
        
        it do
            @user.should be_valid
        end
        
        describe "a second user with same address" do
            before(:each) do
                @user2 = User.new( @user.attributes )
            end
            
            it "should not be valid" do
                @user2.should_not be_valid
            end
            
            it "should already be in the system" do
                @user2.save
                @user2.already_exists?.should be_true
            end
        end
    end

    describe "enforcing password" do
        it "should not be valid without a passowrd" do
            returning Factory.build(:user, :password => nil, :password_confirmation => nil ) do |user|
                user.make_curator
            end.should_not be_valid
        end

        it "admins" do
            returning Factory.build( :user, :password => nil, :password_confirmation => nil ) do |user|
                user.role = User::ADMIN
            end.should_not be_valid
        end

        describe "but then once saved ..." do
            before(:each) do
                @admin = Factory.build( :user, :password => '987654', :password_confirmation => '987654' )
                @admin.role = User::ADMIN
            end

            it "should be valid" do
                @admin.save!
            end

            describe "then reloaded" do
                before(:each) do
                    @admin.save!
                    @reloaded = User.find( @admin.id )
                end

                it "should be able to save again without needing password" do
                    @reloaded.save!
                end
            end
        end
    end

end


# == Schema Information
#
# Table name: users
#
#  id                              :integer         not null, primary key
#  email                           :string(255)
#  crypted_password                :string(40)
#  salt                            :string(40)
#  name                            :string(255)
#  created_at                      :datetime
#  updated_at                      :datetime
#  last_logged_in_at               :datetime
#  anonymous_login_code            :string(255)
#  phone                           :string(255)
#  remember_me_code                :string(255)
#  anonymous_login_code_created_at :datetime
#  is_placement                    :boolean         default(FALSE)
#  role                            :string(255)
#

