describe Fastlane::Actions::SubmitToBetaAppReviewAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The submit_to_beta_app_review plugin is working!")

      Fastlane::Actions::SubmitToBetaAppReviewAction.run(nil)
    end
  end
end
