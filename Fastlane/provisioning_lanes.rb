# rubocop:disable LineLength

desc "Installs the required certificates on your machine using fastlane match"
lane :install_match_dependencies do
  authenticate

  match_configuration(
    type: "develop",
    readonly: true)

  match_configuration(
    type: "appstore",
    readonly: true)
end

desc "Update the development certificates and profiles using fastlane match"
lane :update_match_development_dependencies do
  match_configuration(
    type: "development",
    readonly: false
  )
end

desc "Update the appstore certificates and profiles using fastlane match"
lane :update_match_appstore_dependencies do
  match_configuration(
    type: "appstore",
    readonly: false
  )
end

desc "A convenience method for using fastlane match"
desc ""
desc "####{ }"
private_lane :match_configuration do |options|
  api_key = authenticate

  sync_code_signing(
    type: options[:type],
    api_key: api_key,
    readonly: options[:readonly]
  )
end

desc "Adds a new device to your developer account."
lane :add_device do
  device_name = prompt(text: "Enter the device name: ")
  device_udid = prompt(text: "Enter the device UDID: ")

  device_hash = {}
  device_hash[device_name] = device_udid

  authenticate

  register_devices(
    devices: device_hash,
    team_id: ENV["FASTLANE_TEAM_ID"]
  )

  sign
end

desc "Download and refresh profiles for local development"
private_lane :sign do
  match(type: "development", force: true)
  match(type: "adhoc", force: true)
  match(type: "appstore", force: true)
end
