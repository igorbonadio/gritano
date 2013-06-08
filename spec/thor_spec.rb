require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Gritano::CLI
  describe Thor do
    it "should define tasks" do
      Thor.should respond_to(:define_task)
    end

    it "should define an instance method for a task" do
      Thor.define_task("gritano:task") do end
      Thor.new.should respond_to("gritano:task")
    end

    it "should define a description for a task" do
      Thor.should_receive(:desc).with("gritano:task", "some gritano task")
      Thor.define_task("gritano:task", "some gritano task") do end
    end

    it "should define a description for a task that have parameters" do
      Thor.should_receive(:desc).with("gritano:task NAME ORDER", "some gritano task")
      Thor.define_task("gritano:task", "some gritano task") do |name, order| end
    end

    it "should define a simple description for a task that doens't have description" do
      Thor.should_receive(:desc).with("gritano:task NAME ORDER", "")
      Thor.define_task("gritano:task") do |name, order| end
    end
  end
end
