//
//  Router.swift
//  computer-list
//
//  Created by Савелий Вепрев on 02.02.2020.
//  Copyright © 2020 Савелий Вепрев. All rights reserved.
//

import UIKit

protocol MainRouterProtocol {
    var navigationController: UINavigationController? { get set }
    var builder: BuilderProtocol? { get set }
}
protocol RouterProtocol: MainRouterProtocol {
    func initialViewController()
    func showDetail(id: Int)
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    
    var builder: BuilderProtocol?
    
    init(navigationController: UINavigationController, builder: BuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let viewController = builder?.createListModule(router: self) else { return }
            navigationController.viewControllers = [viewController]
        }
    }
    func showDetail(id: Int) {
        if let navigationController = navigationController  {
            guard let viewController = builder?.createDetailModule(router: self, id: id) else { return }
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}
