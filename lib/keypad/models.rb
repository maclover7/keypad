module Keypad
  module Models

    def self.keypad(*providers)
      # Remove duplicate providers
      selected_providers = providers.map(&:to_s).uniq

      # Check and see if specified provider's have an associated OmniAuth strategy
      # Must be a descendant of OmniAuth::Strategies
      approved_providers = []
      denied_providers = []
      selected_providers.each do |provider|
        if ::OmniAuth::Strategies::OAuth2.descendants.any?
          ::OmniAuth::Strategies::OAuth2.descendants.each do |strategy|
            if strategy.to_s.downcase.include?(provider)
              approved_providers << provider
            else
              denied_providers << provider
            end
          end
        else
          denied_providers << provider
        end
      end

      unless denied_providers.empty?
        denied_providers.each do |provider|
          raise(LoadError.new("Could not find matching strategy for #{provider}. You may need to install an additional gem (such as omniauth-#{provider})."))
        end
      end

      { :approved => approved_providers }
    end

    private
      def camelize(word, first_letter_in_uppercase = true)
        if first_letter_in_uppercase
          word.to_s.gsub(%r{/(.?)}) { '::' + Regexp.last_match[1].upcase }.gsub(/(^|_)(.)/) { Regexp.last_match[2].upcase }
        else
          word.first + camelize(word)[1..-1]
        end
      end

      def to_camelizer(lower_case_and_underscored_word, first_letter_in_uppercase = true)
        if first_letter_in_uppercase
          lower_case_and_underscored_word.to_s.gsub(/\/(.?)/) { "::" + $1.upcase }.gsub(/(^|_)(.)/) { $2.upcase }
        else
          lower_case_and_underscored_word.first + camelize(lower_case_and_underscored_word)[1..-1]
        end
      end
  end
end
