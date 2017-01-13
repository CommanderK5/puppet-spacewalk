require 'spec_helper_acceptance'

describe 'class spacewalk:package:' do
  context 'postgresql_embedded => true:' do
    it 'runs successfully' do
      pp = "class { 'spacewalk': db_backend => postgresql, postgresql_embedded => true }"

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(/error/i)
      end
    end
    describe package('spacewalk-postgresql') do
      it { is_expected.to be_installed }
    end
    describe package('spacewalk-setup-postgresql') do
      it { is_expected.to be_installed }
    end
    describe service('postgresql') do
      it { is_expected.to be_running }
    end
    describe service('jabberd') do
      it { is_expected.to be_running }
    end
    describe service('httpd') do
      it { is_expected.to be_running }
    end
    describe service('tomcat') do
      it { is_expected.to be_running }
    end
    describe service('osa-dispatcher') do
      it { is_expected.to be_running }
    end
    describe service('rhn-search') do
      it { is_expected.to be_running }
    end
    describe service('cobblerd') do
      it { is_expected.to be_running }
    end
    describe command('spacewalk-service status') do
      its(:exit_status) { is_expected.to eq 0 }
    end
    describe port(80) do
      it { is_expected.to be_listening }
    end
    describe port(443) do
      it { is_expected.to be_listening }
    end
    describe port(5432) do
      it { is_expected.to be_listening }
    end
  end
end
