//
//  DetailPresenter.swift
//  computer-list
//
//  Created by Савелий Вепрев on 03.02.2020.
//  Copyright © 2020 Савелий Вепрев. All rights reserved.
//

import Foundation

protocol DetailViewProtocol: class {
    func success()
    func failure(error: Error)
}

protocol DetailViewPresenterProtocol: class {
    init(view: DetailViewProtocol, router: RouterProtocol, network: NetworkServiceProtocol, id: Int, persistanceManager: PersistanceManagerProtocol)
    var detail: Detail? { get set }
    var id: Int? { get set }
    var same: [Same]? {get set }
    func getDetail(completion: @escaping () -> Void)
    func getSame()
    func tapOnTheItem(id: Int)
    var persistanceManager: PersistanceManagerProtocol? { get set }
    func createItem()
    func updateItem(item: Item)
    func checkItem()
}

class DetailPresenter: DetailViewPresenterProtocol {

    weak var view: DetailViewProtocol?
    var detail: Detail?
    var router: RouterProtocol?
    var network: NetworkServiceProtocol!
    var persistanceManager: PersistanceManagerProtocol?
    var id: Int?
    var same: [Same]?
    
    required init(view: DetailViewProtocol, router: RouterProtocol, network: NetworkServiceProtocol, id: Int, persistanceManager: PersistanceManagerProtocol) {
        self.view = view
        self.router = router
        self.network = network
        self.id = id
        self.persistanceManager = persistanceManager
        checkItem()
    }
    func tapOnTheItem(id: Int) {
        router?.showDetail(id: id)
    }
    func createItem() {
        guard let context = persistanceManager?.context else { return }
        let company = Company(context: context)

        company.name = self.detail?.company?.name ?? ""
        company.id = self.detail?.company?.id ?? 0
        
        let item = Item(context: context)
        item.name = self.detail?.name
        item.id = self.detail?.id ?? 0
        item.descript = self.detail?.description
        item.urlImage = self.detail?.imageUrl
        item.company = company
        item.updatedAt = Date()
        
        persistanceManager?.save()
    }
    func updateItem(item: Item) {
        item.name = self.detail?.name
        item.id = self.detail?.id ?? 0
        item.descript = self.detail?.description
        item.urlImage = self.detail?.imageUrl
        item.company?.name = self.detail?.company?.name
        item.company?.id = self.detail?.company?.id ?? 0
        item.updatedAt = Date()
        persistanceManager?.save()
    }
    func checkItem() {
        guard let items = persistanceManager?.fetchBy(Item.self, attribute: "id", params: id ?? 0)  else { return }
        if items.isEmpty {
            getDetail(completion: {
                self.createItem()
            })
        }
        else if (Date().currentTimeSeconds() - (items.first?.updatedAt?.currentTimeSeconds())!) > 60 {
            getDetail(completion: {
                self.updateItem(item: items.first!)
            })
        }
        else {
            DispatchQueue.main.async {
                guard let item = items.first else { return }
                let detail = Detail(id: item.id, name: item.name, imageUrl: item.urlImage, company: Detail.Company(id: item.company?.id, name: item.company?.name), description: item.descript)
                self.detail = detail
                self.view?.success()
            }
        }
    }
    func getSame() {
        let params = "/\(id!)/similar"
        network.fetch(fromParameters: params, fromRoute: Routes.same) { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.same = model
                    self.view?.success()
                case .failure(let error):
                     self.view?.failure(error: error)
                }
            }
        }
    }
    
    func getDetail(completion: @escaping () -> Void) {
        let params = "/\(id!)"
        network.fetch(fromParameters: params, fromRoute: Routes.detail) { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.detail = model
                    self.view?.success()
                    completion()
                case .failure(let error):
                     self.view?.failure(error: error)
                }
            }
        }
    }
}
