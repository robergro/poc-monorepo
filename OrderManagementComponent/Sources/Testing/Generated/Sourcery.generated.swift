// Generated using Sourcery 2.2.3 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable all

import Foundation
import UIKit
import SwiftUI
import XCTest
import Testing

import Combine



@_spi(SI_SPI) public final class OMGetBorderUseCaseableMockTest {

    // MARK: - Initialization

    private init(){
    }

    // MARK: - XCTest


    public static func XCTCallsCount(
        _ mock: OMGetBorderUseCaseableGeneratedMock,
        executeWithThemeNumberOfCalls numberOfCalls: Int
    ) {
        XCTAssertEqual(
            mock.executeWithThemeCallsCount,
            numberOfCalls,
            "Wrong execute(theme: Bool) number of called on OMGetBorderUseCaseable"
        )
    }

    public static func XCTCalled(
        _ mock: OMGetBorderUseCaseableGeneratedMock,
        executeWithThemeCalled isCalled: Bool
    ) {
        XCTAssertEqual(
            mock.executeWithThemeCalled,
            isCalled,
            "Wrong execute(theme: Bool) isCalled on OMGetBorderUseCaseable"
        )
    }

    public static func XCTAssert(
        _ mock: OMGetBorderUseCaseableGeneratedMock,
        expectedNumberOfCalls: Int,
        givenTheme: Bool? = nil, 
        expectedReturnValue: String
    ) {
        // Count
        XCTAssertEqual(
            mock.executeWithThemeCallsCount,
            expectedNumberOfCalls,
            "Wrong execute(theme: Bool) number of called on OMGetBorderUseCaseable"
        )

        // Parameters
        if expectedNumberOfCalls > 0 {
            // Theme
            if let givenTheme {
                XCTAssertEqual(
                    mock.executeWithThemeReceivedTheme,
                    givenTheme,
                    "Wrong execute(theme: Bool) theme parameter on OMGetBorderUseCaseable"
                )
            } else {
                XCTAssertNil(
                    mock.executeWithThemeReceivedTheme,
                    "Wrong execute(theme: Bool) theme parameter value on OMGetBorderUseCaseable. Should be nil"
                )
            }

        }

        // Return
            XCTAssertEqual(
                mock.executeWithThemeReturnValue,
                expectedReturnValue,
                "Wrong execute(theme: Bool) return value on OMGetBorderUseCaseable"
            )
    }


    // MARK: - Swift Testing


    public static func expectCallsCount(
        _ mock: OMGetBorderUseCaseableGeneratedMock,
        executeWithThemeNumberOfCalls numberOfCalls: Int,
        sourceLocation: Testing.SourceLocation = #_sourceLocation
    ) {
        #expect(
            mock.executeWithThemeCallsCount == numberOfCalls,
            "Wrong execute(theme: Bool) number of called on OMGetBorderUseCaseable. Expected \(numberOfCalls), got \(mock.executeWithThemeCallsCount)",
            sourceLocation: sourceLocation
        )
    }

    public static func expectCalled(
        _ mock: OMGetBorderUseCaseableGeneratedMock,
        executeWithThemeCalled isCalled: Bool,
        sourceLocation: Testing.SourceLocation = #_sourceLocation
    ) {
        #expect(
            mock.executeWithThemeCalled == isCalled,
            "Wrong execute(theme: Bool) isCalled on OMGetBorderUseCaseable. Expected \(isCalled), got \(mock.executeWithThemeCalled)",
            sourceLocation: sourceLocation
        )
    }

    public static func expect(
        _ mock: OMGetBorderUseCaseableGeneratedMock,
        expectedNumberOfCalls: Int,
        givenTheme: Bool? = nil, 
        expectedReturnValue: String,
        sourceLocation: Testing.SourceLocation = #_sourceLocation
    ) {
        // Count
        #expect(
            mock.executeWithThemeCallsCount == expectedNumberOfCalls,
            "Wrong execute(theme: Bool) number of called on OMGetBorderUseCaseable. Expected \(expectedNumberOfCalls), got \(mock.executeWithThemeCallsCount)",
            sourceLocation: sourceLocation
        )

        // Parameters
        if expectedNumberOfCalls > 0 {
            // Theme
            if let givenTheme {

                #expect(
                    mock.executeWithThemeReceivedTheme == givenTheme,
                    "Wrong execute(theme: Bool) theme parameter on OMGetBorderUseCaseable. Expected \(String(describing: givenTheme)), got \(String(describing: mock.executeWithThemeReceivedTheme))",
                    sourceLocation: sourceLocation
                )
            } else {
                #expect(
                    mock.executeWithThemeReceivedTheme == nil,
                    "Wrong execute(theme: Bool) theme parameter value on OMGetBorderUseCaseable. Should be nil but got \(String(describing: mock.executeWithThemeReceivedTheme))",
                    sourceLocation: sourceLocation
                )
            }

        }

        // Return
        #expect(
            mock.executeWithThemeReturnValue == expectedReturnValue,
            "Wrong execute(theme: Bool) return value on OMGetBorderUseCaseable. Expected \(String(describing: expectedReturnValue)), got \(String(describing: mock.executeWithThemeReturnValue))",
            sourceLocation: sourceLocation
        )
    }

}



@testable import OrderManagementComponent





@_spi(SI_SPI) public final class OMGetBorderUseCaseableGeneratedMock: OrderManagementComponent.OMGetBorderUseCaseable, ResetGeneratedMock {


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






