// swift-tools-version:5.9
import PackageDescription

let package = Package(
	name: "endpoint-builder-vapor",
	platforms: [
		.iOS(.v13),
		.tvOS(.v13),
		.macOS(.v10_15),
		.watchOS(.v6),
		.visionOS(.v1)
	],
	products: [
		.library(name: "EndpointBuilderVapor", targets: ["EndpointBuilderVapor"])
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-http-types", from: "1.0.0"),
		.package(url: "https://github.com/pixel-foundry/endpoint-builder", from: "0.0.2"),
		.package(url: "https://github.com/vapor/routing-kit", from: "4.9.0"),
		.package(url: "https://github.com/vapor/vapor", from: "4.0.0")
	],
	targets: [
		.target(
			name: "EndpointBuilderVapor",
			dependencies: [
				.product(name: "EndpointBuilder", package: "endpoint-builder"),
				.product(name: "HTTPTypes", package: "swift-http-types"),
				.product(name: "RoutingKit", package: "routing-kit"),
				.product(name: "Vapor", package: "vapor")
			]
		),
		.testTarget(
			name: "EndpointBuilderVaporTests",
			dependencies: [
				.byName(name: "EndpointBuilderVapor"),
				.product(name: "EndpointBuilder", package: "endpoint-builder"),
				.product(name: "HTTPTypes", package: "swift-http-types"),
				.product(name: "RoutingKit", package: "routing-kit"),
				.product(name: "Vapor", package: "vapor")
			]
		)
	]
)
