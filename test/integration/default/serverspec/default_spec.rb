#
# Cookbook Name:: heroku-toolbelt
# Serverspec:: default
#
# Copyright (C) 2014 Patrick Ayoup
#
# MIT License
#

require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe 'heroku-toolbelt' do
  describe package('wget') do
    it { should be_installed }
  end

  describe package('git') do
    it { should be_installed }
  end

  describe 'ubuntu install', :if => os[:family] == 'Ubuntu' do
    describe package('foreman') do
      it { should be_installed }
    end

    describe package('heroku') do
      it { should be_installed }
    end

    describe file('/usr/local/heroku') do
      it { should be_directory }
    end
  end

  describe 'centos install', :if => os[:family] == "RedHat7" do
    describe file('/usr/local/heroku') do
      it { should be_directory }
    end

    describe package('ruby') do
      it { should be_installed }
    end

    describe package('foreman') do
      it { should be_installed.by('gem') }
    end

    describe file('/bin/heroku') do
      it { should be_linked_to '/usr/local/heroku/bin/heroku' }
    end
  end
end