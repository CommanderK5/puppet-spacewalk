require 'spec_helper_acceptance'

describe 'class spacewalk:package:' do
  context 'set env:' do
    it 'spacewalk: service_ensure => stopped' do
      pp = "class { 'spacewalk': service_ensure => stopped }"
      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(/error/i)
      end
    end
    shell('rm -rf /etc/sysconfig/spacewalk.answer')

    it 'setup postgresql db' do
      shell('spacewalk-setup-postgresql remove --db spaceschema --user spaceuser')
      shell('spacewalk-setup-postgresql remove --db spacedb --user user')
      shell('spacewalk-setup-postgresql create --db spacedb --user user --password mypassword --address * --remote 0.0.0.0/0  --standalone')
    end
  end

  context 'postgresql_embedded => false:' do
    it 'runs successfully' do
      pp = "class { 'spacewalk': db_backend => postgresql, postgresql_embedded => false,
            db_name => spacedb, db_user => user, db_password => mypassword, skip_db_install_opt => true }"

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(/error/i)
      end
    end
  end
end
