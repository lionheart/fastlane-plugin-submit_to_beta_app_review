module Fastlane
  module Actions
    class SubmitToBetaAppReviewAction < Action
      def self.run(params)
        UI.message("Login to iTunes Connect (#{params[:username]})")
        Spaceship::Tunes::login(params[:username])
        Spaceship::Tunes.select_team
        UI.message("Login successful")

        app = Spaceship::Tunes::Application.find(params[:app_id] || params[:bundle_id])

        version = app.edit_version
        build = version.candidate_builds.find { |b| b.build_version == params[:build_number] }
        UI.message("Submitting to Beta App Review...")

        begin
          build.submit_for_beta_review!(params[:beta_app_review_information])
          UI.message("Submitted! 🎉")
        rescue
          UI.message("An iTunes Connect error was encountered and the build was not submitted")
        end
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Submits an already processed build to Beta App Review."
      end

      def self.details
        "This action submits an already processed build to Beta App Review."
      end

      def self.available_options
        user = CredentialsManager::AppfileConfig.try_fetch_value(:itunes_connect_id)
        user ||= CredentialsManager::AppfileConfig.try_fetch_value(:apple_id)

        default_app_identifier = CredentialsManager::AppfileConfig.try_fetch_value(:app_identifier)
        [
          FastlaneCore::ConfigItem.new(
            key: :bundle_id,
            env_name: "FL_BETAREVIEW_BUNDLE_ID",
            description: "Bundle ID of the application",
            optional: true,
            conflicting_options: [:app_id],
          ),

          FastlaneCore::ConfigItem.new(
            key: :app_id,
            env_name: "FL_BETAREVIEW_APP_ID",
            description: "Apple ID of the application",
            optional: true,
            conflicting_options: [:bundle_id],
            is_string: true,
            default_value: default_app_identifier
          ),

          FastlaneCore::ConfigItem.new(
            key: :username,
            short_option: "-u",
            env_name: "FL_BETAREVIEW_USER",
            description: "Your Apple ID Username",
            default_value: user
          ),

          FastlaneCore::ConfigItem.new(
            key: :team_id,
            short_option: "-k",
            env_name: "FL_BETAREVIEW_TEAM_ID",
            description: "The ID of your iTunes Connect team if you're in multiple teams",
            optional: true,
            is_string: false,
            default_value: CredentialsManager::AppfileConfig.try_fetch_value(:itc_team_id),
            verify_block: proc do |value|
              ENV["FASTLANE_ITC_TEAM_ID"] = value.to_s
            end
          ),

          FastlaneCore::ConfigItem.new(
            key: :build_number,
            env_name: "FL_BETAREVIEW_BUILD_NUMBER",
            description: "Build number",
            optional: false,
            is_string: true
          ),

          FastlaneCore::ConfigItem.new(
            key: :beta_app_review_information,
            description: "Metadata: A hash containing the beta app review information",
            optional: true,
            is_string: false
          ),
        ]
      end

      def self.output
        [
          ['SUBMIT_TO_BETA_APP_REVIEW_CUSTOM_VALUE', 'A description of what this value contains']
        ]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.authors
        ["dwlz"]
      end

      def self.is_supported?(platform)
        platform == :ios
      end
    end
  end
end
