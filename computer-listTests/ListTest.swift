//
//  ListTest.swift
//  computer-listTests
//
//  Created by Савелий Вепрев on 09.02.2020.
//  Copyright © 2020 Савелий Вепрев. All rights reserved.
//

import XCTest
@testable import computer_list

class MockView: ListViewProtocol {
    func success() {
        
    }
    
    func failure(error: Error) {
        
    }
}
class MockNetworkService: NetworkServiceProtocol {
    
    var list: List!
    
    init() {}
    convenience init(list: List?) {
        self.init()
        self.list = list
    }
    func fetch<Model>(fromParameters param: String, fromRoute route: Route<Model>, completion: @escaping (Result<Model>) -> Void) where Model : Decodable, Model : Encodable {
           if let list = list {
               completion(.success(list as! Model))
           }
           else {
               let error = NSError(domain: "", code: 0, userInfo: nil)
               completion(.failure(error))
           }
    }
}

class ListTest: XCTestCase {
    
    var view: MockView!
    var presenter: ListPresenter!
    var network: NetworkServiceProtocol!
    var router: RouterProtocol!
    var list = List()

    override func setUp() {
        let nav = UINavigationController()
        let builder = Builder()
        router = Router(navigationController: nav, builder: builder)
    }
    func testGetSuccessList() {
        let list = List(items: [List.Item(id: 1, name: "Foo", company: List.Item.Company(id: 1, name: "Bar"))], page: 1, offset: 0, total: 20)
        self.list = list
        view = MockView()
        network = MockNetworkService(list: list)
        presenter = ListPresenter(view: view, router: router, network: network)
        
        var catchList: List?
        
        
        network.fetch(fromParameters: "", fromRoute: Routes.list, completion: { result in
            switch result {
            case .success(let list):
                catchList = list
            case .failure(let error):
                print(error)
            }
        })
        
        XCTAssertEqual(catchList?.items?.count, 1)
    }
    func testGetFailureList() {
        let list = List(items: [List.Item(id: 1, name: "Foo", company: List.Item.Company(id: 1, name: "Bar"))], page: 1, offset: 0, total: 20)
        self.list = list
        view = MockView()
        network = MockNetworkService()
        presenter = ListPresenter(view: view, router: router, network: network)
        
        var catchError: Error?
        
        
        network.fetch(fromParameters: "", fromRoute: Routes.list, completion: { result in
            switch result {
            case .success(let list):
                break
            case .failure(let error):
                catchError = error
            }
        })
        XCTAssertNotNil(catchError)
    }

    override func tearDown() {
       view = nil
       network = nil
       presenter = nil
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
