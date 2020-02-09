//
//  ListPresenter.swift
//  computer-list
//
//  Created by Савелий Вепрев on 02.02.2020.
//  Copyright © 2020 Савелий Вепрев. All rights reserved.
//

import Foundation

protocol ListViewProtocol: class {
    func success()
    func failure(error: Error)
}

protocol ListViewPresenterProtocol: class {
    init(view: ListViewProtocol, router: RouterProtocol, network: NetworkServiceProtocol)
    var list: List? { get set }
    func getList()
    func tapOnTheItem(id: Int)
}

class ListPresenter: ListViewPresenterProtocol {
    
    weak var view: ListViewProtocol?
    var router: RouterProtocol?
    var network: NetworkServiceProtocol!
    var list: List?
    var changeItems: [List.Item] = []
    var page = 0
    required init(view: ListViewProtocol, router: RouterProtocol, network: NetworkServiceProtocol) {
        self.view = view
        self.router = router
        self.network = network
        getList()
    }
    func tapOnTheItem(id: Int) {
        router?.showDetail(id: id)
    }
    func getList() {
        let params = "?p=\(page)"
        network.fetch(fromParameters: params, fromRoute: Routes.list) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.list = model
                    model.items?.forEach {
                        self.changeItems.append($0)
                    }
                    
                    self.list?.items = self.changeItems
                    self.view?.success()
                    self.page+=1
                case .failure(let error):
                     self.view?.failure(error: error)
                }
            }
        }
    }
}
