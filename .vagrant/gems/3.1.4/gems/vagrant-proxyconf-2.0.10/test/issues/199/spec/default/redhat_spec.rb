require 'spec_helper'

describe package('tinyproxy') do
  it { should be_installed }
end

describe service('tinyproxy') do
  it { should be_enabled }
  it { should be_running }
end


describe port(8888) do
  it { should be_listening }
end
