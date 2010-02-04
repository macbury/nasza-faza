class CreateAdminUser < ActiveRecord::Migration
  def self.up
    user = User.new(:login => 'macbury', :password => 'alecool', :password_confirmation => 'alecool', :email => 'macbury@gmail.com', :regulamin => true)
    user.admin = true
    user.save
  end

  def self.down
  end
end
