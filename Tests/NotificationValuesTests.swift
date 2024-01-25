import XCTest
@testable import NotificationValues

final class NotificationValuesTests: XCTestCase {
    struct Fixture: Equatable {
        let id = UUID()
    }

    enum FixtureKey: NotificationKey {
        static let name = Notification.Name("FixtureKeyNotification")
        typealias Value = Fixture
    }

    private let center = NotificationCenter()

    func testValuesSequence() async throws {
        let fixture = Fixture()
        let values = center.values(for: FixtureKey.self)

        center.post(fixture, for: FixtureKey.self)

        let result = try await XCTAsyncUnwrap(
            await values.first
        )

        XCTAssertEqual(result, fixture)
    }

    func testValuesPublisher() throws {
        final class Box {
            var value: Fixture?
        }

        let fixture = Fixture()
        let box = Box()
        let handle = center
            .valuesPublisher(for: FixtureKey.self)
            .map(Optional.init)
            .assign(to: \.value, on: box)

        center.post(fixture, for: FixtureKey.self)

        let result = try XCTUnwrap(box.value)

        XCTAssertEqual(result, fixture)

        handle.cancel()
    }
}

// MARK: - Helpers

func XCTAsyncUnwrap<T>(
    _ expression: @autoclosure () async throws -> T?,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) async throws -> T {
    let result = try await expression()
    return try XCTUnwrap(result, message(), file: file, line: line)
}

extension AsyncSequence {
    var first: Element? {
        get async throws {
            try await first(where: { _ in true })
        }
    }
}
