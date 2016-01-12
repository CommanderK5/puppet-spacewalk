require 'spec_helper'

describe 'spacewalk::service' do
  context 'with params' do
    describe 'with defaults' do
      let(:params) { { service_ensure: 'running' } }
      it { is_expected.to contain_class('spacewalk::service') }
      it { is_expected.to contain_service('spacewalk-service') }
    end

    describe 'with service_ensure running:' do
      let(:params) { { service_ensure: 'running' } }
      it { is_expected.to contain_service('spacewalk-service').with('ensure' => 'running') }
    end

    describe 'with service_ensure stopped:' do
      let(:params) { { service_ensure: 'stopped' } }
      it { is_expected.to contain_service('spacewalk-service').with('ensure' => 'stopped') }
    end
  end
end
