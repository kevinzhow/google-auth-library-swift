// swift-tools-version:5.1

//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


import PackageDescription

let package = Package(
  name: "Auth",
  platforms: [
    .macOS(.v10_15), .iOS(.v9), .tvOS(.v9)
  ],
  products: [
    .library(name: "OAuth1", targets: ["OAuth1"]),
    .library(name: "OAuth2", targets: ["OAuth2"]),
    .library(name: "TinyHTTPServer", targets: ["TinyHTTPServer"]),
    .library(name: "SwiftyBase64", targets: ["SwiftyBase64"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-nio.git", from: "2.59.0"),
    .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", from: "1.8.1"),
    .package(url: "https://github.com/attaswift/BigInt.git", from: "5.0.0"),
    .package(url: "https://github.com/vapor/jwt-kit.git", from: "4.0.0"),
  ],
  targets: [
    .target(name: "OAuth1",
            dependencies: [
                .product(name: "CryptoSwift", package: "CryptoSwift"),
                "TinyHTTPServer"
            ]),
    .target(name: "OAuth2",
            dependencies: [.product(name: "CryptoSwift", package: "CryptoSwift"),
                           "TinyHTTPServer",
                           .product(name: "BigInt", package: "BigInt"),
                           "SwiftyBase64",
                           .product(name: "JWTKit", package: "jwt-kit")
                          ],
            exclude: ["FCMTokenProvider"]),
    .target(name: "TinyHTTPServer",
	    dependencies: [.product(name: "NIO" , package: "swift-nio"),
                       .product(name: "NIOHTTP1" , package: "swift-nio")]),
    .target(name: "SwiftyBase64"),
    .target(name: "TokenSource", dependencies: ["OAuth2"], path: "Sources/Examples/TokenSource"),
    .target(name: "Google",      dependencies: ["OAuth2"], path: "Sources/Examples/Google"),
    .target(name: "GitHub",      dependencies: ["OAuth2"], path: "Sources/Examples/GitHub"),
    .target(name: "Meetup",      dependencies: ["OAuth2"], path: "Sources/Examples/Meetup"),
    .target(name: "Spotify",     dependencies: ["OAuth2"], path: "Sources/Examples/Spotify"),
    .target(name: "Twitter",     dependencies: ["OAuth1"], path: "Sources/Examples/Twitter"),
  ]
)
