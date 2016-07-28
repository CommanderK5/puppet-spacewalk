require 'spec_helper'

describe 'spacewalk' do
  default_params = {
    db_backend: 'postgresql',
    postgresql_embedded: true,
    db_user: 'spacewalk',
    db_password: 'spacewalk',
    db_host: 'localhost',
    db_port: '3398',
    admin_email: 'root2localhost',
    configure_apache_ssl: true,
    ca_cert_password: 'capassword',
    ca_organization: 'test',
    ca_organization_unit: 'spec test',
    ca_email_address: 'root@localhost',
    ca_city: 'any',
    ca_state: 'any',
    ca_country_code: 'AY',
    enable_tftp: true
  }

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

      let(:params) do
        default_params
      end

      describe 'with defaults' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('spacewalk') }
        it { is_expected.to contain_class('spacewalk::params') }
        it { is_expected.to contain_class('spacewalk::packages') }
        it { is_expected.to contain_class('spacewalk') }
      end
    end
  end
end
