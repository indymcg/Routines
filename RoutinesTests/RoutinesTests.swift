//
//  RoutinesTests.swift
//  RoutinesTests
//
//  Created by Indy McGinnis on 10/25/22.
//

import XCTest
@testable import Routines
import SwiftUI

final class RoutinesTests: XCTestCase {
    
    var routine: Routine!
    @Environment(\.managedObjectContext) var moc
    
    override func setUpWithError() throws {
        routine = Routine.init(context: moc)
    }

    override func tearDownWithError() throws {
        routine = nil
    }

    func testResetFunc() throws {

    }

}
