require 'spec_helper'

describe 'spacewalk' do
  default_params = {
    db_backend: 'postgresql',
    postgresql_embedded: true,
    db_user: 'spacewalk',
    db_password: 'spacewalk',
    db_host: 'localhost',
    db_port: '3398',
    db_name: 'spacedb',
    admin_email: 'root2localhost',
    configure_apache_ssl: true,
    ca_cert_password: 'capassword',
    ca_organization: 'test',
    ca_organization_unit: 'spec test',
    ca_email_address: 'root@localhost',
    ca_city: 'any',
    ca_state: 'any',
    ca_country_code: 'AY',
    enable_tftp: true,
    disconnected_opt: true,
    re_register_opt: false,
    clear_db_opt: false,
    skip_selinux_test_opt: false,
    skip_db_diskspace_check_opt: true,
    skip_db_install_opt: false,
    skip_fqdn_test_opt: false,
    skip_db_population_opt: false
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
