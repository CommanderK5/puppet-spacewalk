require 'spec_helper'

describe 'spacewalk::packages' do
  context 'with defaults' do
    let(:params) { { db_backend: 'postgresql', postgresql_embedded: true } }
    it { is_expected.to contain_package('spacewalk-postgresql') }
    it { is_expected.to contain_package('spacewalk-setup-postgresql') }
    it { is_expected.not_to contain_package('spacewalk-oracle') }
  end

  context 'db_backend => postgresql' do
    let(:params) { { db_backend: 'postgresql', postgresql_embedded: false } }
    it { is_expected.to contain_package('spacewalk-postgresql') }
    it { is_expected.not_to contain_package('spacewalk-setup-postgresql') }
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
