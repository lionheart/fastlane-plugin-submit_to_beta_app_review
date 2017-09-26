module Fastlane
  module Actions
    class SubmitToBetaAppReviewAction < Action
      def self.run(params)
        UI.message("Login to iTunes Connect (#{params[:username]})")
        Spaceship::Tunes::login(params[:username])
        Spaceship::Tunes.select_team
        UI.message("Login successful")

        app = Spaceship::Tunes::Application.find(params[:apple_id] || params[:app_identifier])

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
        default_user = CredentialsManager::AppfileConfig.try_fetch_value(:itunes_connect_id)
        default_user ||= CredentialsManager::AppfileConfig.try_fetch_value(:apple_id)

        default_app_identifier = CredentialsManager::AppfileConfig.try_fetch_value(:app_identifier)
        default_itc_team_id = CredentialsManager::AppfileConfig.try_fetch_value(:itc_team_id)
        default_itc_team_name = CredentialsManager::AppfileConfig.try_fetch_value(:itc_team_name)
        [
          FastlaneCore::ConfigItem.new(
            key: :app_identifier,
            env_name: "BETAREVIEW_APP_IDENTIFIER",
            description: "The bundle identifier of your app",
            optional: true,
            conflicting_options: [:apple_id],
            default_value: default_app_identifier
          ),

          FastlaneCore::ConfigItem.new(
            key: :apple_id,
            env_name: "BETAREVIEW_APPLE_ID",
            description: "Apple ID of the application",
            optional: true,
            conflicting_options: [:app_identifier],
            is_string: true,
          ),

          FastlaneCore::ConfigItem.new(
            key: :username,
            env_name: "BETAREVIEW_USER",
            description: "Your Apple ID Username",
            default_value: default_user
          ),

          FastlaneCore::ConfigItem.new(
            key: :itc_team_id,
            env_name: "BETAREVIEW_TEAM_ID",
            description: "The ID of your iTunes Connect team if you're in multiple teams",
            optional: true,
            default_value: default_itc_team_id,
            verify_block: proc do |value|
              ENV["FASTLANE_ITC_TEAM_ID"] = value.to_s
            end
          ),

          FastlaneCore::ConfigItem.new(
            key: :itc_team_name,
            env_name: "BETAREVIEW_TEAM_NAME",
            description: "The name of your iTunes Connect team if you're in multiple teams",
            optional: true,
            default_value: default_itc_team_name,
            verify_block: proc do |value|
              ENV["FASTLANE_ITC_TEAM_NAME"] = value.to_s
            end
          ),

          FastlaneCore::ConfigItem.new(
            key: :build_number,
            env_name: "BETAREVIEW_BUILD_NUMBER",
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
      end

      def self.return_value
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
