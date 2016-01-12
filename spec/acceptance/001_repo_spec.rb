require 'spec_helper_acceptance'

case fact('osfamily')
when 'RedHat'
  case fact('operatingsystemmajrelease')
  when '7'
    release = '7'
  when '6'
    release = '6'
  end
else
  release = nil
end


describe 'spacewalk repo client class:' do
  describe 'run puppet' do
    it 'should run successfully' do
      pp = "class { 'spacewalk::repo::client': }"

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to eq(/error/i)
      end

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to eq(/error/i)
        expect(r.exit_code).to be_zero
      end
    end
  end

  describe 'client repo' do
    describe file('/etc/yum.repos.d/spacewalk-client.repo') do
      it { should exist }
      it { should be_file }
      it { should contain "http://yum.spacewalkproject.org/latest-client/RHEL/#{release}/$basearch/" }
    end
  end
end

describe 'spacewalk repo server class:' do
  describe 'run puppet' do
    it 'should run successfully' do
      pp = "class { 'spacewalk::repo::server': }"

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to eq(/error/i)
      end

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to eq(/error/i)
        expect(r.exit_code).to be_zero
      end
    end
  end

  describe 'server repo' do
    describe file('/etc/yum.repos.d/spacewalk.repo') do
      it { should exist }
      it { should be_file }
      it { should contain "http://yum.spacewalkproject.org/latest/RHEL/#{release}/$basearch/" }
    end
  end

  describe 'jpackage repo' do
    describe file('/etc/yum.repos.d/jpackage-generic.repo') do
      it { should exist }
      it { should be_file }
      it { should contain 'http://www.jpackage.org/mirrorlist.php?dist=generic&type=free&release=5.0' }
    end
  end
end
