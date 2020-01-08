// swiftlint:disable line_length file_length

/// Used by `DangerTestExtensions.swift` for testing purposes. Some properties in here will be overriden for tests.
public let TestDSLGitHubJSON = """

{
  "danger": {
      "git": {
        "modified_files": [
          ".travis.yml",
          "Kiosk.xcodeproj/project.pbxproj",
          "Kiosk/App/Logger.swift",
          "Kiosk/App/Networking/NetworkLogger.swift",
          "Kiosk/App/Networking/Networking.swift",
          "Kiosk/App/Networking/XAppToken.swift",
          "Kiosk/Auction Listings/ListingsViewModel.swift",
          "Kiosk/HelperFunctions.swift",
          "Kiosk/Images.xcassets/AppIcon.appiconset/Contents.json",
          "KioskTests/Bid Fulfillment/ConfirmYourBidArtsyLoginViewControllerTests.swift",
          "KioskTests/Bid Fulfillment/ConfirmYourBidEnterYourEmailViewControllerTests.swift",
          "KioskTests/Bid Fulfillment/LoadingViewControllerTests.swift",
          "KioskTests/Bid Fulfillment/RegistrationEmailViewControllerTests.swift",
          "KioskTests/Bid Fulfillment/RegistrationPasswordViewModelTests.swift",
          "KioskTests/Bid Fulfillment/SwipeCreditCardViewControllerTests.swift",
          "KioskTests/ListingsViewControllerTests.swift",
          "KioskTests/Models/SaleArtworkTests.swift",
          "KioskTests/ReferenceImages/ListingsViewControllerTests/when_displaying_stubbed_contents__with_artworks_not_for_sale__a_listings_controller__alphabetical@2x.png",
          "KioskTests/ReferenceImages/ListingsViewControllerTests/when_displaying_stubbed_contents__with_artworks_not_for_sale__a_listings_controller__grid@2x.png",
          "KioskTests/ReferenceImages/ListingsViewControllerTests/when_displaying_stubbed_contents__with_artworks_not_for_sale__a_listings_controller__highest_bid@2x.png",
          "KioskTests/ReferenceImages/ListingsViewControllerTests/when_displaying_stubbed_contents__with_artworks_not_for_sale__a_listings_controller__least_bids@2x.png",
          "KioskTests/ReferenceImages/ListingsViewControllerTests/when_displaying_stubbed_contents__with_artworks_not_for_sale__a_listings_controller__lowest_bid@2x.png",
          "KioskTests/ReferenceImages/ListingsViewControllerTests/when_displaying_stubbed_contents__with_artworks_not_for_sale__a_listings_controller__most_bids@2x.png",
          "KioskTests/ReferenceImages/ListingsViewControllerTests/when_displaying_stubbed_contents__with_lot_numbers__a_listings_controller__alphabetical@2x.png",
          "KioskTests/ReferenceImages/ListingsViewControllerTests/when_displaying_stubbed_contents__with_lot_numbers__a_listings_controller__grid@2x.png",
          "KioskTests/ReferenceImages/ListingsViewControllerTests/when_displaying_stubbed_contents__with_lot_numbers__a_listings_controller__highest_bid@2x.png",
          "KioskTests/ReferenceImages/ListingsViewControllerTests/when_displaying_stubbed_contents__with_lot_numbers__a_listings_controller__least_bids@2x.png",
          "KioskTests/ReferenceImages/ListingsViewControllerTests/when_displaying_stubbed_contents__with_lot_numbers__a_listings_controller__lowest_bid@2x.png",
          "KioskTests/ReferenceImages/ListingsViewControllerTests/when_displaying_stubbed_contents__with_lot_numbers__a_listings_controller__most_bids@2x.png",
          "KioskTests/ReferenceImages/ListingsViewControllerTests/when_displaying_stubbed_contents__without_lot_numbers__a_listings_controller__alphabetical@2x.png",
          "KioskTests/ReferenceImages/ListingsViewControllerTests/when_displaying_stubbed_contents__without_lot_numbers__a_listings_controller__grid@2x.png",
          "KioskTests/ReferenceImages/ListingsViewControllerTests/when_displaying_stubbed_contents__without_lot_numbers__a_listings_controller__highest_bid@2x.png",
          "KioskTests/ReferenceImages/ListingsViewControllerTests/when_displaying_stubbed_contents__without_lot_numbers__a_listings_controller__least_bids@2x.png",
          "KioskTests/ReferenceImages/ListingsViewControllerTests/when_displaying_stubbed_contents__without_lot_numbers__a_listings_controller__lowest_bid@2x.png",
          "KioskTests/ReferenceImages/ListingsViewControllerTests/when_displaying_stubbed_contents__without_lot_numbers__a_listings_controller__most_bids@2x.png",
          "KioskTests/ReferenceImages/LoadingViewControllerTests/default__placing_a_bid@2x.png",
          "KioskTests/ReferenceImages/LoadingViewControllerTests/ending__placing_bid_error_due_to_outbid@2x.png",
          "KioskTests/ReferenceImages/LoadingViewControllerTests/ending__placing_bid_succeeded_but_not_resolved@2x.png",
          "KioskTests/ReferenceImages/LoadingViewControllerTests/ending__placing_bid_success_highest@2x.png",
          "KioskTests/ReferenceImages/LoadingViewControllerTests/ending__placing_bid_success_not_highest@2x.png",
          "KioskTests/ReferenceImages/LoadingViewControllerTests/ending__registering_user_not_resolved@2x.png",
          "KioskTests/ReferenceImages/LoadingViewControllerTests/ending__registering_user_success@2x.png",
          "KioskTests/ReferenceImages/LoadingViewControllerTests/errors__correctly_placing_a_bid@2x.png",
          "KioskTests/ReferenceImages/RegistrationEmailViewControllerTests/looks_right_by_default@2x.png",
          "KioskTests/ReferenceImages/RegistrationEmailViewControllerTests/looks_right_with_existing_email@2x.png",
          "KioskTests/ReferenceImages/RegistrationMobileViewControllerTests/looks_right_by_default@2x.png",
          "KioskTests/ReferenceImages/RegistrationMobileViewControllerTests/looks_right_with_existing_mobile@2x.png",
          "KioskTests/ReferenceImages/RegistrationPasswordViewControllerTests/looks_right_with_a_valid_password@2x.png",
          "KioskTests/ReferenceImages/RegistrationPasswordViewControllerTests/looks_right_with_an_invalid_password@2x.png",
          "KioskTests/ReferenceImages/RegistrationPostalZipViewControllerTests/looks_right_by_default@2x.png",
          "KioskTests/ReferenceImages/RegistrationPostalZipViewControllerTests/looks_right_with_existing_postal_code@2x.png",
          "KioskTests/ReferenceImages/YourBiddingDetailsViewControllerTests/displays_bidder_number_and_PIN@2x.png",
          "KioskTests/XAppTokenSpec.swift",
          "Podfile",
          "Podfile.lock"
        ],
        "created_files": [".ruby-version"],
        "deleted_files": [],
        "commits": [
          {
            "sha": "93ae30cf2aee4241c442fb3242543490998cffdb",
            "parents": ["68c8db83776c1942145f530159a3fffddb812577"],
            "author": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-07-26T19:54:16Z"
            },
            "committer": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-07-26T19:55:00Z"
            },
            "message": "[Xcode] Updates for compatibility with Xcode 7.3.1.",
            "tree": {
              "sha": "fb6bc3fda2456c5ff0a4e8f307f24ee73f281fc1",
              "url": "https://api.github.com/repos/artsy/eidolon/git/trees/fb6bc3fda2456c5ff0a4e8f307f24ee73f281fc1"
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/93ae30cf2aee4241c442fb3242543490998cffdb"
          },
          {
            "sha": "4cf1e41f72516a4135f1738c47f7dd3d421ff3c4",
            "parents": ["93ae30cf2aee4241c442fb3242543490998cffdb"],
            "author": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-07-26T19:55:53Z"
            },
            "committer": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-07-26T19:55:53Z"
            },
            "message": "[CI] Updates Travis to Xcode 7.3.",
            "tree": {
              "sha": "01f7e53a061a1df01e7d6d3a6fb4d2ce9ee0e39a",
              "url": "https://api.github.com/repos/artsy/eidolon/git/trees/01f7e53a061a1df01e7d6d3a6fb4d2ce9ee0e39a"
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/4cf1e41f72516a4135f1738c47f7dd3d421ff3c4"
          },
          {
            "sha": "d0d72ec5b5ee90c2513a8aafb48911ae5bcdf4ac",
            "parents": ["4cf1e41f72516a4135f1738c47f7dd3d421ff3c4"],
            "author": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-07-26T21:17:40Z"
            },
            "committer": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-07-26T21:17:40Z"
            },
            "message": "[Deps] Updates dependencies for Swift 2.2.",
            "tree": {
              "sha": "a30d9d8be16847c33eb50483a653f27475f197a4",
              "url": "https://api.github.com/repos/artsy/eidolon/git/trees/a30d9d8be16847c33eb50483a653f27475f197a4"
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/d0d72ec5b5ee90c2513a8aafb48911ae5bcdf4ac"
          },
          {
            "sha": "c330e8dfc6ae553a98fb9ffa6347f87d9f00f864",
            "parents": ["d0d72ec5b5ee90c2513a8aafb48911ae5bcdf4ac"],
            "author": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-08-15T20:41:00Z"
            },
            "committer": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-08-15T20:41:00Z"
            },
            "message": "[Tests] Cleans up snapshot tests for Xcode 7.3.1.",
            "tree": {
              "sha": "74f18cfa9f377497c46295e5bc254556a9eb159f",
              "url": "https://api.github.com/repos/artsy/eidolon/git/trees/74f18cfa9f377497c46295e5bc254556a9eb159f"
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/c330e8dfc6ae553a98fb9ffa6347f87d9f00f864"
          },
          {
            "sha": "263d74a15e856f563f18864c459167c46c92cf48",
            "parents": ["c330e8dfc6ae553a98fb9ffa6347f87d9f00f864"],
            "author": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-08-15T20:42:13Z"
            },
            "committer": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-08-15T20:42:13Z"
            },
            "message": "[Tests] Fixes typo, thanks @Gerst20051.",
            "tree": {
              "sha": "505840c1fd602e9ce7e44fda47488229aa1284b2",
              "url": "https://api.github.com/repos/artsy/eidolon/git/trees/505840c1fd602e9ce7e44fda47488229aa1284b2"
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/263d74a15e856f563f18864c459167c46c92cf48"
          },
          {
            "sha": "b71e4f62e248f2ca166582c4c9a6f15e14eaa15f",
            "parents": ["263d74a15e856f563f18864c459167c46c92cf48"],
            "author": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-08-15T20:54:06Z"
            },
            "committer": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-08-15T20:54:06Z"
            },
            "message": "[Podfile] Adds comment for specific pod commit.",
            "tree": {
              "sha": "4589f4905bd0e23710a257ed6560983cbda91838",
              "url": "https://api.github.com/repos/artsy/eidolon/git/trees/4589f4905bd0e23710a257ed6560983cbda91838"
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/b71e4f62e248f2ca166582c4c9a6f15e14eaa15f"
          },
          {
            "sha": "31b4eccb1bba8510485d468a0b73221eead2b0f0",
            "parents": ["b71e4f62e248f2ca166582c4c9a6f15e14eaa15f"],
            "author": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-08-16T23:23:51Z"
            },
            "committer": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-08-16T23:23:51Z"
            },
            "message": "[CI] Fix for intermittent CI failures.",
            "tree": {
              "sha": "e31f2c677fd09e21e2a056853a9f722c8f6a6c69",
              "url": "https://api.github.com/repos/artsy/eidolon/git/trees/e31f2c677fd09e21e2a056853a9f722c8f6a6c69"
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/31b4eccb1bba8510485d468a0b73221eead2b0f0"
          },
          {
            "sha": "db2af03f247bec4d12a3e743b4464a70501fac77",
            "parents": ["31b4eccb1bba8510485d468a0b73221eead2b0f0"],
            "author": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-08-17T13:34:47Z"
            },
            "committer": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-08-17T13:34:47Z"
            },
            "message": "[Ruby] Adds version-specifier.",
            "tree": {
              "sha": "9226b26bd2cc9f6e50076badff8229bec8ff818b",
              "url": "https://api.github.com/repos/artsy/eidolon/git/trees/9226b26bd2cc9f6e50076badff8229bec8ff818b"
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/db2af03f247bec4d12a3e743b4464a70501fac77"
          },
          {
            "sha": "57b041fbbbebd075f7fe186fb754cf7cce85519c",
            "parents": ["db2af03f247bec4d12a3e743b4464a70501fac77"],
            "author": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-08-17T13:42:29Z"
            },
            "committer": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-08-17T13:42:29Z"
            },
            "message": "[CI] Split up failing test + switch to syncrhonous testing.",
            "tree": {
              "sha": "64bc098d18f98b3363e7a02fefba816140e17b8f",
              "url": "https://api.github.com/repos/artsy/eidolon/git/trees/64bc098d18f98b3363e7a02fefba816140e17b8f"
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/57b041fbbbebd075f7fe186fb754cf7cce85519c"
          },
          {
            "sha": "851e911b4e8697a0f8e3b84c19df6cec30aead2a",
            "parents": ["57b041fbbbebd075f7fe186fb754cf7cce85519c"],
            "author": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-08-17T13:48:43Z"
            },
            "committer": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-08-17T13:58:30Z"
            },
            "message": "[CI] Fixes pre-launching simulator UUID.",
            "tree": {
              "sha": "9cbec8e2436334ac71c0254ff34595d24cf1c134",
              "url": "https://api.github.com/repos/artsy/eidolon/git/trees/9cbec8e2436334ac71c0254ff34595d24cf1c134"
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/851e911b4e8697a0f8e3b84c19df6cec30aead2a"
          },
          {
            "sha": "9963a5ff97b5dbd423df740c50e01a9dffd0a3ff",
            "parents": ["851e911b4e8697a0f8e3b84c19df6cec30aead2a"],
            "author": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-08-17T14:10:05Z"
            },
            "committer": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-08-17T14:10:05Z"
            },
            "message": "[CI] Fixes intermittently failing test comparing dates.",
            "tree": {
              "sha": "2ab689baa382cc918289529955121d17672db7a4",
              "url": "https://api.github.com/repos/artsy/eidolon/git/trees/2ab689baa382cc918289529955121d17672db7a4"
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/9963a5ff97b5dbd423df740c50e01a9dffd0a3ff"
          },
          {
            "sha": "1aa0360bc7a95d7878160ae91eea62324ac3252f",
            "parents": ["9963a5ff97b5dbd423df740c50e01a9dffd0a3ff"],
            "author": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-08-17T14:41:27Z"
            },
            "committer": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-08-17T14:41:27Z"
            },
            "message": "[Deps] Updates dependencies to latest Swift 2.x versions.",
            "tree": {
              "sha": "0ef37421cfa8cbd2d729e58de786b77f6219d3ad",
              "url": "https://api.github.com/repos/artsy/eidolon/git/trees/0ef37421cfa8cbd2d729e58de786b77f6219d3ad"
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/1aa0360bc7a95d7878160ae91eea62324ac3252f"
          },
          {
            "sha": "fb0688c603ddb48afe0edad336d3a7fac6f5e9f7",
            "parents": ["1aa0360bc7a95d7878160ae91eea62324ac3252f"],
            "author": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-08-17T14:41:31Z"
            },
            "committer": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-08-17T14:41:31Z"
            },
            "message": "[CI] Fixes more intermittent tests.",
            "tree": {
              "sha": "00271b152921db4988396350eca46ed6b19f6649",
              "url": "https://api.github.com/repos/artsy/eidolon/git/trees/00271b152921db4988396350eca46ed6b19f6649"
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/fb0688c603ddb48afe0edad336d3a7fac6f5e9f7"
          },
          {
            "sha": "c6eb849f100cbaa261680ee0d3dc819b91aa8af1",
            "parents": ["fb0688c603ddb48afe0edad336d3a7fac6f5e9f7"],
            "author": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-08-17T14:55:34Z"
            },
            "committer": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-08-17T14:55:34Z"
            },
            "message": "[CI] Removed duplicate simulator launch.",
            "tree": {
              "sha": "965807f296e1a3fb30134508062825cf30806786",
              "url": "https://api.github.com/repos/artsy/eidolon/git/trees/965807f296e1a3fb30134508062825cf30806786"
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/c6eb849f100cbaa261680ee0d3dc819b91aa8af1"
          },
          {
            "sha": "d769f276e066d79169a8bfa5795c8a4853f942f3",
            "parents": ["c6eb849f100cbaa261680ee0d3dc819b91aa8af1"],
            "author": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-08-17T15:14:19Z"
            },
            "committer": {
              "name": "Ash Furrow",
              "email": "ash@ashfurrow.com",
              "date": "2016-08-17T15:20:42Z"
            },
            "message": "[Feedback] Adds clarifying comments as per feedback in #609.",
            "tree": {
              "sha": "9004fe3df2b4d7d3285460095c37d9f62b4be26a",
              "url": "https://api.github.com/repos/artsy/eidolon/git/trees/9004fe3df2b4d7d3285460095c37d9f62b4be26a"
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/d769f276e066d79169a8bfa5795c8a4853f942f3"
          }
        ]
      },
      "github": {
        "issue": {
          "url": "https://api.github.com/repos/artsy/eidolon/issues/609",
          "repository_url": "https://api.github.com/repos/artsy/eidolon",
          "labels_url": "https://api.github.com/repos/artsy/eidolon/issues/609/labels{/name}",
          "comments_url": "https://api.github.com/repos/artsy/eidolon/issues/609/comments",
          "events_url": "https://api.github.com/repos/artsy/eidolon/issues/609/events",
          "html_url": "https://github.com/artsy/eidolon/pull/609",
          "id": 167696965,
          "number": 609,
          "title": "PR_TITLE",
          "user": {
            "login": "ashfurrow",
            "id": 498212,
            "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
            "gravatar_id": "",
            "url": "https://api.github.com/users/ashfurrow",
            "html_url": "https://github.com/ashfurrow",
            "followers_url": "https://api.github.com/users/ashfurrow/followers",
            "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
            "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
            "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
            "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
            "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
            "repos_url": "https://api.github.com/users/ashfurrow/repos",
            "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
            "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
            "type": "User",
            "site_admin": false
          },
          "labels": [
            {
              "id": 983870497,
              "node_id": "MDU6TGFiZWw5ODM4NzA0OTc=",
              "url": "https://api.github.com/repos/WeTransfer/Coyote/labels/PR_LABEL",
              "name": "PR_LABEL",
              "color": "ededed",
              "default": false,
              "description": null
            }
          ],
          "state": "closed",
          "locked": false,
          "assignee": {
            "login": "orta",
            "id": 49038,
            "avatar_url": "https://avatars2.githubusercontent.com/u/49038?v=4",
            "gravatar_id": "",
            "url": "https://api.github.com/users/orta",
            "html_url": "https://github.com/orta",
            "followers_url": "https://api.github.com/users/orta/followers",
            "following_url": "https://api.github.com/users/orta/following{/other_user}",
            "gists_url": "https://api.github.com/users/orta/gists{/gist_id}",
            "starred_url": "https://api.github.com/users/orta/starred{/owner}{/repo}",
            "subscriptions_url": "https://api.github.com/users/orta/subscriptions",
            "organizations_url": "https://api.github.com/users/orta/orgs",
            "repos_url": "https://api.github.com/users/orta/repos",
            "events_url": "https://api.github.com/users/orta/events{/privacy}",
            "received_events_url": "https://api.github.com/users/orta/received_events",
            "type": "User",
            "site_admin": false
          },
          "assignees": [
            {
              "login": "orta",
              "id": 49038,
              "avatar_url": "https://avatars2.githubusercontent.com/u/49038?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/orta",
              "html_url": "https://github.com/orta",
              "followers_url": "https://api.github.com/users/orta/followers",
              "following_url": "https://api.github.com/users/orta/following{/other_user}",
              "gists_url": "https://api.github.com/users/orta/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/orta/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/orta/subscriptions",
              "organizations_url": "https://api.github.com/users/orta/orgs",
              "repos_url": "https://api.github.com/users/orta/repos",
              "events_url": "https://api.github.com/users/orta/events{/privacy}",
              "received_events_url": "https://api.github.com/users/orta/received_events",
              "type": "User",
              "site_admin": false
            }
          ],
          "milestone": {
                "url": "https://api.github.com/repos/octocat/Hello-World/milestones/1",
                "html_url": "https://github.com/octocat/Hello-World/milestones/v1.0",
                "labels_url": "https://api.github.com/repos/octocat/Hello-World/milestones/1/labels",
                "id": 1002604,
                "number": 1,
                "state": "open",
                "title": "v1.0",
                "description": "Tracking milestone for version 1.0",
                "creator": {
                    "login": "octocat",
                    "id": 1,
                    "avatar_url": "https://github.com/images/error/octocat_happy.gif",
                    "gravatar_id": "",
                    "url": "https://api.github.com/users/octocat",
                    "html_url": "https://github.com/octocat",
                    "followers_url": "https://api.github.com/users/octocat/followers",
                    "following_url": "https://api.github.com/users/octocat/following{/other_user}",
                    "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
                    "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
                    "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
                    "organizations_url": "https://api.github.com/users/octocat/orgs",
                    "repos_url": "https://api.github.com/users/octocat/repos",
                    "events_url": "https://api.github.com/users/octocat/events{/privacy}",
                    "received_events_url": "https://api.github.com/users/octocat/received_events",
                    "type": "User",
                    "site_admin": false
                },
                "open_issues": 4,
                "closed_issues": 8,
                "created_at": "2011-04-10T20:09:31Z",
                "updated_at": "2014-03-03T18:58:10Z",
                "closed_at": "2013-02-12T13:22:01Z",
                "due_on": "2012-10-09T23:39:01Z"
            },
          "comments": 8,
          "created_at": "2016-07-26T19:57:30Z",
          "updated_at": "2016-08-17T15:26:14Z",
          "closed_at": "2016-08-17T15:26:14Z",
          "author_association": "MEMBER",
          "pull_request": {
            "url": "https://api.github.com/repos/artsy/eidolon/pulls/609",
            "html_url": "https://github.com/artsy/eidolon/pull/609",
            "diff_url": "https://github.com/artsy/eidolon/pull/609.diff",
            "patch_url": "https://github.com/artsy/eidolon/pull/609.patch"
          },
          "body": "PR_DESCRIPTION_CONTENT",
          "closed_by": {
            "login": "ashfurrow",
            "id": 498212,
            "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
            "gravatar_id": "",
            "url": "https://api.github.com/users/ashfurrow",
            "html_url": "https://github.com/ashfurrow",
            "followers_url": "https://api.github.com/users/ashfurrow/followers",
            "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
            "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
            "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
            "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
            "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
            "repos_url": "https://api.github.com/users/ashfurrow/repos",
            "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
            "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
            "type": "User",
            "site_admin": false
          }
        },
        "pr": {
          "url": "https://api.github.com/repos/artsy/eidolon/pulls/609",
          "id": 78914852,
          "html_url": "https://github.com/artsy/eidolon/pull/609",
          "diff_url": "https://github.com/artsy/eidolon/pull/609.diff",
          "patch_url": "https://github.com/artsy/eidolon/pull/609.patch",
          "issue_url": "https://api.github.com/repos/artsy/eidolon/issues/609",
          "number": 609,
          "state": "closed",
          "locked": false,
          "title": "PR_TITLE",
          "user": {
            "login": "ashfurrow",
            "id": 498212,
            "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
            "gravatar_id": "",
            "url": "https://api.github.com/users/ashfurrow",
            "html_url": "https://github.com/ashfurrow",
            "followers_url": "https://api.github.com/users/ashfurrow/followers",
            "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
            "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
            "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
            "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
            "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
            "repos_url": "https://api.github.com/users/ashfurrow/repos",
            "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
            "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
            "type": "User",
            "site_admin": false
          },
          "body": "PR_DESCRIPTION_CONTENT",
          "created_at": "2016-07-26T19:57:30Z",
          "updated_at": "2016-08-17T15:26:15Z",
          "closed_at": "2016-08-17T15:26:14Z",
          "merged_at": "2016-08-17T15:26:14Z",
          "merge_commit_sha": "e80bc6c78cd2f3524577e1401d7a460feba7a26c",
          "assignee": {
            "login": "orta",
            "id": 49038,
            "avatar_url": "https://avatars2.githubusercontent.com/u/49038?v=4",
            "gravatar_id": "",
            "url": "https://api.github.com/users/orta",
            "html_url": "https://github.com/orta",
            "followers_url": "https://api.github.com/users/orta/followers",
            "following_url": "https://api.github.com/users/orta/following{/other_user}",
            "gists_url": "https://api.github.com/users/orta/gists{/gist_id}",
            "starred_url": "https://api.github.com/users/orta/starred{/owner}{/repo}",
            "subscriptions_url": "https://api.github.com/users/orta/subscriptions",
            "organizations_url": "https://api.github.com/users/orta/orgs",
            "repos_url": "https://api.github.com/users/orta/repos",
            "events_url": "https://api.github.com/users/orta/events{/privacy}",
            "received_events_url": "https://api.github.com/users/orta/received_events",
            "type": "User",
            "site_admin": false
          },
          "assignees": [
            {
              "login": "orta",
              "id": 49038,
              "avatar_url": "https://avatars2.githubusercontent.com/u/49038?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/orta",
              "html_url": "https://github.com/orta",
              "followers_url": "https://api.github.com/users/orta/followers",
              "following_url": "https://api.github.com/users/orta/following{/other_user}",
              "gists_url": "https://api.github.com/users/orta/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/orta/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/orta/subscriptions",
              "organizations_url": "https://api.github.com/users/orta/orgs",
              "repos_url": "https://api.github.com/users/orta/repos",
              "events_url": "https://api.github.com/users/orta/events{/privacy}",
              "received_events_url": "https://api.github.com/users/orta/received_events",
              "type": "User",
              "site_admin": false
            }
          ],
          "requested_reviewers": [],
          "milestone": null,
          "commits_url": "https://api.github.com/repos/artsy/eidolon/pulls/609/commits",
          "review_comments_url": "https://api.github.com/repos/artsy/eidolon/pulls/609/comments",
          "review_comment_url": "https://api.github.com/repos/artsy/eidolon/pulls/comments{/number}",
          "comments_url": "https://api.github.com/repos/artsy/eidolon/issues/609/comments",
          "statuses_url":
            "https://api.github.com/repos/artsy/eidolon/statuses/d769f276e066d79169a8bfa5795c8a4853f942f3",
          "head": {
            "label": "artsy:xcode-update",
            "ref": "xcode-update",
            "sha": "d769f276e066d79169a8bfa5795c8a4853f942f3",
            "user": {
              "login": "artsy",
              "id": 546231,
              "avatar_url": "https://avatars3.githubusercontent.com/u/546231?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/artsy",
              "html_url": "https://github.com/artsy",
              "followers_url": "https://api.github.com/users/artsy/followers",
              "following_url": "https://api.github.com/users/artsy/following{/other_user}",
              "gists_url": "https://api.github.com/users/artsy/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/artsy/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/artsy/subscriptions",
              "organizations_url": "https://api.github.com/users/artsy/orgs",
              "repos_url": "https://api.github.com/users/artsy/repos",
              "events_url": "https://api.github.com/users/artsy/events{/privacy}",
              "received_events_url": "https://api.github.com/users/artsy/received_events",
              "type": "Organization",
              "site_admin": false
            },
            "repo": {
              "id": 22613546,
              "name": "eidolon",
              "full_name": "artsy/eidolon",
              "owner": {
                "login": "artsy",
                "id": 546231,
                "avatar_url": "https://avatars3.githubusercontent.com/u/546231?v=4",
                "gravatar_id": "",
                "url": "https://api.github.com/users/artsy",
                "html_url": "https://github.com/artsy",
                "followers_url": "https://api.github.com/users/artsy/followers",
                "following_url": "https://api.github.com/users/artsy/following{/other_user}",
                "gists_url": "https://api.github.com/users/artsy/gists{/gist_id}",
                "starred_url": "https://api.github.com/users/artsy/starred{/owner}{/repo}",
                "subscriptions_url": "https://api.github.com/users/artsy/subscriptions",
                "organizations_url": "https://api.github.com/users/artsy/orgs",
                "repos_url": "https://api.github.com/users/artsy/repos",
                "events_url": "https://api.github.com/users/artsy/events{/privacy}",
                "received_events_url": "https://api.github.com/users/artsy/received_events",
                "type": "Organization",
                "site_admin": false
              },
              "private": false,
              "html_url": "https://github.com/artsy/eidolon",
              "description": "The Artsy Auction Kiosk App",
              "fork": false,
              "url": "https://api.github.com/repos/artsy/eidolon",
              "forks_url": "https://api.github.com/repos/artsy/eidolon/forks",
              "keys_url": "https://api.github.com/repos/artsy/eidolon/keys{/key_id}",
              "collaborators_url": "https://api.github.com/repos/artsy/eidolon/collaborators{/collaborator}",
              "teams_url": "https://api.github.com/repos/artsy/eidolon/teams",
              "hooks_url": "https://api.github.com/repos/artsy/eidolon/hooks",
              "issue_events_url": "https://api.github.com/repos/artsy/eidolon/issues/events{/number}",
              "events_url": "https://api.github.com/repos/artsy/eidolon/events",
              "assignees_url": "https://api.github.com/repos/artsy/eidolon/assignees{/user}",
              "branches_url": "https://api.github.com/repos/artsy/eidolon/branches{/branch}",
              "tags_url": "https://api.github.com/repos/artsy/eidolon/tags",
              "blobs_url": "https://api.github.com/repos/artsy/eidolon/git/blobs{/sha}",
              "git_tags_url": "https://api.github.com/repos/artsy/eidolon/git/tags{/sha}",
              "git_refs_url": "https://api.github.com/repos/artsy/eidolon/git/refs{/sha}",
              "trees_url": "https://api.github.com/repos/artsy/eidolon/git/trees{/sha}",
              "statuses_url": "https://api.github.com/repos/artsy/eidolon/statuses/{sha}",
              "languages_url": "https://api.github.com/repos/artsy/eidolon/languages",
              "stargazers_url": "https://api.github.com/repos/artsy/eidolon/stargazers",
              "contributors_url": "https://api.github.com/repos/artsy/eidolon/contributors",
              "subscribers_url": "https://api.github.com/repos/artsy/eidolon/subscribers",
              "subscription_url": "https://api.github.com/repos/artsy/eidolon/subscription",
              "commits_url": "https://api.github.com/repos/artsy/eidolon/commits{/sha}",
              "git_commits_url": "https://api.github.com/repos/artsy/eidolon/git/commits{/sha}",
              "comments_url": "https://api.github.com/repos/artsy/eidolon/comments{/number}",
              "issue_comment_url": "https://api.github.com/repos/artsy/eidolon/issues/comments{/number}",
              "contents_url": "https://api.github.com/repos/artsy/eidolon/contents/{+path}",
              "compare_url": "https://api.github.com/repos/artsy/eidolon/compare/{base}...{head}",
              "merges_url": "https://api.github.com/repos/artsy/eidolon/merges",
              "archive_url": "https://api.github.com/repos/artsy/eidolon/{archive_format}{/ref}",
              "downloads_url": "https://api.github.com/repos/artsy/eidolon/downloads",
              "issues_url": "https://api.github.com/repos/artsy/eidolon/issues{/number}",
              "pulls_url": "https://api.github.com/repos/artsy/eidolon/pulls{/number}",
              "milestones_url": "https://api.github.com/repos/artsy/eidolon/milestones{/number}",
              "notifications_url": "https://api.github.com/repos/artsy/eidolon/notifications{?since,all,participating}",
              "labels_url": "https://api.github.com/repos/artsy/eidolon/labels{/name}",
              "releases_url": "https://api.github.com/repos/artsy/eidolon/releases{/id}",
              "deployments_url": "https://api.github.com/repos/artsy/eidolon/deployments",
              "created_at": "2014-08-04T17:38:26Z",
              "updated_at": "2017-10-24T08:59:48Z",
              "pushed_at": "2017-09-22T21:03:37Z",
              "git_url": "git://github.com/artsy/eidolon.git",
              "ssh_url": "git@github.com:artsy/eidolon.git",
              "clone_url": "https://github.com/artsy/eidolon.git",
              "svn_url": "https://github.com/artsy/eidolon",
              "homepage": "http://artsy.github.io/blog/2014/11/13/eidolon-retrospective/",
              "size": 135512,
              "stargazers_count": 1999,
              "watchers_count": 1999,
              "language": "Swift",
              "has_issues": true,
              "has_projects": true,
              "has_downloads": true,
              "has_wiki": false,
              "has_pages": false,
              "forks_count": 267,
              "mirror_url": null,
              "archived": false,
              "open_issues_count": 35,
              "forks": 267,
              "open_issues": 35,
              "watchers": 1999,
              "default_branch": "master"
            }
          },
          "base": {
            "label": "artsy:master",
            "ref": "master",
            "sha": "68c8db83776c1942145f530159a3fffddb812577",
            "user": {
              "login": "artsy",
              "id": 546231,
              "avatar_url": "https://avatars3.githubusercontent.com/u/546231?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/artsy",
              "html_url": "https://github.com/artsy",
              "followers_url": "https://api.github.com/users/artsy/followers",
              "following_url": "https://api.github.com/users/artsy/following{/other_user}",
              "gists_url": "https://api.github.com/users/artsy/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/artsy/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/artsy/subscriptions",
              "organizations_url": "https://api.github.com/users/artsy/orgs",
              "repos_url": "https://api.github.com/users/artsy/repos",
              "events_url": "https://api.github.com/users/artsy/events{/privacy}",
              "received_events_url": "https://api.github.com/users/artsy/received_events",
              "type": "Organization",
              "site_admin": false
            },
            "repo": {
              "id": 22613546,
              "name": "eidolon",
              "full_name": "artsy/eidolon",
              "owner": {
                "login": "artsy",
                "id": 546231,
                "avatar_url": "https://avatars3.githubusercontent.com/u/546231?v=4",
                "gravatar_id": "",
                "url": "https://api.github.com/users/artsy",
                "html_url": "https://github.com/artsy",
                "followers_url": "https://api.github.com/users/artsy/followers",
                "following_url": "https://api.github.com/users/artsy/following{/other_user}",
                "gists_url": "https://api.github.com/users/artsy/gists{/gist_id}",
                "starred_url": "https://api.github.com/users/artsy/starred{/owner}{/repo}",
                "subscriptions_url": "https://api.github.com/users/artsy/subscriptions",
                "organizations_url": "https://api.github.com/users/artsy/orgs",
                "repos_url": "https://api.github.com/users/artsy/repos",
                "events_url": "https://api.github.com/users/artsy/events{/privacy}",
                "received_events_url": "https://api.github.com/users/artsy/received_events",
                "type": "Organization",
                "site_admin": false
              },
              "private": false,
              "html_url": "https://github.com/artsy/eidolon",
              "description": "The Artsy Auction Kiosk App",
              "fork": false,
              "url": "https://api.github.com/repos/artsy/eidolon",
              "forks_url": "https://api.github.com/repos/artsy/eidolon/forks",
              "keys_url": "https://api.github.com/repos/artsy/eidolon/keys{/key_id}",
              "collaborators_url": "https://api.github.com/repos/artsy/eidolon/collaborators{/collaborator}",
              "teams_url": "https://api.github.com/repos/artsy/eidolon/teams",
              "hooks_url": "https://api.github.com/repos/artsy/eidolon/hooks",
              "issue_events_url": "https://api.github.com/repos/artsy/eidolon/issues/events{/number}",
              "events_url": "https://api.github.com/repos/artsy/eidolon/events",
              "assignees_url": "https://api.github.com/repos/artsy/eidolon/assignees{/user}",
              "branches_url": "https://api.github.com/repos/artsy/eidolon/branches{/branch}",
              "tags_url": "https://api.github.com/repos/artsy/eidolon/tags",
              "blobs_url": "https://api.github.com/repos/artsy/eidolon/git/blobs{/sha}",
              "git_tags_url": "https://api.github.com/repos/artsy/eidolon/git/tags{/sha}",
              "git_refs_url": "https://api.github.com/repos/artsy/eidolon/git/refs{/sha}",
              "trees_url": "https://api.github.com/repos/artsy/eidolon/git/trees{/sha}",
              "statuses_url": "https://api.github.com/repos/artsy/eidolon/statuses/{sha}",
              "languages_url": "https://api.github.com/repos/artsy/eidolon/languages",
              "stargazers_url": "https://api.github.com/repos/artsy/eidolon/stargazers",
              "contributors_url": "https://api.github.com/repos/artsy/eidolon/contributors",
              "subscribers_url": "https://api.github.com/repos/artsy/eidolon/subscribers",
              "subscription_url": "https://api.github.com/repos/artsy/eidolon/subscription",
              "commits_url": "https://api.github.com/repos/artsy/eidolon/commits{/sha}",
              "git_commits_url": "https://api.github.com/repos/artsy/eidolon/git/commits{/sha}",
              "comments_url": "https://api.github.com/repos/artsy/eidolon/comments{/number}",
              "issue_comment_url": "https://api.github.com/repos/artsy/eidolon/issues/comments{/number}",
              "contents_url": "https://api.github.com/repos/artsy/eidolon/contents/{+path}",
              "compare_url": "https://api.github.com/repos/artsy/eidolon/compare/{base}...{head}",
              "merges_url": "https://api.github.com/repos/artsy/eidolon/merges",
              "archive_url": "https://api.github.com/repos/artsy/eidolon/{archive_format}{/ref}",
              "downloads_url": "https://api.github.com/repos/artsy/eidolon/downloads",
              "issues_url": "https://api.github.com/repos/artsy/eidolon/issues{/number}",
              "pulls_url": "https://api.github.com/repos/artsy/eidolon/pulls{/number}",
              "milestones_url": "https://api.github.com/repos/artsy/eidolon/milestones{/number}",
              "notifications_url": "https://api.github.com/repos/artsy/eidolon/notifications{?since,all,participating}",
              "labels_url": "https://api.github.com/repos/artsy/eidolon/labels{/name}",
              "releases_url": "https://api.github.com/repos/artsy/eidolon/releases{/id}",
              "deployments_url": "https://api.github.com/repos/artsy/eidolon/deployments",
              "created_at": "2014-08-04T17:38:26Z",
              "updated_at": "2017-10-24T08:59:48Z",
              "pushed_at": "2017-09-22T21:03:37Z",
              "git_url": "git://github.com/artsy/eidolon.git",
              "ssh_url": "git@github.com:artsy/eidolon.git",
              "clone_url": "https://github.com/artsy/eidolon.git",
              "svn_url": "https://github.com/artsy/eidolon",
              "homepage": "http://artsy.github.io/blog/2014/11/13/eidolon-retrospective/",
              "size": 135512,
              "stargazers_count": 1999,
              "watchers_count": 1999,
              "language": "Swift",
              "has_issues": true,
              "has_projects": true,
              "has_downloads": true,
              "has_wiki": false,
              "has_pages": false,
              "forks_count": 267,
              "mirror_url": null,
              "archived": false,
              "open_issues_count": 35,
              "forks": 267,
              "open_issues": 35,
              "watchers": 1999,
              "default_branch": "master"
            }
          },
          "_links": {
            "self": {
              "href": "https://api.github.com/repos/artsy/eidolon/pulls/609"
            },
            "html": {
              "href": "https://github.com/artsy/eidolon/pull/609"
            },
            "issue": {
              "href": "https://api.github.com/repos/artsy/eidolon/issues/609"
            },
            "comments": {
              "href": "https://api.github.com/repos/artsy/eidolon/issues/609/comments"
            },
            "review_comments": {
              "href": "https://api.github.com/repos/artsy/eidolon/pulls/609/comments"
            },
            "review_comment": {
              "href": "https://api.github.com/repos/artsy/eidolon/pulls/comments{/number}"
            },
            "commits": {
              "href": "https://api.github.com/repos/artsy/eidolon/pulls/609/commits"
            },
            "statuses": {
              "href": "https://api.github.com/repos/artsy/eidolon/statuses/d769f276e066d79169a8bfa5795c8a4853f942f3"
            }
          },
          "author_association": "MEMBER",
          "merged": true,
          "mergeable": null,
          "rebaseable": null,
          "mergeable_state": "unknown",
          "merged_by": {
            "login": "ashfurrow",
            "id": 498212,
            "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
            "gravatar_id": "",
            "url": "https://api.github.com/users/ashfurrow",
            "html_url": "https://github.com/ashfurrow",
            "followers_url": "https://api.github.com/users/ashfurrow/followers",
            "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
            "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
            "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
            "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
            "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
            "repos_url": "https://api.github.com/users/ashfurrow/repos",
            "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
            "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
            "type": "User",
            "site_admin": false
          },
          "comments": 8,
          "review_comments": 11,
          "maintainer_can_modify": false,
          "commits": 15,
          "additions": 205,
          "deletions": 111,
          "changed_files": 56
        },
        "commits": [
          {
            "sha": "93ae30cf2aee4241c442fb3242543490998cffdb",
            "commit": {
              "author": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-07-26T19:54:16Z"
              },
              "committer": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-07-26T19:55:00Z"
              },
              "message": "[Xcode] Updates for compatibility with Xcode 7.3.1.",
              "tree": {
                "sha": "fb6bc3fda2456c5ff0a4e8f307f24ee73f281fc1",
                "url": "https://api.github.com/repos/artsy/eidolon/git/trees/fb6bc3fda2456c5ff0a4e8f307f24ee73f281fc1"
              },
              "url": "https://api.github.com/repos/artsy/eidolon/git/commits/93ae30cf2aee4241c442fb3242543490998cffdb",
              "comment_count": 0,
              "verification": {
                "verified": true,
                "reason": "valid",
                "signature":
                  "-----BEGIN PGP SIGNATURE-----\\nVersion: GnuPG v1\\n\\niQEcBAABAgAGBQJXl8AUAAoJEAGZOscENF/tIA8H/Ri9VdHJAzfO1aAtnoQ5W8Kw\\n1yYd5BTVnr0nVw95qxBgoRbBLMUIKg0TOPQQa1h7hk6SOr0py6E4HSpCJQq97f8J\\nvgeiFHuyfcW/ePSS8WwJbIzTP3xkckvdZIPjXM1KtvzQ1vCoOrOwBxMqH2twoTQk\\nuGd5cgfsahUGHcwYA6B4vfkmAGLkOyFVjUzbDgf1nT5CMbPVlbFgss3aEi8Ql81S\\ncNjtMGiUm9n3LUG5lMiwOC3898fpE8YYoAPy1CtLuwokGws3Tu9jMSnUCi2Al7KC\\nzWMpIS3L2WVoCdhiv2NbXxUDTbaYn8llKGdtzw3QLZ0AL5ZEkuKrxtDQGyimpaw=\\n=aGrl\\n-----END PGP SIGNATURE-----",
                "payload":
                  "tree fb6bc3fda2456c5ff0a4e8f307f24ee73f281fc1\\nparent 68c8db83776c1942145f530159a3fffddb812577\\nauthor Ash Furrow <ash@ashfurrow.com> 1469562856 -0400\\ncommitter Ash Furrow <ash@ashfurrow.com> 1469562900 -0400\\n\\n[Xcode] Updates for compatibility with Xcode 7.3.1.\\n"
              }
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/93ae30cf2aee4241c442fb3242543490998cffdb",
            "html_url": "https://github.com/artsy/eidolon/commit/93ae30cf2aee4241c442fb3242543490998cffdb",
            "comments_url":
              "https://api.github.com/repos/artsy/eidolon/commits/93ae30cf2aee4241c442fb3242543490998cffdb/comments",
            "author": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "committer": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "parents": [
              {
                "sha": "68c8db83776c1942145f530159a3fffddb812577",
                "url": "https://api.github.com/repos/artsy/eidolon/commits/68c8db83776c1942145f530159a3fffddb812577",
                "html_url": "https://github.com/artsy/eidolon/commit/68c8db83776c1942145f530159a3fffddb812577"
              }
            ]
          },
          {
            "sha": "4cf1e41f72516a4135f1738c47f7dd3d421ff3c4",
            "commit": {
              "author": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-07-26T19:55:53Z"
              },
              "committer": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-07-26T19:55:53Z"
              },
              "message": "[CI] Updates Travis to Xcode 7.3.",
              "tree": {
                "sha": "01f7e53a061a1df01e7d6d3a6fb4d2ce9ee0e39a",
                "url": "https://api.github.com/repos/artsy/eidolon/git/trees/01f7e53a061a1df01e7d6d3a6fb4d2ce9ee0e39a"
              },
              "url": "https://api.github.com/repos/artsy/eidolon/git/commits/4cf1e41f72516a4135f1738c47f7dd3d421ff3c4",
              "comment_count": 0,
              "verification": {
                "verified": true,
                "reason": "valid",
                "signature":
                  "-----BEGIN PGP SIGNATURE-----\\nVersion: GnuPG v1\\n\\niQEcBAABAgAGBQJXl8BJAAoJEAGZOscENF/tQAcH/0I+QcSDZDEab6mkYSvX88jP\\nbd7Y+O/9CGD9srYIVXE8xGSfO4JKU+sQXLiLsN1OKrHVvdH1SUyE+mUKa68s+8dA\\nXYo7Ozg3ieL/DearxnCeSkKqIEsVlhvJzbyloWfPwnm9shfgQFnwuBj0A/nMBXBK\\nuNfHq9zR7mSe74r1f89FfddWbNmB6z8Ju0GLwLLbnpD1AzB7cTfDgXNjx8Og++LI\\n6xGSNmEqApCYdLPhVW71m/FXzSTF71y/j2QzyG6Jr8n0VhRm7YY4q2kZWHE2RsRT\\nGIZt1vuFrT8hddsKy0gC3wrrOPn7FOxZWkWvXHzBeuKlDXUD8aOPjm9AEeOBAs8=\\n=Xe+7\\n-----END PGP SIGNATURE-----",
                "payload":
                  "tree 01f7e53a061a1df01e7d6d3a6fb4d2ce9ee0e39a\\nparent 93ae30cf2aee4241c442fb3242543490998cffdb\\nauthor Ash Furrow <ash@ashfurrow.com> 1469562953 -0400\\ncommitter Ash Furrow <ash@ashfurrow.com> 1469562953 -0400\\n\\n[CI] Updates Travis to Xcode 7.3.\\n"
              }
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/4cf1e41f72516a4135f1738c47f7dd3d421ff3c4",
            "html_url": "https://github.com/artsy/eidolon/commit/4cf1e41f72516a4135f1738c47f7dd3d421ff3c4",
            "comments_url":
              "https://api.github.com/repos/artsy/eidolon/commits/4cf1e41f72516a4135f1738c47f7dd3d421ff3c4/comments",
            "author": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "committer": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "parents": [
              {
                "sha": "93ae30cf2aee4241c442fb3242543490998cffdb",
                "url": "https://api.github.com/repos/artsy/eidolon/commits/93ae30cf2aee4241c442fb3242543490998cffdb",
                "html_url": "https://github.com/artsy/eidolon/commit/93ae30cf2aee4241c442fb3242543490998cffdb"
              }
            ]
          },
          {
            "sha": "d0d72ec5b5ee90c2513a8aafb48911ae5bcdf4ac",
            "commit": {
              "author": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-07-26T21:17:40Z"
              },
              "committer": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-07-26T21:17:40Z"
              },
              "message": "[Deps] Updates dependencies for Swift 2.2.",
              "tree": {
                "sha": "a30d9d8be16847c33eb50483a653f27475f197a4",
                "url": "https://api.github.com/repos/artsy/eidolon/git/trees/a30d9d8be16847c33eb50483a653f27475f197a4"
              },
              "url": "https://api.github.com/repos/artsy/eidolon/git/commits/d0d72ec5b5ee90c2513a8aafb48911ae5bcdf4ac",
              "comment_count": 0,
              "verification": {
                "verified": true,
                "reason": "valid",
                "signature":
                  "-----BEGIN PGP SIGNATURE-----\\nVersion: GnuPG v1\\n\\niQEcBAABAgAGBQJXl9N0AAoJEAGZOscENF/t2dYH/iQP6IdX2P/86gNHmxNcm2n7\\n9e84aJ2vlSgBWxiOgRV2mejsz8C/woRvVpa691GCRbWch2j7yzAjIXfmDK8VlxLe\\nY98/89fThWcbZIARGRUDFRhnOYMfKWPqDRNV/kwDRTs6I5x/sFKPEAoqO1ldBc9q\\nTZmsk3IsnBFH1XoraNkp9Nmc3FC5Mra/9sgtqGHpU2eWksj5LOYUE3BQ7Z5s9NgU\\nxptToZfL11Hl4RObSDi12Fzv0prtRHuFW4w1HvxBedgbgD4k531aP3OMPmnecNcO\\n3F8U/xVS/jstKP3ODtKc9HggIEp6mrE97xqBqnCzN0gQUkaLS3TofeG5eqn9DE0=\\n=uqge\\n-----END PGP SIGNATURE-----",
                "payload":
                  "tree a30d9d8be16847c33eb50483a653f27475f197a4\\nparent 4cf1e41f72516a4135f1738c47f7dd3d421ff3c4\\nauthor Ash Furrow <ash@ashfurrow.com> 1469567860 -0400\\ncommitter Ash Furrow <ash@ashfurrow.com> 1469567860 -0400\\n\\n[Deps] Updates dependencies for Swift 2.2.\\n"
              }
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/d0d72ec5b5ee90c2513a8aafb48911ae5bcdf4ac",
            "html_url": "https://github.com/artsy/eidolon/commit/d0d72ec5b5ee90c2513a8aafb48911ae5bcdf4ac",
            "comments_url":
              "https://api.github.com/repos/artsy/eidolon/commits/d0d72ec5b5ee90c2513a8aafb48911ae5bcdf4ac/comments",
            "author": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "committer": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "parents": [
              {
                "sha": "4cf1e41f72516a4135f1738c47f7dd3d421ff3c4",
                "url": "https://api.github.com/repos/artsy/eidolon/commits/4cf1e41f72516a4135f1738c47f7dd3d421ff3c4",
                "html_url": "https://github.com/artsy/eidolon/commit/4cf1e41f72516a4135f1738c47f7dd3d421ff3c4"
              }
            ]
          },
          {
            "sha": "c330e8dfc6ae553a98fb9ffa6347f87d9f00f864",
            "commit": {
              "author": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-08-15T20:41:00Z"
              },
              "committer": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-08-15T20:41:00Z"
              },
              "message": "[Tests] Cleans up snapshot tests for Xcode 7.3.1.",
              "tree": {
                "sha": "74f18cfa9f377497c46295e5bc254556a9eb159f",
                "url": "https://api.github.com/repos/artsy/eidolon/git/trees/74f18cfa9f377497c46295e5bc254556a9eb159f"
              },
              "url": "https://api.github.com/repos/artsy/eidolon/git/commits/c330e8dfc6ae553a98fb9ffa6347f87d9f00f864",
              "comment_count": 0,
              "verification": {
                "verified": true,
                "reason": "valid",
                "signature":
                  "-----BEGIN PGP SIGNATURE-----\\nVersion: GnuPG v1\\n\\niQEcBAABAgAGBQJXsijcAAoJEAGZOscENF/tfzoIAI5sUJAnv8qkMKf9u2CEhhQd\\nJ4uUoKeWbObIXx++ps6y3LjyC6h7rxW06wOGZBrFwTseljmIvV7OYspXGNwNOia7\\n1nSSRl5d6193wu4FdQdrlrss2Kwbh9PMIeDFQBhEedrDwB6xi+eu/DeFk3jusrIJ\\njMcQtC5sp3o5Psdit2zxnwEnbMMoZ31iFd2dY50H6m6MvCaUyNVXJ5QcJccYHYc5\\nNLxsCgwkG4ONASjPBRyzwvTVJ82+Aghck6mffdylAILELAR8DH+Z/K2ciqxcEBG4\\nAPqh+P08Oxj4CUZcEWUaYKeBMJRQ1KJ2rvCtH4fTjFg/xzZS1jI2ckeuNehkRtI=\\n=LzG3\\n-----END PGP SIGNATURE-----",
                "payload":
                  "tree 74f18cfa9f377497c46295e5bc254556a9eb159f\\nparent d0d72ec5b5ee90c2513a8aafb48911ae5bcdf4ac\\nauthor Ash Furrow <ash@ashfurrow.com> 1471293660 -0400\\ncommitter Ash Furrow <ash@ashfurrow.com> 1471293660 -0400\\n\\n[Tests] Cleans up snapshot tests for Xcode 7.3.1.\\n"
              }
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/c330e8dfc6ae553a98fb9ffa6347f87d9f00f864",
            "html_url": "https://github.com/artsy/eidolon/commit/c330e8dfc6ae553a98fb9ffa6347f87d9f00f864",
            "comments_url":
              "https://api.github.com/repos/artsy/eidolon/commits/c330e8dfc6ae553a98fb9ffa6347f87d9f00f864/comments",
            "author": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "committer": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "parents": [
              {
                "sha": "d0d72ec5b5ee90c2513a8aafb48911ae5bcdf4ac",
                "url": "https://api.github.com/repos/artsy/eidolon/commits/d0d72ec5b5ee90c2513a8aafb48911ae5bcdf4ac",
                "html_url": "https://github.com/artsy/eidolon/commit/d0d72ec5b5ee90c2513a8aafb48911ae5bcdf4ac"
              }
            ]
          },
          {
            "sha": "263d74a15e856f563f18864c459167c46c92cf48",
            "commit": {
              "author": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-08-15T20:42:13Z"
              },
              "committer": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-08-15T20:42:13Z"
              },
              "message": "[Tests] Fixes typo, thanks @Gerst20051.",
              "tree": {
                "sha": "505840c1fd602e9ce7e44fda47488229aa1284b2",
                "url": "https://api.github.com/repos/artsy/eidolon/git/trees/505840c1fd602e9ce7e44fda47488229aa1284b2"
              },
              "url": "https://api.github.com/repos/artsy/eidolon/git/commits/263d74a15e856f563f18864c459167c46c92cf48",
              "comment_count": 1,
              "verification": {
                "verified": true,
                "reason": "valid",
                "signature":
                  "-----BEGIN PGP SIGNATURE-----\\nVersion: GnuPG v1\\n\\niQEcBAABAgAGBQJXsiklAAoJEAGZOscENF/ti2QH/1EyaRpCDMxymAfkalCtt9o8\\nJWxTJE/SoD5bK9ljLwUsrvM8C3G61MSIqYr3Vn55y5/LLiLUasrLCGE1Io+EUlWb\\nxtkd95P2aAyFO9cLspCUU3xm61jSfxVfF3lFNMtH+zrdYmRF21bjyNw9Avh+21um\\nHuoDusYiqH92FSrjJzGOrCTn0zpqV7PBDDbocRILDIO98+w8/irfbDZK+up0udzx\\nTNoBusGUXoAQ//n+nqH/9c3Dzfl/uZ5chsbeKhM/bkh+MAMDXb+TKSeqUvEzGRGv\\nCeL7DTQMsr47WQrNrHHf+vTfhCDVIsJ9P/mdjQNUB4/towT+5HwVO4CJ+KFRgpA=\\n=51AP\\n-----END PGP SIGNATURE-----",
                "payload":
                  "tree 505840c1fd602e9ce7e44fda47488229aa1284b2\\nparent c330e8dfc6ae553a98fb9ffa6347f87d9f00f864\\nauthor Ash Furrow <ash@ashfurrow.com> 1471293733 -0400\\ncommitter Ash Furrow <ash@ashfurrow.com> 1471293733 -0400\\n\\n[Tests] Fixes typo, thanks @Gerst20051.\\n"
              }
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/263d74a15e856f563f18864c459167c46c92cf48",
            "html_url": "https://github.com/artsy/eidolon/commit/263d74a15e856f563f18864c459167c46c92cf48",
            "comments_url":
              "https://api.github.com/repos/artsy/eidolon/commits/263d74a15e856f563f18864c459167c46c92cf48/comments",
            "author": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "committer": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "parents": [
              {
                "sha": "c330e8dfc6ae553a98fb9ffa6347f87d9f00f864",
                "url": "https://api.github.com/repos/artsy/eidolon/commits/c330e8dfc6ae553a98fb9ffa6347f87d9f00f864",
                "html_url": "https://github.com/artsy/eidolon/commit/c330e8dfc6ae553a98fb9ffa6347f87d9f00f864"
              }
            ]
          },
          {
            "sha": "b71e4f62e248f2ca166582c4c9a6f15e14eaa15f",
            "commit": {
              "author": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-08-15T20:54:06Z"
              },
              "committer": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-08-15T20:54:06Z"
              },
              "message": "[Podfile] Adds comment for specific pod commit.",
              "tree": {
                "sha": "4589f4905bd0e23710a257ed6560983cbda91838",
                "url": "https://api.github.com/repos/artsy/eidolon/git/trees/4589f4905bd0e23710a257ed6560983cbda91838"
              },
              "url": "https://api.github.com/repos/artsy/eidolon/git/commits/b71e4f62e248f2ca166582c4c9a6f15e14eaa15f",
              "comment_count": 0,
              "verification": {
                "verified": true,
                "reason": "valid",
                "signature":
                  "-----BEGIN PGP SIGNATURE-----\\nVersion: GnuPG v1\\n\\niQEcBAABAgAGBQJXsivuAAoJEAGZOscENF/tMV8H/jMqIqotNseYEbpil5nTII9m\\nKlxIOw/T/lHkKvTN0/hgXR/xDlXObR349YJYiPoNPAQNJa2TVeZ/PRNYNCcwGx2/\\nKtWuU5Fk1yvRW2h0wpq6rEVu/hesz9QeyXYW3esyz6QxWBKvmO8gIIq9mONS8Fz9\\nPlB+0ZneYxRwEIOZSyW5gmE1G4q0ZAWqSitfrGpta/c9N3jl/GeSuGFbfPNTFPUy\\nboocfJshdJpvEMpdyU05MYFWtxSKp6O0aPgKTqPeO5YCHGPvnPAj2a6N2gQ5TKhp\\ndqvzmeljjfZHvAr3Q+dXhHgjUWHHI8FROUTs0Ukssinq/+IrcW3FwauWeBe3l7M=\\n=dHWL\\n-----END PGP SIGNATURE-----",
                "payload":
                  "tree 4589f4905bd0e23710a257ed6560983cbda91838\\nparent 263d74a15e856f563f18864c459167c46c92cf48\\nauthor Ash Furrow <ash@ashfurrow.com> 1471294446 -0400\\ncommitter Ash Furrow <ash@ashfurrow.com> 1471294446 -0400\\n\\n[Podfile] Adds comment for specific pod commit.\\n"
              }
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/b71e4f62e248f2ca166582c4c9a6f15e14eaa15f",
            "html_url": "https://github.com/artsy/eidolon/commit/b71e4f62e248f2ca166582c4c9a6f15e14eaa15f",
            "comments_url":
              "https://api.github.com/repos/artsy/eidolon/commits/b71e4f62e248f2ca166582c4c9a6f15e14eaa15f/comments",
            "author": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "committer": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "parents": [
              {
                "sha": "263d74a15e856f563f18864c459167c46c92cf48",
                "url": "https://api.github.com/repos/artsy/eidolon/commits/263d74a15e856f563f18864c459167c46c92cf48",
                "html_url": "https://github.com/artsy/eidolon/commit/263d74a15e856f563f18864c459167c46c92cf48"
              }
            ]
          },
          {
            "sha": "31b4eccb1bba8510485d468a0b73221eead2b0f0",
            "commit": {
              "author": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-08-16T23:23:51Z"
              },
              "committer": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-08-16T23:23:51Z"
              },
              "message": "[CI] Fix for intermittent CI failures.",
              "tree": {
                "sha": "e31f2c677fd09e21e2a056853a9f722c8f6a6c69",
                "url": "https://api.github.com/repos/artsy/eidolon/git/trees/e31f2c677fd09e21e2a056853a9f722c8f6a6c69"
              },
              "url": "https://api.github.com/repos/artsy/eidolon/git/commits/31b4eccb1bba8510485d468a0b73221eead2b0f0",
              "comment_count": 0,
              "verification": {
                "verified": true,
                "reason": "valid",
                "signature":
                  "-----BEGIN PGP SIGNATURE-----\\n\\niQEcBAABAgAGBQJXs6CHAAoJEAGZOscENF/t0I8H/3CIBRZQXX3BB6xRb+J89BWN\\nPjWQ1xiW63N6Y9yrIRjZGMov9QeCo3hv9b/sMF2fjwc7NblVL/SjPhStl07uAHGY\\nZ9E5Rd1b8Df1DMhEKGqIf0Ne3vMuYfUrrUUwlLXwPy3BXZQNUTlQa08DKXKHb9h0\\nrNEhP5WLS5+ycottr7d4tngzJXTBIUyjOYc7qES8+NAHwGm0wiGabvaPuUrcsjPz\\nyLvuHxb8e6VVrTH/8OE/On3g546ZDJUEmM5wA8XLkgb0F70vNfU2whNvdBD1shsJ\\nBXbQUOL5FjpLbSqcLbAQCIgyfza4SYWD7XUZoMIoVbIVgRe3g/E9oN9+n7y/4fE=\\n=2sLb\\n-----END PGP SIGNATURE-----",
                "payload":
                  "tree e31f2c677fd09e21e2a056853a9f722c8f6a6c69\\nparent b71e4f62e248f2ca166582c4c9a6f15e14eaa15f\\nauthor Ash Furrow <ash@ashfurrow.com> 1471389831 -0400\\ncommitter Ash Furrow <ash@ashfurrow.com> 1471389831 -0400\\n\\n[CI] Fix for intermittent CI failures.\\n"
              }
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/31b4eccb1bba8510485d468a0b73221eead2b0f0",
            "html_url": "https://github.com/artsy/eidolon/commit/31b4eccb1bba8510485d468a0b73221eead2b0f0",
            "comments_url":
              "https://api.github.com/repos/artsy/eidolon/commits/31b4eccb1bba8510485d468a0b73221eead2b0f0/comments",
            "author": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "committer": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "parents": [
              {
                "sha": "b71e4f62e248f2ca166582c4c9a6f15e14eaa15f",
                "url": "https://api.github.com/repos/artsy/eidolon/commits/b71e4f62e248f2ca166582c4c9a6f15e14eaa15f",
                "html_url": "https://github.com/artsy/eidolon/commit/b71e4f62e248f2ca166582c4c9a6f15e14eaa15f"
              }
            ]
          },
          {
            "sha": "db2af03f247bec4d12a3e743b4464a70501fac77",
            "commit": {
              "author": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-08-17T13:34:47Z"
              },
              "committer": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-08-17T13:34:47Z"
              },
              "message": "[Ruby] Adds version-specifier.",
              "tree": {
                "sha": "9226b26bd2cc9f6e50076badff8229bec8ff818b",
                "url": "https://api.github.com/repos/artsy/eidolon/git/trees/9226b26bd2cc9f6e50076badff8229bec8ff818b"
              },
              "url": "https://api.github.com/repos/artsy/eidolon/git/commits/db2af03f247bec4d12a3e743b4464a70501fac77",
              "comment_count": 0,
              "verification": {
                "verified": true,
                "reason": "valid",
                "signature":
                  "-----BEGIN PGP SIGNATURE-----\\nVersion: GnuPG v1\\n\\niQEcBAABAgAGBQJXtGf3AAoJEAGZOscENF/t+wQH+wRvEVBk8csaPgPgG5FdvVw0\\nftpSAuYLkJnhouPaERzUc2fW7Aiy9b94KFKtX9FG1Ix8ynBMTprxDdSiZNb/B2Fs\\ns2wrTCtUaiKhiP2YOhUku1rMTSR3PGZ1Ixhqumog0FSnDhqWVjOxuSgFL+E5P++S\\n8sZjOKVBIsHI4Uun/xQZCXrUpxda0B99GA2mDnxKkkh2oauAwN+K+v6SI6BNastJ\\nR+cX4SJWQaP3/TMVbGMXjsiu+8t3R1UXA89pIdk2GA0WGLBhnlecVCJZ2V3bKNvg\\ntaxpKE/PDCFmoqRT1iJlpbRgon9HEEuVx3PP2zKfuVuioG7w+lDZjy5B7aEZHYo=\\n=HST1\\n-----END PGP SIGNATURE-----",
                "payload":
                  "tree 9226b26bd2cc9f6e50076badff8229bec8ff818b\\nparent 31b4eccb1bba8510485d468a0b73221eead2b0f0\\nauthor Ash Furrow <ash@ashfurrow.com> 1471440887 -0400\\ncommitter Ash Furrow <ash@ashfurrow.com> 1471440887 -0400\\n\\n[Ruby] Adds version-specifier.\\n"
              }
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/db2af03f247bec4d12a3e743b4464a70501fac77",
            "html_url": "https://github.com/artsy/eidolon/commit/db2af03f247bec4d12a3e743b4464a70501fac77",
            "comments_url":
              "https://api.github.com/repos/artsy/eidolon/commits/db2af03f247bec4d12a3e743b4464a70501fac77/comments",
            "author": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "committer": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "parents": [
              {
                "sha": "31b4eccb1bba8510485d468a0b73221eead2b0f0",
                "url": "https://api.github.com/repos/artsy/eidolon/commits/31b4eccb1bba8510485d468a0b73221eead2b0f0",
                "html_url": "https://github.com/artsy/eidolon/commit/31b4eccb1bba8510485d468a0b73221eead2b0f0"
              }
            ]
          },
          {
            "sha": "57b041fbbbebd075f7fe186fb754cf7cce85519c",
            "commit": {
              "author": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-08-17T13:42:29Z"
              },
              "committer": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-08-17T13:42:29Z"
              },
              "message": "[CI] Split up failing test + switch to syncrhonous testing.",
              "tree": {
                "sha": "64bc098d18f98b3363e7a02fefba816140e17b8f",
                "url": "https://api.github.com/repos/artsy/eidolon/git/trees/64bc098d18f98b3363e7a02fefba816140e17b8f"
              },
              "url": "https://api.github.com/repos/artsy/eidolon/git/commits/57b041fbbbebd075f7fe186fb754cf7cce85519c",
              "comment_count": 0,
              "verification": {
                "verified": true,
                "reason": "valid",
                "signature":
                  "-----BEGIN PGP SIGNATURE-----\\nVersion: GnuPG v1\\n\\niQEcBAABAgAGBQJXtGnFAAoJEAGZOscENF/tt8cH/iJrA3IkA9qOspPV1Ar+S/+4\\nUrP0IcXbk3E7CPamdWJwl2d2bRSn99Qpc7BkE1tLEFfdccAceq5A5RnHESoC2U8D\\nZ62Z1EMgnzbApr/qp6xulDtqpmhvbbMOoLOCODK2tLpY35HTw+RrmjZ4Zn6ApxvH\\namwVVUprHSNuPF7kF+GaKw8W9cCw3zmjRpDQPnvKqzxqFrCkAR0FWslfhjyhdybD\\n9YtEGsngEyVqhlcIev06W+POAbfzdVPhKP9wKq5MQF/zsPVHbMUvU/Yv9CRbTzoa\\n9FQqe4PcGQg+AEP9XGZ3AXCftcDB0PKZrMoJpBujg20yyFluCVUVrBHDXz7KqpU=\\n=6wcW\\n-----END PGP SIGNATURE-----",
                "payload":
                  "tree 64bc098d18f98b3363e7a02fefba816140e17b8f\\nparent db2af03f247bec4d12a3e743b4464a70501fac77\\nauthor Ash Furrow <ash@ashfurrow.com> 1471441349 -0400\\ncommitter Ash Furrow <ash@ashfurrow.com> 1471441349 -0400\\n\\n[CI] Split up failing test + switch to syncrhonous testing.\\n"
              }
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/57b041fbbbebd075f7fe186fb754cf7cce85519c",
            "html_url": "https://github.com/artsy/eidolon/commit/57b041fbbbebd075f7fe186fb754cf7cce85519c",
            "comments_url":
              "https://api.github.com/repos/artsy/eidolon/commits/57b041fbbbebd075f7fe186fb754cf7cce85519c/comments",
            "author": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "committer": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "parents": [
              {
                "sha": "db2af03f247bec4d12a3e743b4464a70501fac77",
                "url": "https://api.github.com/repos/artsy/eidolon/commits/db2af03f247bec4d12a3e743b4464a70501fac77",
                "html_url": "https://github.com/artsy/eidolon/commit/db2af03f247bec4d12a3e743b4464a70501fac77"
              }
            ]
          },
          {
            "sha": "851e911b4e8697a0f8e3b84c19df6cec30aead2a",
            "commit": {
              "author": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-08-17T13:48:43Z"
              },
              "committer": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-08-17T13:58:30Z"
              },
              "message": "[CI] Fixes pre-launching simulator UUID.",
              "tree": {
                "sha": "9cbec8e2436334ac71c0254ff34595d24cf1c134",
                "url": "https://api.github.com/repos/artsy/eidolon/git/trees/9cbec8e2436334ac71c0254ff34595d24cf1c134"
              },
              "url": "https://api.github.com/repos/artsy/eidolon/git/commits/851e911b4e8697a0f8e3b84c19df6cec30aead2a",
              "comment_count": 0,
              "verification": {
                "verified": true,
                "reason": "valid",
                "signature":
                  "-----BEGIN PGP SIGNATURE-----\\nVersion: GnuPG v1\\n\\niQEcBAABAgAGBQJXtG2GAAoJEAGZOscENF/t+aEH/jeWQCppcnOsPt++MtyrkXkZ\\nmgnuNTlEO+ujleLrFjKnM/6I1Htv2hdPELqSLN60cYiKvXX/2pJcV2qLrVEVkkEr\\njRE2NiGaK+kM4rykmJgM8GGNoFOzbcBmlZMOVCEPmurxUTwI5V2ol7KNKVO8JfUR\\nThew4TZA4116MyIytV6jJju86Jsh7d6CEWcm99GV3yILACmipcReLd64jpsTL9lJ\\nkiEA9DynuC7c5uzKlhWbqQ3DHPRns55HKq8XL485OXupuRvqBkDRQ+Nz7nq2qMAB\\nVtPWz4OayZcYWfUqagbb9k+vQ9prePrUrVdQL5kJxFx9TQQSM5NaL5bCwl7CenQ=\\n=Xeq4\\n-----END PGP SIGNATURE-----",
                "payload":
                  "tree 9cbec8e2436334ac71c0254ff34595d24cf1c134\\nparent 57b041fbbbebd075f7fe186fb754cf7cce85519c\\nauthor Ash Furrow <ash@ashfurrow.com> 1471441723 -0400\\ncommitter Ash Furrow <ash@ashfurrow.com> 1471442310 -0400\\n\\n[CI] Fixes pre-launching simulator UUID.\\n"
              }
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/851e911b4e8697a0f8e3b84c19df6cec30aead2a",
            "html_url": "https://github.com/artsy/eidolon/commit/851e911b4e8697a0f8e3b84c19df6cec30aead2a",
            "comments_url":
              "https://api.github.com/repos/artsy/eidolon/commits/851e911b4e8697a0f8e3b84c19df6cec30aead2a/comments",
            "author": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "committer": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "parents": [
              {
                "sha": "57b041fbbbebd075f7fe186fb754cf7cce85519c",
                "url": "https://api.github.com/repos/artsy/eidolon/commits/57b041fbbbebd075f7fe186fb754cf7cce85519c",
                "html_url": "https://github.com/artsy/eidolon/commit/57b041fbbbebd075f7fe186fb754cf7cce85519c"
              }
            ]
          },
          {
            "sha": "9963a5ff97b5dbd423df740c50e01a9dffd0a3ff",
            "commit": {
              "author": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-08-17T14:10:05Z"
              },
              "committer": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-08-17T14:10:05Z"
              },
              "message": "[CI] Fixes intermittently failing test comparing dates.",
              "tree": {
                "sha": "2ab689baa382cc918289529955121d17672db7a4",
                "url": "https://api.github.com/repos/artsy/eidolon/git/trees/2ab689baa382cc918289529955121d17672db7a4"
              },
              "url": "https://api.github.com/repos/artsy/eidolon/git/commits/9963a5ff97b5dbd423df740c50e01a9dffd0a3ff",
              "comment_count": 0,
              "verification": {
                "verified": true,
                "reason": "valid",
                "signature":
                  "-----BEGIN PGP SIGNATURE-----\\nVersion: GnuPG v1\\n\\niQEcBAABAgAGBQJXtHA9AAoJEAGZOscENF/tEmMH/01CQiUbjR1nSrsah3gyFe0S\\nJUSXip0aMniLDdkKht/x457w5nmujXjpoOrcbB02G+5q142Psv4otc28lg0XWZCi\\ns4Gg5acpZRV/d+Dw0ruOnwGwcz+KPvmD9Pfx1F8h/q519Qmhto6rw3na8uMLG4Zr\\ndYS79EcVCceU2BkpTl2PlEe7lIJmUqEv7WJYyH+//Wu7EQfor/Mu0VijwmDx3Nxi\\n6NvaPPzayk/lpj4s02vvdfqvl/+mVZ5N3PHTLoDJb8VlJs49C5tGEwhsUjKHqAfF\\nwBfFIJEkcqbgrOM7NoHmGjlAiGpWhCc6CuFmsCWMTfo/Vay/VQOtP8B/S5jA9R4=\\n=V+Iy\\n-----END PGP SIGNATURE-----",
                "payload":
                  "tree 2ab689baa382cc918289529955121d17672db7a4\\nparent 851e911b4e8697a0f8e3b84c19df6cec30aead2a\\nauthor Ash Furrow <ash@ashfurrow.com> 1471443005 -0400\\ncommitter Ash Furrow <ash@ashfurrow.com> 1471443005 -0400\\n\\n[CI] Fixes intermittently failing test comparing dates.\\n"
              }
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/9963a5ff97b5dbd423df740c50e01a9dffd0a3ff",
            "html_url": "https://github.com/artsy/eidolon/commit/9963a5ff97b5dbd423df740c50e01a9dffd0a3ff",
            "comments_url":
              "https://api.github.com/repos/artsy/eidolon/commits/9963a5ff97b5dbd423df740c50e01a9dffd0a3ff/comments",
            "author": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "committer": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "parents": [
              {
                "sha": "851e911b4e8697a0f8e3b84c19df6cec30aead2a",
                "url": "https://api.github.com/repos/artsy/eidolon/commits/851e911b4e8697a0f8e3b84c19df6cec30aead2a",
                "html_url": "https://github.com/artsy/eidolon/commit/851e911b4e8697a0f8e3b84c19df6cec30aead2a"
              }
            ]
          },
          {
            "sha": "1aa0360bc7a95d7878160ae91eea62324ac3252f",
            "commit": {
              "author": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-08-17T14:41:27Z"
              },
              "committer": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-08-17T14:41:27Z"
              },
              "message": "[Deps] Updates dependencies to latest Swift 2.x versions.",
              "tree": {
                "sha": "0ef37421cfa8cbd2d729e58de786b77f6219d3ad",
                "url": "https://api.github.com/repos/artsy/eidolon/git/trees/0ef37421cfa8cbd2d729e58de786b77f6219d3ad"
              },
              "url": "https://api.github.com/repos/artsy/eidolon/git/commits/1aa0360bc7a95d7878160ae91eea62324ac3252f",
              "comment_count": 0,
              "verification": {
                "verified": true,
                "reason": "valid",
                "signature":
                  "-----BEGIN PGP SIGNATURE-----\\nVersion: GnuPG v1\\n\\niQEcBAABAgAGBQJXtHeXAAoJEAGZOscENF/tyyMH/RITs+ltv0iMgnuslqa2sguo\\n7LlkBGzCzgiiMh0LRrdeOLlL3/XRj5n/bw3ABY8iO4JDKRgd4XsokArtp60G28Gg\\nUCC5XcY8/6Prhgz7xET1GDOSXglwrgvJuxCg7hk20Oui8QRdUXEriWSMwpJyuqSq\\nnF8zevD0hHu/v5lMwn6qmiUeF993DOwemzAyydbU6WU4k1Hd+03B9/wk004Df6Mi\\nhQVOQLK1D98RqrfM4ZOXIS9YqU/bJ0SiK1OllMD1gjNm3RHEMMeaGSBkTMHoh+JM\\nist/zkq2NlxLEQoyeLoOyhM0re/s19qkAQwYCAL146zes53NO3JUR8yTmXXyjwE=\\n=DTkl\\n-----END PGP SIGNATURE-----",
                "payload":
                  "tree 0ef37421cfa8cbd2d729e58de786b77f6219d3ad\\nparent 9963a5ff97b5dbd423df740c50e01a9dffd0a3ff\\nauthor Ash Furrow <ash@ashfurrow.com> 1471444887 -0400\\ncommitter Ash Furrow <ash@ashfurrow.com> 1471444887 -0400\\n\\n[Deps] Updates dependencies to latest Swift 2.x versions.\\n"
              }
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/1aa0360bc7a95d7878160ae91eea62324ac3252f",
            "html_url": "https://github.com/artsy/eidolon/commit/1aa0360bc7a95d7878160ae91eea62324ac3252f",
            "comments_url":
              "https://api.github.com/repos/artsy/eidolon/commits/1aa0360bc7a95d7878160ae91eea62324ac3252f/comments",
            "author": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "committer": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "parents": [
              {
                "sha": "9963a5ff97b5dbd423df740c50e01a9dffd0a3ff",
                "url": "https://api.github.com/repos/artsy/eidolon/commits/9963a5ff97b5dbd423df740c50e01a9dffd0a3ff",
                "html_url": "https://github.com/artsy/eidolon/commit/9963a5ff97b5dbd423df740c50e01a9dffd0a3ff"
              }
            ]
          },
          {
            "sha": "fb0688c603ddb48afe0edad336d3a7fac6f5e9f7",
            "commit": {
              "author": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-08-17T14:41:31Z"
              },
              "committer": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-08-17T14:41:31Z"
              },
              "message": "[CI] Fixes more intermittent tests.",
              "tree": {
                "sha": "00271b152921db4988396350eca46ed6b19f6649",
                "url": "https://api.github.com/repos/artsy/eidolon/git/trees/00271b152921db4988396350eca46ed6b19f6649"
              },
              "url": "https://api.github.com/repos/artsy/eidolon/git/commits/fb0688c603ddb48afe0edad336d3a7fac6f5e9f7",
              "comment_count": 0,
              "verification": {
                "verified": true,
                "reason": "valid",
                "signature":
                  "-----BEGIN PGP SIGNATURE-----\\nVersion: GnuPG v1\\n\\niQEcBAABAgAGBQJXtHebAAoJEAGZOscENF/tpc4IAJO53SzcBv08DG7z0iwZgY0E\\nIDiTh7bfvyXrUGP/0nE6n+zLTpDYFHPhWGrlPHn4V/VjZP3ejMWiy4u4qHdlUym0\\nREK/pjRCqgcF8nz64DujNOExS/1VLpxv/Ee5dnA4tE7m98yjWwvOEOBmy0IT5BH3\\npFwog810/UktH7/Oybe+dJYCDdRPpi9LxBlScm6YNP4ZnBMYmK2UPuivF71yNdYe\\n5qoQhSuxSNCrW/1211dB4z3SwbeAKO+SnxA3MKdW2qE92Zx59dQ6h6J5ked0hrlQ\\n3r8VfwAT9XHtgAu8SDTTu3kRTb6s80KFkN8C4ZgYog2I8kGafo1wPK+VKEFd/qQ=\\n=f2wx\\n-----END PGP SIGNATURE-----",
                "payload":
                  "tree 00271b152921db4988396350eca46ed6b19f6649\\nparent 1aa0360bc7a95d7878160ae91eea62324ac3252f\\nauthor Ash Furrow <ash@ashfurrow.com> 1471444891 -0400\\ncommitter Ash Furrow <ash@ashfurrow.com> 1471444891 -0400\\n\\n[CI] Fixes more intermittent tests.\\n"
              }
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/fb0688c603ddb48afe0edad336d3a7fac6f5e9f7",
            "html_url": "https://github.com/artsy/eidolon/commit/fb0688c603ddb48afe0edad336d3a7fac6f5e9f7",
            "comments_url":
              "https://api.github.com/repos/artsy/eidolon/commits/fb0688c603ddb48afe0edad336d3a7fac6f5e9f7/comments",
            "author": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "committer": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "parents": [
              {
                "sha": "1aa0360bc7a95d7878160ae91eea62324ac3252f",
                "url": "https://api.github.com/repos/artsy/eidolon/commits/1aa0360bc7a95d7878160ae91eea62324ac3252f",
                "html_url": "https://github.com/artsy/eidolon/commit/1aa0360bc7a95d7878160ae91eea62324ac3252f"
              }
            ]
          },
          {
            "sha": "c6eb849f100cbaa261680ee0d3dc819b91aa8af1",
            "commit": {
              "author": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-08-17T14:55:34Z"
              },
              "committer": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-08-17T14:55:34Z"
              },
              "message": "[CI] Removed duplicate simulator launch.",
              "tree": {
                "sha": "965807f296e1a3fb30134508062825cf30806786",
                "url": "https://api.github.com/repos/artsy/eidolon/git/trees/965807f296e1a3fb30134508062825cf30806786"
              },
              "url": "https://api.github.com/repos/artsy/eidolon/git/commits/c6eb849f100cbaa261680ee0d3dc819b91aa8af1",
              "comment_count": 0,
              "verification": {
                "verified": true,
                "reason": "valid",
                "signature":
                  "-----BEGIN PGP SIGNATURE-----\\nVersion: GnuPG v1\\n\\niQEcBAABAgAGBQJXtHrmAAoJEAGZOscENF/txKwH/i0ESvgDTSI5rhjnTZ/ToLbS\\nZFR1P39iGdmsaj/V2kXYPlXZt7DetxHtGIcncP1odJtCtrxOiG8Da9WxmCSUtqCa\\nKok4dYVOTRuDeaGBYEUWJmTNRRlAs5JY5vNsC4w3jZjnoelJD17aqupHxHrm5nUl\\ntKJ1qt3+qXbNvK1LZZ2U65D1ldyrI03tri0v0Y50sD4VJW5Mj7Nzv8DpmC6MpVqy\\nEZMqarkVIjxhzYqVG5Y+Sxu7oDrAujJGO7FwnuMxArek6cHK1oV53/KUrbq+OLLx\\nrGL7qvS0bn1gJk7evLTzyUkIw49YoQKKv3MsMYNeyz9f7Hpunk6/ARfDeXc9QHM=\\n=1oGo\\n-----END PGP SIGNATURE-----",
                "payload":
                  "tree 965807f296e1a3fb30134508062825cf30806786\\nparent fb0688c603ddb48afe0edad336d3a7fac6f5e9f7\\nauthor Ash Furrow <ash@ashfurrow.com> 1471445734 -0400\\ncommitter Ash Furrow <ash@ashfurrow.com> 1471445734 -0400\\n\\n[CI] Removed duplicate simulator launch.\\n"
              }
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/c6eb849f100cbaa261680ee0d3dc819b91aa8af1",
            "html_url": "https://github.com/artsy/eidolon/commit/c6eb849f100cbaa261680ee0d3dc819b91aa8af1",
            "comments_url":
              "https://api.github.com/repos/artsy/eidolon/commits/c6eb849f100cbaa261680ee0d3dc819b91aa8af1/comments",
            "author": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "committer": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "parents": [
              {
                "sha": "fb0688c603ddb48afe0edad336d3a7fac6f5e9f7",
                "url": "https://api.github.com/repos/artsy/eidolon/commits/fb0688c603ddb48afe0edad336d3a7fac6f5e9f7",
                "html_url": "https://github.com/artsy/eidolon/commit/fb0688c603ddb48afe0edad336d3a7fac6f5e9f7"
              }
            ]
          },
          {
            "sha": "d769f276e066d79169a8bfa5795c8a4853f942f3",
            "commit": {
              "author": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-08-17T15:14:19Z"
              },
              "committer": {
                "name": "Ash Furrow",
                "email": "ash@ashfurrow.com",
                "date": "2016-08-17T15:20:42Z"
              },
              "message": "[Feedback] Adds clarifying comments as per feedback in #609.",
              "tree": {
                "sha": "9004fe3df2b4d7d3285460095c37d9f62b4be26a",
                "url": "https://api.github.com/repos/artsy/eidolon/git/trees/9004fe3df2b4d7d3285460095c37d9f62b4be26a"
              },
              "url": "https://api.github.com/repos/artsy/eidolon/git/commits/d769f276e066d79169a8bfa5795c8a4853f942f3",
              "comment_count": 0,
              "verification": {
                "verified": true,
                "reason": "valid",
                "signature":
                  "-----BEGIN PGP SIGNATURE-----\\nVersion: GnuPG v1\\n\\niQEcBAABAgAGBQJXtIDSAAoJEAGZOscENF/t97IIAIpVyF0YdulieeRvqhmG/D9S\\nATYdQAyjLbTCVs/ijNU+ZRO7dJpKaetbg93jeKW8uIjrAevu9RR/Y0HKpb0p79Gk\\n7SczAaTeADwsX3IU4StOSKG1sS2KZOI2TR9+uYd0O5EcTn5jrfy7GmZBQCgUkuJp\\n7a/cqm+5jSH4yaDjV9hrn2HmhfBzOYzW5I+6kfdOhbyQIGTADmyjzfxClAK+7sts\\nes52DCOSX3/R/AI6JX/igH9vKcvuN5bYMnoAWI7Ko0AMiWubDY2rzpEl3w3x2ycc\\nKRKSNP4NGxq3PU3pfsVzSdFpf8QjvWtGsoZ+yVpq/1hb2PSvMx81CbEJwyf8xoc=\\n=RQgX\\n-----END PGP SIGNATURE-----",
                "payload":
                  "tree 9004fe3df2b4d7d3285460095c37d9f62b4be26a\\nparent c6eb849f100cbaa261680ee0d3dc819b91aa8af1\\nauthor Ash Furrow <ash@ashfurrow.com> 1471446859 -0400\\ncommitter Ash Furrow <ash@ashfurrow.com> 1471447242 -0400\\n\\n[Feedback] Adds clarifying comments as per feedback in #609.\\n"
              }
            },
            "url": "https://api.github.com/repos/artsy/eidolon/commits/d769f276e066d79169a8bfa5795c8a4853f942f3",
            "html_url": "https://github.com/artsy/eidolon/commit/d769f276e066d79169a8bfa5795c8a4853f942f3",
            "comments_url":
              "https://api.github.com/repos/artsy/eidolon/commits/d769f276e066d79169a8bfa5795c8a4853f942f3/comments",
            "author": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "committer": {
              "login": "ashfurrow",
              "id": 498212,
              "avatar_url": "https://avatars3.githubusercontent.com/u/498212?v=4",
              "gravatar_id": "",
              "url": "https://api.github.com/users/ashfurrow",
              "html_url": "https://github.com/ashfurrow",
              "followers_url": "https://api.github.com/users/ashfurrow/followers",
              "following_url": "https://api.github.com/users/ashfurrow/following{/other_user}",
              "gists_url": "https://api.github.com/users/ashfurrow/gists{/gist_id}",
              "starred_url": "https://api.github.com/users/ashfurrow/starred{/owner}{/repo}",
              "subscriptions_url": "https://api.github.com/users/ashfurrow/subscriptions",
              "organizations_url": "https://api.github.com/users/ashfurrow/orgs",
              "repos_url": "https://api.github.com/users/ashfurrow/repos",
              "events_url": "https://api.github.com/users/ashfurrow/events{/privacy}",
              "received_events_url": "https://api.github.com/users/ashfurrow/received_events",
              "type": "User",
              "site_admin": false
            },
            "parents": [
              {
                "sha": "c6eb849f100cbaa261680ee0d3dc819b91aa8af1",
                "url": "https://api.github.com/repos/artsy/eidolon/commits/c6eb849f100cbaa261680ee0d3dc819b91aa8af1",
                "html_url": "https://github.com/artsy/eidolon/commit/c6eb849f100cbaa261680ee0d3dc819b91aa8af1"
              }
            ]
          }
        ],
        "reviews": [],
        "requested_reviewers": {
          "users": [
                    {
                    "login": "octocat",
                    "id": 1,
                    "avatar_url": "https://github.com/images/error/octocat_happy.gif",
                    "gravatar_id": "",
                    "url": "https://api.github.com/users/octocat",
                    "html_url": "https://github.com/octocat",
                    "followers_url": "https://api.github.com/users/octocat/followers",
                    "following_url": "https://api.github.com/users/octocat/following{/other_user}",
                    "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
                    "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
                    "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
                    "organizations_url": "https://api.github.com/users/octocat/orgs",
                    "repos_url": "https://api.github.com/users/octocat/repos",
                    "events_url": "https://api.github.com/users/octocat/events{/privacy}",
                    "received_events_url": "https://api.github.com/users/octocat/received_events",
                    "type": "User",
                    "site_admin": false
                    }
            ],
          "teams": [
                    {
                    "id": 1,
                    "url": "https://api.github.com/teams/1",
                    "name": "Justice League",
                    "slug": "justice-league",
                    "description": "A great team.",
                    "privacy": "closed",
                    "permission": "admin",
                    "members_url": "https://api.github.com/teams/1/members{/member}",
                    "repositories_url": "https://api.github.com/teams/1/repos"
                    }
            ]
        },
        "thisPR": {
          "number": 609,
          "repo": "eidolon",
          "owner": "artsy"
        }
      },
      "settings": {
        "github": {
          "accessToken": "7bd263f8e4becaa3d29b25d534fe6d5f3b555ccf",
          "additionalHeaders": {}
        },
        "cliArgs": {}
      }
    }
}

"""
