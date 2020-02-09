//
//  RouterTest.swift
//  computer-listTests
//
//  Created by Савелий Вепрев on 09.02.2020.
//  Copyright © 2020 Савелий Вепрев. All rights reserved.
//

import XCTest
@testable import computer_list

class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.presentedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
}


class RouterTest: XCTestCase {
    
    var router: RouterProtocol!
    var navigationController = MockNavigationController()
    let builder = Builder()
    
    override func setUp() {
       
        router = Router(navigationController: navigationController, builder: builder)
    }

    override func tearDown() {
        router = nil
    }
    func testRouter() {
        router.showDetail(id: 0)
        let detailViewController = navigationController.presentedVC
        XCTAssertTrue(detailViewController is DetailViewController)
    }

}
