require "spec_helper"

describe Flip::AbstractStrategy do
  its(:name) { should == "abstract" }
  its(:description) { should == "" }
  it { should_not be_switchable }
end
