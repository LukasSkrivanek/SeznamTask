//
//  NetworkManagerTests.swift
//  SeznamTask
//
//  Created by macbook on 03.03.2025.
//

@testable import SeznamTask
import XCTest

class NetworkManagerTests: XCTestCase {
    var networkManager: NetworkManager!
    var mockSession: URLSession!

    override func setUp() {
        super.setUp()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        mockSession = URLSession(configuration: config)
        networkManager = NetworkManager(session: mockSession)
    }

    override func tearDown() {
        networkManager = nil
        mockSession = nil
        super.tearDown()
    }

    func testFetchSuccess() async {
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, MockData.mockResponseData)
        }
        let endpoint = GoogleBooksEndpoint(author: "Test Author")
        do {
            let result: GoogleBooksResponseDTO = try await networkManager.fetch(from: endpoint)
            XCTAssertEqual(result.items?.count, 1)
            XCTAssertEqual(result.items?.first?.volumeInfo.title, "Test Book")
        } catch {
            XCTFail("Fetch should not fail: \(error)")
        }
    }

    func testFetchFailure() async {
        MockURLProtocol.requestHandler = { _ in
            throw URLError(.notConnectedToInternet)
        }

        let endpoint = GoogleBooksEndpoint(author: "Test Author")
        do {
            let _: GoogleBooksResponseDTO = try await networkManager.fetch(from: endpoint)
            XCTFail("Fetch should fail")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }
}
