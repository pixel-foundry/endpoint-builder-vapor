import EndpointBuilder
import HTTPTypes
import Vapor

extension RoutesBuilder {

	@discardableResult
	@inlinable
	public func endpoint<E: Endpoint>(
		_ endpoint: E.Type,
		handler: @escaping (Request) async throws -> E.Response
	) -> Route where E.Response: AsyncResponseEncodable, E.BodyContent == Never {
		self.on(
			HTTPMethod(rawValue: endpoint.httpMethod.rawValue),
			endpoint.path
		) { request async throws -> E.Response in
			return try await handler(request)
		}
	}

	@discardableResult
	@inlinable
	public func endpoint<E: Endpoint>(
		_ endpoint: E.Type,
		handler: @escaping (Request, E.BodyContent) async throws -> E.Response
	) -> Route where E.Response: AsyncResponseEncodable {
		self.on(
			HTTPMethod(rawValue: endpoint.httpMethod.rawValue),
			endpoint.path
		) { request async throws -> E.Response in
			let content = try request.content.decode(endpoint.BodyContent)
			return try await handler(request, content)
		}
	}

}
