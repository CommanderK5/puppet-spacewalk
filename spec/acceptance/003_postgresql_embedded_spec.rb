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
      it { should be_installed }
    end
    describe package('spacewalk-setup-postgresql') do
      it { should be_installed }
    end
    describe service('postgresql') do
      it { should be_running }
    end
    describe service('jabberd') do
      it { should be_running }
    end
    describe service('httpd') do
      it { should be_running }
    end
    describe service('tomcat') do
      it { should be_running }
    end
    describe service('osa-dispatcher') do
      it { should be_running }
    end
    describe service('rhn-search') do
      it { should be_running }
    end
    describe service('cobblerd') do
      it { should be_running }
    end
    describe command('spacewalk-service status') do
      its(:exit_status) { should eq 0 }
    end
    describe port(80) do
      it { should be_listening }
    end
    describe port(443) do
      it { should be_listening }
    end
    describe port(5432) do
      it { should be_listening }
    end
  end
end
