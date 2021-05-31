# rubocop:disable LineLength

desc "Installs the required certificates on your machine using fastlane match"
lane :install_match_dependencies do
  authenticate

  sync_code_signing(type: "development",
  readonly: true)

  sync_code_signing(type: "appstore",
  readonly: true)
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
