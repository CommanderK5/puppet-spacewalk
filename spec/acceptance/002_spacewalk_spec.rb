require 'spec_helper_acceptance'

describe 'class spacewalk:' do
  context 'with defaults:' do
    it 'runs successfully' do
      pp = "class { 'spacewalk': }"

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(/error/i)
      end

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to eq(/error/i)

        expect(r.exit_code).to be_zero
      end
    end
  end

  context 'service_ensure => stopped:' do
    it 'stops successfully' do
      pp = "class { 'spacewalk': service_ensure => stopped }"

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(/error/i)
      end
    end
  end

  context 'service_ensure => running:' do
    it 'runs successfully' do
      pp = "class { 'spacewalk': service_ensure => running }"

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(/error/i)
      end
    end
  end
end
