# submit_to_beta_app_review plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-submit_to_beta_app_review)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-submit_to_beta_app_review`, add it to your project by running:

```bash
fastlane add_plugin submit_to_beta_app_review
```

## About submit_to_beta_app_review

This is a plugin that adds a single action that submits a processed iTunes Connect build to Beta App Review. I wrote this since the existing fastlane `deliver` action requires a build be uploaded to submit a build to Beta App Review.

## Example

```ruby
beta_app_review_information = {
  changelog: '...',
  review_first_name: '...',
  review_last_name: '...',
  review_email: '...',         # Your contact email
  review_phone_number: '...',  # Your phone number
  review_notes: '...',         # Any notes you'd like to provide
  review_demo_user: '...',     # The user name Beta App Review can use to sign in to your app
  review_demo_password: '...', # The password Beta App Review can use to sign in to your app
}

submit_to_beta_app_review(
  bundle_identifier: "com.yourcompanyname.app",
  itc_team_id: "123456", # Optional
  build_number: "100",
  beta_app_review_information: beta_app_review_information
)
```

Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo, running `fastlane install_plugins` and `bundle exec fastlane test`.

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
