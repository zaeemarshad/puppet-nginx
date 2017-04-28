require 'spec_helper'

describe 'nginx::config' do
  let(:pre_condition) do
    <<-EOF
    service { 'nginx': }
    EOF
  end

  let(:title) { 'foo' }

  context "with neither source or content specified" do
    it { is_expected.not_to compile }
  end

  context "with source specified" do
    let(:params) { {:source => '/home/foo.conf'} }

    it { is_expected.to compile }
    it { is_expected.to contain_nginx__config('foo') }
    it { is_expected.to contain_file('/etc/nginx/conf.d/foo.conf').with_source('/home/foo.conf') }

    context "and custom path" do
      let(:params) {
        super().merge(
          :path => '/etc/nginx/my_config.conf',
        )
      }

      it { is_expected.to contain_file('/etc/nginx/my_config.conf').with_source('/home/foo.conf') }
    end
  end

  context "with content specified" do
    let(:params) { {:content => 'some content'} }

    it { is_expected.to compile }
    it { is_expected.to contain_nginx__config('foo') }
    it { is_expected.to contain_file('/etc/nginx/conf.d/foo.conf').with_content('some content') }

    context "and custom path" do
      let(:params) {
        super().merge(
          :path => '/etc/nginx/my_config.conf',
        )
      }

      it { is_expected.to contain_file('/etc/nginx/my_config.conf').with_content('some content') }
    end
  end
end
