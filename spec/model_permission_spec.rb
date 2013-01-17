require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gritano
  describe Permission do
    
    def create_permission(access)
      permission = Permission.new
      access.each do |a|
        permission.add_access(a)
      end
      return permission
    end
    
    it "should add READ access" do
      permission = create_permission([])
      permission.add_access(:read)
      permission.is(:read).should be_true
      permission.is(:write).should be_false
    end
    
    it "should add WRITE access" do
      permission = create_permission([])
      permission.add_access(:write)
      permission.is(:write).should be_true
      permission.is(:read).should be_false
    end
    
    it "should add READ and WRITE access" do
      permission = create_permission([])
      permission.add_access(:read)
      permission.add_access(:write)
      permission.is(:write).should be_true
      permission.is(:read).should be_true
    end
    
    it "should remove READ access" do
      permission = create_permission([:read, :write])
      permission.remove_access(:read)
      permission.is(:read).should be_false
      permission.is(:write).should be_true
    end
    
    it "should remove WRITE access" do
      permission = create_permission([:read, :write])
      permission.remove_access(:write)
      permission.is(:write).should be_false
      permission.is(:read).should be_true
    end
    
    it "should remove READ and WRITE access" do
      permission = create_permission([:read, :write])
      permission.remove_access(:write)
      permission.remove_access(:read)
      permission.is(:write).should be_false
      permission.is(:read).should be_false
    end
  end
end