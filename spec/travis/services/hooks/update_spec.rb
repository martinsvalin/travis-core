require 'spec_helper'

describe Travis::Services::Hooks do
  include Support::ActiveRecord

  let(:user)    { User.first || Factory(:user) }
  let(:repo)    { Factory(:repository) }
  let(:service) { Travis::Services::Hooks::Update.new(user, params) }

  before :each do
    user.permissions.create!(:repository => repo, :admin => true)
  end

  let(:params) { { :id => repo.id, :active => 'true' } }

  it 'sets the given :active param to the hook' do
    ServiceHook.any_instance.expects(:set).with(true, user)
    service.run
  end
end
