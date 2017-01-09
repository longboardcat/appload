require 'awesome_print'
require 'colored'
require 'pliney'
require 'yaml'

module Appload
  class Runner
    attr_accessor :options

    def self.start
      new.run
    end

    def run
      puts "Appload #{Appload::VERSION}"
      @options = Appload::Options.new.options

      Pliney::IPA.from_path(options[:ipa_path]) do |ipa|
        @ipa = ipa

        actions.each do |action|
          send(action)
          prompt_user
        end
      end

      submit!
    end

    def actions
      [:check_ipa_action, :check_info_plist_action, :check_mpp_action]
    end

    def check_ipa_action
      puts 'Please verify the following .ipa information:'
      ap ({ path: @options[:ipa_path],
            bundle_id: @ipa.bundle_identifier,
            bundle_version: @ipa.bundle_version })
    end

    def check_info_plist_action
      ap(@ipa.info_plist, index: false)
    end

    def check_mpp_action
      profile = @ipa.provisioning_profile

      if !profile
        puts 'No provisioning profile found in the .ipa!'.red
        return
      elsif profile.expired?
        puts 'Provisioning profile expired!'.red
        return
      end

      cert = profile.developer_certificates.first
      fingerprint = OpenSSL::Digest::SHA1.new(cert.to_der).to_s.upcase

      ap 'Please verify the following provisioning profile information:'
      sleep(1)

      ap({
           name: profile.name,
           team_id: profile.team_identifier,
           SHA1: fingerprint,
           devices: profile.provisioned_devices,
           expiration: profile.expiration_date,
           entitlements: profile.entitlements.ents
         }, index: false)
    end

    def submit!
      command = ['deliver', '--ipa', @options[:ipa_path]]
      print 'Submit for review? '.green
      command << '--submit_for_review' if yes?

      puts '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'.red
      puts '% Are you sure you want to submit? %'.red
      puts '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'.red

      if yes?
        puts
        puts 'Run this command:'.green
        puts command.join(' ')
      end
    end

    def prompt_user(message = 'Continue?', fail_hard = true)
      print "#{message} ".green

      if yes?
        true
      else
        exit if fail_hard
        false
      end
    end

    def yes?
      %w(y Y).include?(STDIN.gets.chomp)
    end
  end
end
