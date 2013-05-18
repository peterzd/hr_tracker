require 'spec_helper'

describe Employee do
  helper_objects

  it 'sameer is the system_admin' do
    sameer.is_system_admin.should be_true
  end
end
