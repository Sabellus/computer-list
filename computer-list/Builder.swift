//
//  Builder.swift
//  computer-list
//
//  Created by Савелий Вепрев on 02.02.2020.
//  Copyright © 2020 Савелий Вепрев. All rights reserved.
//

import UIKit

protocol BuilderProtocol {
    func createListModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(router: RouterProtocol, id: Int) -> UIViewController
}

class Builder: BuilderProtocol {
    func createDetailModule(router: RouterProtocol, id: Int) -> UIViewController {
        let view = DetailViewController()
        let network = NetworkService()
        let persistanceManager = PersistanceManager()
        let presenter = DetailPresenter(view: view, router: router, network: network, id: id, persistanceManager: persistanceManager)
        view.presenter = presenter
        return view
    }
    func createListModule(router: RouterProtocol) -> UIViewController {
        let view = ListViewController()
        let network = NetworkService()
        let presenter = ListPresenter(view: view, router: router, network: network)
        view.presenter = presenter
        return view
    }
}
