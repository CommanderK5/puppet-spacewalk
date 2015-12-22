require 'spec_helper'

describe 'spacewalk::packages' do
  on_supported_os(supported_os: [
    {
      'operatingsystem' => 'CentOS',
      'operatingsystemrelease' => %w(6 7)
    },
    {
      'operatingsystem' => 'RedHat',
      'operatingsystemrelease' => %w(6 7)
    }
  ]).each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'db_backend => postgresql' do
        let(:params) { { db_backend: 'postgresql', postgresql_embedded: false } }
        it { is_expected.to contain_package('spacewalk-postgresql') }
        it { is_expected.not_to contain_package('spacewalk-setup-postgresql') }
        it { is_expected.not_to contain_package('spacewalk-oracle') }
      end

      context 'db_backend => postgresql_embedded' do
        let(:params) { { db_backend: 'postgresql', postgresql_embedded: true } }
        it { is_expected.to contain_package('spacewalk-postgresql') }
        it { is_expected.to contain_package('spacewalk-setup-postgresql') }
        it { is_expected.not_to contain_package('spacewalk-oracle') }
      end

      context 'db_backend => oracle' do
        let(:params) { { db_backend: 'oracle', postgresql_embedded: false } }
        it { is_expected.not_to contain_package('spacewalk-postgresql') }
        it { is_expected.not_to contain_package('spacewalk-setup-postgresql') }
        it { is_expected.to contain_package('spacewalk-oracle') }
      end

      context 'db_backend => oracle' do
        let(:params) { { db_backend: 'oracle', postgresql_embedded: false } }
        it { is_expected.not_to contain_package('spacewalk-postgresql') }
        it { is_expected.not_to contain_package('spacewalk-setup-postgresql') }
        it { is_expected.to contain_package('spacewalk-oracle') }
      end

      context 'db_backend => mydb' do
        let(:params) { { db_backend: 'mydb', postgresql_embedded: false } }
        it { is_expected.to compile.and_raise_error(/Unsupported backend/) }
      end
    end
  end
end
