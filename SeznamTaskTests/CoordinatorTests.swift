//
//  CoordinatorTests.swift
//  SeznamTaskTests
//
//  Created by macbook on 25.02.2025.
//

@testable import SeznamTask
import SwiftUI
import XCTest

final class CoordinatorTests: XCTestCase {
    private var coordinator: Coordinator!

    override func setUpWithError() throws {
        try super.setUpWithError()
        coordinator = Coordinator()
    }

    override func tearDownWithError() throws {
        coordinator = nil
        try super.tearDownWithError()
    }

    // MARK: - Navigation Path Tests

    func test_PushPage_ShouldAddPageToNavigationPath() {
        // Given
        XCTAssertEqual(coordinator.path.count, 0)

        // When
        coordinator.push(page: .searchPage)

        // Then
        XCTAssertEqual(coordinator.path.count, 1)
    }

    func test_PopPage_ShouldRemoveLastPage() {
        // Given
        coordinator.push(page: .searchPage)
        XCTAssertEqual(coordinator.path.count, 1)

        // When
        coordinator.pop()

        // Then
        XCTAssertTrue(coordinator.path.isEmpty)
    }

    func test_PopToRoot_ShouldRemoveAllPages() {
        // Given
        coordinator.push(page: .searchPage)
        coordinator.push(page: .detailPage(1))
        XCTAssertEqual(coordinator.path.count, 2)

        // When
        coordinator.popToRoot()

        // Then
        XCTAssertTrue(coordinator.path.isEmpty)
    }

    // MARK: - Sheet Presentation Tests

    func test_PresentSheet_ShouldSetSheetValue() {
        // Given
        XCTAssertNil(coordinator.sheet)

        // When
        coordinator.presentSheet(.zero)

        // Then
        XCTAssertNotNil(coordinator.sheet)
        XCTAssertEqual(coordinator.sheet, .zero)
    }

    func test_DismissSheet_ShouldRemoveSheet() {
        // Given
        coordinator.presentSheet(.zero)
        XCTAssertNotNil(coordinator.sheet)

        // When
        coordinator.dismissSheet()

        // Then
        XCTAssertNil(coordinator.sheet)
    }

    // MARK: - Full Screen Cover Presentation Tests

    func test_PresentFullScreenCover_ShouldSetCoverValue() {
        // Given
        XCTAssertNil(coordinator.fullScreenCover)

        // When
        coordinator.presentFullScreenCover(.zero)

        // Then
        XCTAssertNotNil(coordinator.fullScreenCover)
        XCTAssertEqual(coordinator.fullScreenCover, .zero)
    }

    func test_DismissFullScreenCover_ShouldRemoveCover() {
        // Given
        coordinator.presentFullScreenCover(.zero)
        XCTAssertNotNil(coordinator.fullScreenCover)

        // When
        coordinator.dismissCover()

        // Then
        XCTAssertNil(coordinator.fullScreenCover)
    }
}
