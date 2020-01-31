//
//  ViewController.swift
//  computer-list
//
//  Created by Савелий Вепрев on 01.02.2020.
//  Copyright © 2020 Савелий Вепрев. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Computers"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .red
    }


}

