// Generated using Sourcery 2.2.3 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable all

import Foundation
import UIKit
import SwiftUI
import XCTest
import Testing

import Combine



@_spi(SI_SPI) public final class CardGetBorderUseCaseableMockTest {

    // MARK: - Initialization

    private init(){
    }

    // MARK: - XCTest


    public static func XCTCallsCount(
        _ mock: CardGetBorderUseCaseableGeneratedMock,
        executeWithThemeNumberOfCalls numberOfCalls: Int
    ) {
        XCTAssertEqual(
            mock.executeWithThemeCallsCount,
            numberOfCalls,
            "Wrong execute(theme: any Theme) number of called on CardGetBorderUseCaseable"
        )
    }

    public static func XCTCalled(
        _ mock: CardGetBorderUseCaseableGeneratedMock,
        executeWithThemeCalled isCalled: Bool
    ) {
        XCTAssertEqual(
            mock.executeWithThemeCalled,
            isCalled,
            "Wrong execute(theme: any Theme) isCalled on CardGetBorderUseCaseable"
        )
    }

    public static func XCTAssert<
        _Theme: AnyObject
    >(
        _ mock: CardGetBorderUseCaseableGeneratedMock,
        expectedNumberOfCalls: Int,
        givenTheme: _Theme? = nil, 
        expectedReturnValue: String
    ) {
        // Count
        XCTAssertEqual(
            mock.executeWithThemeCallsCount,
            expectedNumberOfCalls,
            "Wrong execute(theme: any Theme) number of called on CardGetBorderUseCaseable"
        )

        // Parameters
        if expectedNumberOfCalls > 0 {
            // Theme
            if let givenTheme {
                XCTAssertIdentical(
                    mock.executeWithThemeReceivedTheme as? _Theme,
                    givenTheme,
                    "Wrong execute(theme: any Theme) theme parameter on CardGetBorderUseCaseable"
                )
            } else {
                XCTAssertNil(
                    mock.executeWithThemeReceivedTheme,
                    "Wrong execute(theme: any Theme) theme parameter value on CardGetBorderUseCaseable. Should be nil"
                )
            }

        }

        // Return
            XCTAssertEqual(
                mock.executeWithThemeReturnValue,
                expectedReturnValue,
                "Wrong execute(theme: any Theme) return value on CardGetBorderUseCaseable"
            )
    }


    // MARK: - Swift Testing


    public static func expectCallsCount(
        _ mock: CardGetBorderUseCaseableGeneratedMock,
        executeWithThemeNumberOfCalls numberOfCalls: Int,
        sourceLocation: Testing.SourceLocation = #_sourceLocation
    ) {
        #expect(
            mock.executeWithThemeCallsCount == numberOfCalls,
            "Wrong execute(theme: any Theme) number of called on CardGetBorderUseCaseable. Expected \(numberOfCalls), got \(mock.executeWithThemeCallsCount)",
            sourceLocation: sourceLocation
        )
    }

    public static func expectCalled(
        _ mock: CardGetBorderUseCaseableGeneratedMock,
        executeWithThemeCalled isCalled: Bool,
        sourceLocation: Testing.SourceLocation = #_sourceLocation
    ) {
        #expect(
            mock.executeWithThemeCalled == isCalled,
            "Wrong execute(theme: any Theme) isCalled on CardGetBorderUseCaseable. Expected \(isCalled), got \(mock.executeWithThemeCalled)",
            sourceLocation: sourceLocation
        )
    }

    public static func expect<
        _Theme: AnyObject
    >(
        _ mock: CardGetBorderUseCaseableGeneratedMock,
        expectedNumberOfCalls: Int,
        givenTheme: _Theme? = nil, 
        expectedReturnValue: String,
        sourceLocation: Testing.SourceLocation = #_sourceLocation
    ) {
        // Count
        #expect(
            mock.executeWithThemeCallsCount == expectedNumberOfCalls,
            "Wrong execute(theme: any Theme) number of called on CardGetBorderUseCaseable. Expected \(expectedNumberOfCalls), got \(mock.executeWithThemeCallsCount)",
            sourceLocation: sourceLocation
        )

        // Parameters
        if expectedNumberOfCalls > 0 {
            // Theme
            if let givenTheme {

                guard let receivedValue = mock.executeWithThemeReceivedTheme as? _Theme else {
                    Issue.record("Wrong execute(theme: any Theme) theme parameter type on CardGetBorderUseCaseable", sourceLocation: sourceLocation)
                    return
                }
                #expect(
                    receivedValue === givenTheme,
                    "Wrong execute(theme: any Theme) theme parameter on CardGetBorderUseCaseable",
                    sourceLocation: sourceLocation
                )
            } else {
                #expect(
                    mock.executeWithThemeReceivedTheme == nil,
                    "Wrong execute(theme: any Theme) theme parameter value on CardGetBorderUseCaseable. Should be nil but got \(String(describing: mock.executeWithThemeReceivedTheme))",
                    sourceLocation: sourceLocation
                )
            }

        }

        // Return
        #expect(
            mock.executeWithThemeReturnValue == expectedReturnValue,
            "Wrong execute(theme: any Theme) return value on CardGetBorderUseCaseable. Expected \(String(describing: expectedReturnValue)), got \(String(describing: mock.executeWithThemeReturnValue))",
            sourceLocation: sourceLocation
        )
    }

}



@testable import UserManagementComponent





@_spi(SI_SPI) public final class CardGetBorderUseCaseableGeneratedMock: UserManagementComponent.CardGetBorderUseCaseable, ResetGeneratedMock {


    // MARK: - Initialization

    public init() {}

    // MARK: - execute

    public var executeWithThemeCallsCount = 0
    public var executeWithThemeCalled: Bool {
        return executeWithThemeCallsCount > 0
    }
    public var executeWithThemeReceivedTheme: (any Theme)?
    public var executeWithThemeReceivedInvocations: [any Theme] = []
    public var executeWithThemeReturnValue: String = ""
    public var _executeWithTheme: ((any Theme) -> String)?
    public func execute(theme: any Theme) -> String {
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






