//
//  FusionAllianceTests.swift
//  FusionAllianceTests
//
//  Created by Consultant on 8/11/22.
//

import XCTest
import Combine
@testable import FusionAlliance

class FusionAllianceTests: XCTestCase {

  private var subscribers = Set<AnyCancellable>()
    
    func testData() throws{
        
        let testNetwork = MockNetwork()
        let data = try dataFromFile(jsonFile: "mockData")
        testNetwork.data = data
        
        let viewModel = PostVM(service: testNetwork)
        let expectation = expectation(description: "success expectation")
        var lists: [listSports] = []
        
        viewModel.getPost()
        viewModel.$lists
            .sink{ response in
                 lists = response
                expectation.fulfill()
                
            }
            .store(in: &subscribers)
        
        waitForExpectations(timeout: 2.0)
        XCTAssertEqual(lists.count, 58)
    }

}

private func dataFromFile(jsonFile:String) throws -> Data {
    let bundle = Bundle(for: FusionAllianceTests.self)
    guard let url = bundle.url(forResource: jsonFile, withExtension: "json") else{
        fatalError("url \(jsonFile) could not be loaded")
    }
    return try Data(contentsOf: url)
}
