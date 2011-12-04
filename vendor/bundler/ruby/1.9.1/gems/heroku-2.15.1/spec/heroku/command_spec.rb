require "spec_helper"
require "heroku/command"
require 'json' #FOR WEBMOCK

describe Heroku::Command do
  before { Heroku::Command.load }

  describe "when the command requires confirmation" do

    let(:response_that_requires_confirmation) do
      {:status => 423,
       :headers => { :x_confirmation_required => 'my_addon' },
       :body => 'terms of service required'}
    end

    context "when the app is unknown" do
      context "and the user includes --confirm APP" do
        it "should set --app to APP and not ask for confirmation" do
          stub_request(:post, %r{apps/XXX/addons/my_addon$}).
            with(:body => {:confirm => "XXX"})
          run "addons:add my_addon --confirm XXX"
        end
      end

      context "and the user includes --confirm APP --app APP2" do
        it "should warn that the app and confirm do not match and not continue" do
          Heroku::Command.should_receive(:error).with("Mismatch between --app and --confirm")
          run "addons:add my_addon --confirm APP --app APP2"
        end
      end
    end

    context "and the app is known" do
      before do
        any_instance_of(Heroku::Command::Base) do |base|
          stub(base).extract_app.returns("myapp")
        end
      end

      context "and the user includes --confirm WRONGAPP" do
        it "should not allow include the option" do
          stub_request(:post, %r{apps/myapp/addons/my_addon$}).
            with(:body => "")
          run "addons:add my_addon --confirm XXX"
        end
      end

      context "and the user includes --confirm APP" do
        it "should set --app to APP and not ask for confirmation" do
          stub_request(:post, %r{apps/myapp/addons/my_addon$}).
            with(:body => {:confirm => 'myapp'})

          run "addons:add my_addon --confirm myapp"
        end
      end

      context "and the user didn't include a confirm flag" do
        it "should ask the user for confirmation" do
          stub(Heroku::Command).confirmation_required.returns(true)
          stub_request(:post, %r{apps/myapp/addons/my_addon$}).
            to_return(response_that_requires_confirmation).then.
            to_return({:status => 200})

          run "addons:add my_addon"
        end

        it "should not continue if the user doesn't confirm" do
          stub(Heroku::Command).confirmation_required.returns(false)
          stub_request(:post, %r{apps/myapp/addons/my_addon$}).
            to_return(response_that_requires_confirmation).then.
            to_raise(StandardError)

          run "addons:add my_addon"
        end
      end
    end
  end

  describe "parsing errors" do
    it "extracts error messages from response when available in XML" do
      Heroku::Command.extract_error('<errors><error>Invalid app name</error></errors>').should == ' !   Invalid app name'
    end

    it "extracts error messages from response when available in JSON" do
      Heroku::Command.extract_error("{\"error\":\"Invalid app name\"}").should == ' !   Invalid app name'
    end

    it "extracts error messages from response when available in JSON" do
      response = mock(:to_s => "Invalid app name", :headers => { :content_type => "text/plain; charset=UTF8" })
      Heroku::Command.extract_error(response).should == ' !   Invalid app name'
    end

    it "shows Internal Server Error when the response doesn't contain a XML or JSON" do
      Heroku::Command.extract_error('<h1>HTTP 500</h1>').should == ' !   Internal server error'
    end

    it "shows Internal Server Error when the response is not plain text" do
      response = mock(:to_s => "Foobar", :headers => { :content_type => "application/xml" })
      Heroku::Command.extract_error(response).should == ' !   Internal server error'
    end

    it "allows a block to redefine the default error" do
      Heroku::Command.extract_error("Foobar") { "Ok!" }.should == ' !   Ok!'
    end

    it "doesn't format the response if set to raw" do
      Heroku::Command.extract_error("Foobar", :raw => true) { "Ok!" }.should == 'Ok!'
    end

    it "handles a nil body in parse_error_xml" do
      lambda { Heroku::Command.parse_error_xml(nil) }.should_not raise_error
    end

    it "handles a nil body in parse_error_json" do
      lambda { Heroku::Command.parse_error_json(nil) }.should_not raise_error
    end
  end

  it "correctly resolves commands" do
    class Heroku::Command::Test; end
    class Heroku::Command::Test::Multiple; end

    require "heroku/command/help"
    require "heroku/command/apps"

    Heroku::Command.parse("unknown").should be_nil
    Heroku::Command.parse("list").should include(:klass => Heroku::Command::Apps, :method => :index)
    Heroku::Command.parse("apps").should include(:klass => Heroku::Command::Apps, :method => :index)
    Heroku::Command.parse("apps:create").should include(:klass => Heroku::Command::Apps, :method => :create)
  end
end
