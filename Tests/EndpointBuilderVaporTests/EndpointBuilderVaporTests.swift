import EndpointBuilder
@testable import EndpointBuilderVapor
import HTTPTypes
import RoutingKit
import Vapor
import XCTest

final class EndpointBuilderVaporTests: XCTestCase {

	@Endpoint
	struct TestEndpoint: Endpoint {
		static let path: [PathComponent] = ["test", ":id"]
		static let httpMethod = HTTPRequest.Method.get
		static let responseType = String.self
	}

	@Endpoint
	struct TestEndpointWithRequestType: Endpoint {
		static let path: [PathComponent] = ["test"]
		static let httpMethod = HTTPRequest.Method.put
		static let responseType = String.self
		let body: String
	}

	func testEndpointRegistration() {
		let routes = Routes()
		routes.endpoint(TestEndpoint.self) { _ in "Test" }
		XCTAssertEqual(routes.all.first?.path, ["test", ":id"])
		XCTAssertEqual(routes.all.first?.method, .GET)
		XCTAssertTrue(routes.all.first?.responseType == String.self)
	}

	func testEndpointRegistrationWithRequestBody() {
		let routes = Routes()
		routes.endpoint(TestEndpointWithRequestType.self) { _, body in body }
		XCTAssertEqual(routes.all.first?.path, ["test"])
		XCTAssertEqual(routes.all.first?.method, .PUT)
		XCTAssertTrue(routes.all.first?.responseType == String.self)
	}

}
