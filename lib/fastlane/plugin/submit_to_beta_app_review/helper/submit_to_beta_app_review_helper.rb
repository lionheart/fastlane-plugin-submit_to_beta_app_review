module Fastlane
  module Helper
    class SubmitToBetaAppReviewHelper
      # class methods that you define here become available in your action
      # as `Helper::SubmitToBetaAppReviewHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the submit_to_beta_app_review plugin helper!")
      end
    end
  end
end
