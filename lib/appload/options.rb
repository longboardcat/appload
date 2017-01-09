require 'optparse'

module Appload
  # This class handles argument parsing
  class Options
    attr_reader :options

    def initialize
      @options = {}
      parse_args
    end

    # Parsing arguments into hash form
    def parse_args
      raise 'Need to specify ipa path' unless ARGV[0]

      OptionParser.new do |opts|
        opts.banner = 'Usage: appload ipa'

        opts.on('-h', '--help', 'Display usage') do
          puts 'Usage: appload ipa'
          exit
        end

        @options[:ipa_path] = ARGV[0]
      end
    end
  end
end
