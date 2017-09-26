module Fastlane
  module Actions
    class SubmitToBetaAppReviewAction < Action
      def self.run(params)
        UI.message("The submit_to_beta_app_review plugin is working!")
      end

      def self.description
        "Submits an already processed build to Beta App Review."
      end

      def self.authors
        ["Dan Loewenherz"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "Submits an already processed build to Beta App Review."
      end

      def self.available_options
        [
          # FastlaneCore::ConfigItem.new(key: :your_option,
          #                         env_name: "SUBMIT_TO_BETA_APP_REVIEW_YOUR_OPTION",
          #                      description: "A description of your option",
          #                         optional: false,
          #                             type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Platforms.md
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
