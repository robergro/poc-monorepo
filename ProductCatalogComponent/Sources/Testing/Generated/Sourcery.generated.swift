// Generated using Sourcery 2.2.3 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable all

import Foundation
import UIKit
import SwiftUI
import XCTest
import Testing

import Combine



@_spi(SI_SPI) public final class PCGetBorderUseCaseableMockTest {

    // MARK: - Initialization

    private init(){
    }

    // MARK: - XCTest


    public static func XCTCallsCount(
        _ mock: PCGetBorderUseCaseableGeneratedMock,
        executeWithThemeNumberOfCalls numberOfCalls: Int
    ) {
        XCTAssertEqual(
            mock.executeWithThemeCallsCount,
            numberOfCalls,
            "Wrong execute(theme: Bool) number of called on PCGetBorderUseCaseable"
        )
    }

    public static func XCTCalled(
        _ mock: PCGetBorderUseCaseableGeneratedMock,
        executeWithThemeCalled isCalled: Bool
    ) {
        XCTAssertEqual(
            mock.executeWithThemeCalled,
            isCalled,
            "Wrong execute(theme: Bool) isCalled on PCGetBorderUseCaseable"
        )
    }

    public static func XCTAssert(
        _ mock: PCGetBorderUseCaseableGeneratedMock,
        expectedNumberOfCalls: Int,
        givenTheme: Bool? = nil, 
        expectedReturnValue: String
    ) {
        // Count
        XCTAssertEqual(
            mock.executeWithThemeCallsCount,
            expectedNumberOfCalls,
            "Wrong execute(theme: Bool) number of called on PCGetBorderUseCaseable"
        )

        // Parameters
        if expectedNumberOfCalls > 0 {
            // Theme
            if let givenTheme {
                XCTAssertEqual(
                    mock.executeWithThemeReceivedTheme,
                    givenTheme,
                    "Wrong execute(theme: Bool) theme parameter on PCGetBorderUseCaseable"
                )
            } else {
                XCTAssertNil(
                    mock.executeWithThemeReceivedTheme,
                    "Wrong execute(theme: Bool) theme parameter value on PCGetBorderUseCaseable. Should be nil"
                )
            }

        }

        // Return
            XCTAssertEqual(
                mock.executeWithThemeReturnValue,
                expectedReturnValue,
                "Wrong execute(theme: Bool) return value on PCGetBorderUseCaseable"
            )
    }


    // MARK: - Swift Testing


    public static func expectCallsCount(
        _ mock: PCGetBorderUseCaseableGeneratedMock,
        executeWithThemeNumberOfCalls numberOfCalls: Int,
        sourceLocation: Testing.SourceLocation = #_sourceLocation
    ) {
        #expect(
            mock.executeWithThemeCallsCount == numberOfCalls,
            "Wrong execute(theme: Bool) number of called on PCGetBorderUseCaseable. Expected \(numberOfCalls), got \(mock.executeWithThemeCallsCount)",
            sourceLocation: sourceLocation
        )
    }

    public static func expectCalled(
        _ mock: PCGetBorderUseCaseableGeneratedMock,
        executeWithThemeCalled isCalled: Bool,
        sourceLocation: Testing.SourceLocation = #_sourceLocation
    ) {
        #expect(
            mock.executeWithThemeCalled == isCalled,
            "Wrong execute(theme: Bool) isCalled on PCGetBorderUseCaseable. Expected \(isCalled), got \(mock.executeWithThemeCalled)",
            sourceLocation: sourceLocation
        )
    }

    public static func expect(
        _ mock: PCGetBorderUseCaseableGeneratedMock,
        expectedNumberOfCalls: Int,
        givenTheme: Bool? = nil, 
        expectedReturnValue: String,
        sourceLocation: Testing.SourceLocation = #_sourceLocation
    ) {
        // Count
        #expect(
            mock.executeWithThemeCallsCount == expectedNumberOfCalls,
            "Wrong execute(theme: Bool) number of called on PCGetBorderUseCaseable. Expected \(expectedNumberOfCalls), got \(mock.executeWithThemeCallsCount)",
            sourceLocation: sourceLocation
        )

        // Parameters
        if expectedNumberOfCalls > 0 {
            // Theme
            if let givenTheme {

                #expect(
                    mock.executeWithThemeReceivedTheme == givenTheme,
                    "Wrong execute(theme: Bool) theme parameter on PCGetBorderUseCaseable. Expected \(String(describing: givenTheme)), got \(String(describing: mock.executeWithThemeReceivedTheme))",
                    sourceLocation: sourceLocation
                )
            } else {
                #expect(
                    mock.executeWithThemeReceivedTheme == nil,
                    "Wrong execute(theme: Bool) theme parameter value on PCGetBorderUseCaseable. Should be nil but got \(String(describing: mock.executeWithThemeReceivedTheme))",
                    sourceLocation: sourceLocation
                )
            }

        }

        // Return
        #expect(
            mock.executeWithThemeReturnValue == expectedReturnValue,
            "Wrong execute(theme: Bool) return value on PCGetBorderUseCaseable. Expected \(String(describing: expectedReturnValue)), got \(String(describing: mock.executeWithThemeReturnValue))",
            sourceLocation: sourceLocation
        )
    }

}



@testable import ProductCatalogComponent





@_spi(SI_SPI) public final class PCGetBorderUseCaseableGeneratedMock: ProductCatalogComponent.PCGetBorderUseCaseable, ResetGeneratedMock {


    // MARK: - Initialization

    public init() {}

    // MARK: - execute

    public var executeWithThemeCallsCount = 0
    public var executeWithThemeCalled: Bool {
        return executeWithThemeCallsCount > 0
    }
    public var executeWithThemeReceivedTheme: Bool?
    public var executeWithThemeReceivedInvocations: [Bool] = []
    public var executeWithThemeReturnValue: String = ""
    public var _executeWithTheme: ((Bool) -> String)?
    public func execute(theme: Bool) -> String {
        executeWithThemeCallsCount += 1
        executeWithThemeReceivedTheme = theme
        executeWithThemeReceivedInvocations.append(theme)
        return _executeWithTheme.map({ $0(theme) }) ?? executeWithThemeReturnValue
    }

    // MARK: Reset 

    public func reset() {
        executeWithThemeCallsCount = 0
        executeWithThemeReceivedTheme = nil 
        executeWithThemeReceivedInvocations = []
    }
}

// MARK: - Reset

public protocol ResetGeneratedMock {
    func reset()
}






