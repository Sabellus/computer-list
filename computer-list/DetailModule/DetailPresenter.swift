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
    init(view: DetailViewProtocol, router: RouterProtocol, network: NetworkServiceProtocol, id: Int)
    var detail: Detail? { get set }
    var id: Int? { get set }
    var same: [Same]? {get set }
    func getDetail()
    func getSame()
    func tapOnTheItem(id: Int)
}



class DetailPresenter: DetailViewPresenterProtocol {

    weak var view: DetailViewProtocol?
    var detail: Detail?
    var router: RouterProtocol?
    var network: NetworkServiceProtocol!
    var id: Int?
    var same: [Same]?
    
    required init(view: DetailViewProtocol, router: RouterProtocol, network: NetworkServiceProtocol, id: Int) {
        self.view = view
        self.router = router
        self.network = network
        self.id = id
        
        getDetail()
    }
    func tapOnTheItem(id: Int) {
        router?.showDetail(id: id)
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
    
    func getDetail() {
        let params = "/\(id!)"
        network.fetch(fromParameters: params, fromRoute: Routes.detail) { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.detail = model
                    self.view?.success()
                case .failure(let error):
                     self.view?.failure(error: error)
                }
            }
        }
    }
    
}
