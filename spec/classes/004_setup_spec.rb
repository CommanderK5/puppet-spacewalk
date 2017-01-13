require 'spec_helper'

describe 'spacewalk::setup' do
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

  context 'with params' do
    let(:params) do
      default_params
    end

    describe 'with defaults' do
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('spacewalk::setup') }
      it { is_expected.to contain_file('/etc/sysconfig/spacewalk.answer') }
      it { is_expected.to contain_exec('spacewalk-setup').with_command('/usr/bin/spacewalk.sh') }
      it { is_expected.to contain_exec('spacewalk-setup').that_requires(['File[/usr/bin/spacewalk.sh]', 'File[/etc/sysconfig/spacewalk.answer]']) }
      it do
        is_expected.to contain_file('/usr/bin/spacewalk.sh').with(content: %r{^#!/bin/bash\nspacewalk-setup.+--answer-file=\/etc\/sysconfig\/spacewalk\.answer\s+?--non-interactive\s+?--skip-db-diskspace-check(\s+)?}m)
      end
    end

    describe 'with setup options' do
      let(:params) do
        {
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
          re_register_opt: true,
          clear_db_opt: true,
          skip_selinux_test_opt: false,
          skip_db_diskspace_check_opt: true,
          skip_db_install_opt: false,
          skip_fqdn_test_opt: false,
          skip_db_population_opt: false
        }
      end
      it do
        is_expected.to contain_file('/usr/bin/spacewalk.sh').with(content: %r{^#!/bin/bash\nspacewalk-setup.+--answer-file=\/etc\/sysconfig\/spacewalk\.answer\s+?--non-interactive\s+?--re-register\s+?--clear-db(\s+)?}m)
      end
    end

    describe 'with skip options' do
      let(:params) do
        {
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
          skip_selinux_test_opt: true,
          skip_db_diskspace_check_opt: true,
          skip_db_install_opt: true,
          skip_fqdn_test_opt: true,
          skip_db_population_opt: true
        }
      end
      it do
        is_expected.to contain_file('/usr/bin/spacewalk.sh').with(content: %r{^#!/bin/bash\nspacewalk-setup.+--answer-file=\/etc\/sysconfig\/spacewalk\.answer\s+?--non-interactive\s+?--skip-db-diskspace-check\s+?--skip-selinux-test\s+?--skip-db-install\s+?--skip-db-population\s+?--skip-fqdn-test(\s+)?}m)
      end
    end
  end
end
