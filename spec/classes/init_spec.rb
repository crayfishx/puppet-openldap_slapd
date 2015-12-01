require 'spec_helper'
describe 'openldap_slapd' do

  context 'with defaults for all parameters' do
    it { should contain_class('openldap_slapd') }
  end
end
