require 'spec_helper'

describe 'spacewalk::repo::client' do
  default_params = {
    client_repo_enabled: '1',
    client_repo_gpgcheck: '1',
    client_repo_release: 'latest',
    client_repo_gpgkey: 'http://yum.spacewalkproject.org/RPM-GPG-KEY-spacewalk-2015'
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

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('spacewalk::repo::client') }

      case facts[:operatingsystemmajrelease]
      when '6'
        context 'has yum repo for 6 release' do
          it { is_expected.to contain_yumrepo('spacewalk-client').with(baseurl: 'http://yum.spacewalkproject.org/latest-client/RHEL/6/$basearch/') }
        end
      when '7'
        context 'has yum repo for 7 release' do
          it { is_expected.to contain_yumrepo('spacewalk-client').with(baseurl: 'http://yum.spacewalkproject.org/latest-client/RHEL/7/$basearch/') }
        end
      end

      context 'with defined spacewalk repo release' do
        let(:params) do
          default_params.merge(client_repo_release: '2.2')
        end

        case facts[:operatingsystemmajrelease]
        when '6'
          context 'has spacewalk client 2.2 repo for release 6' do
            it { is_expected.to contain_yumrepo('spacewalk-client').with(baseurl: 'http://yum.spacewalkproject.org/2.2-client/RHEL/6/$basearch/') }
          end
        when '7'
          context 'has spacewalk client 2.2 repo for release 7' do
            it { is_expected.to contain_yumrepo('spacewalk-client').with(baseurl: 'http://yum.spacewalkproject.org/2.2-client/RHEL/7/$basearch/') }
          end
        end
      end
    end
  end
end
