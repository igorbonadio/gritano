require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Gritano::CLI
  describe Helpers do

    before(:each) do
      @object = Object.new
      @object.extend(Helpers)
    end

    describe "#create" do
      it "should create valid models" do
        model = double("Model")
        instance = double("Instance")
        params = {param: 'value'}
        model.should_receive(:new).with(params).and_return(instance)
        model.stub(:name).and_return("Module::Class")
        instance.should_receive(:save).and_return(true)
        @object.should_receive(:render_text).with(/was successfully created/)
        @object.create_model(model, params)
      end

      it "should not create invalid models" do
        model = double("Model")
        instance = double("Instance")
        params = {param: 'value'}
        model.should_receive(:new).with(params).and_return(instance)
        model.stub(:name).and_return("Module::Class")
        instance.should_receive(:save).and_return(false)
        @object.should_receive(:render_text).with(/an error occurred/, :error)
        @object.create_model(model, params)
      end
    end

    describe "#update" do
      it "should update valid parameters" do
        instance = double("Instance")
        params = {param: 'value'}
        instance.should_receive(:update_attributes).with(params).and_return(true)
        @object.should_receive(:render_text).with(/was successfully updated/)
        @object.update_model(instance, params)
      end

      it "should not update invalid parameters" do
        instance = double("Instance")
        params = {param: 'value'}
        instance.should_receive(:update_attributes).with(params).and_return(false)
        @object.should_receive(:render_text).with(/an error occurred/, :error)
        @object.update_model(instance, params)
      end
    end

    describe "#destroy" do
      it "should destroy valid instances" do
        model = double("Model")
        instance = double("Instance")
        params = {param: 'value'}
        model.should_receive(:where).with(params).and_return([instance])
        model.stub(:name).and_return("Module::Class")
        instance.should_receive(:destroy).and_return(true)
        @object.should_receive(:render_text).with(/was successfully destroyed/)
        @object.destroy_model(model, params)
      end

      it "should not destroy invalid instances" do
        model = double("Model")
        params = {param: 'value'}
        model.should_receive(:where).with(params).and_return([])
        model.stub(:name).and_return("Module::Class")
        @object.should_receive(:render_text).with(/doens't exist/, :error)
        @object.destroy_model(model, params)
      end
    end

    describe "#use_if" do
      it "should use non-nil objects" do
        obj = double("NonNil")
        obj.should_receive(:touch)
        @object.use_if_not_nil(true) { obj.touch }
      end

      it "should not use nil objects" do
        obj = double("Nil")
        obj.should_not_receive(:touch)
        @object.should_receive(:render_text).with(/an error occurred/, :error)
        @object.use_if_not_nil(nil) { obj.touch }
      end
    end

    describe "#change_access" do
      it "should change valid access" do
        user = double("User")
        repo = double("Repo")
        user.should_receive(:send).and_return(true)
        @object.should_receive(:render_text).with(/done/)
        @object.try_change_access(user, repo, :add, :read)
      end

      it "should not change invalid access" do
        user = double("User")
        repo = double("Repo")
        user.should_receive(:send).and_return(false)
        @object.should_receive(:render_text).with(/an error occurred/, :error)
        @object.try_change_access(user, repo, :add, :read)
      end
    end

    it "should help to check if an option is valid" do
      @object.valid_options?({}).should be_nil
      @object.valid_options?({some: :thing}).should be_true
    end
  end
end
