//
//  ViewController.swift
//  computer-list
//
//  Created by Савелий Вепрев on 01.02.2020.
//  Copyright © 2020 Савелий Вепрев. All rights reserved.
//
import UIKit


class ListViewController: UIViewController {

    var tableView: UITableView =  {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9647058824, alpha: 1)
        tableView.isScrollEnabled = false
        tableView.layer.cornerRadius = 12
        return tableView
    }()
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    let viewTop: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0, green: 0.737254902, blue: 0.4078431373, alpha: 1)
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMaxYCorner]
        return view
    }()
    let bottomTop: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9647058824, alpha: 1)
        return view
    }()

    weak var bottomConstraint: NSLayoutConstraint!
    weak var heightConstraint: NSLayoutConstraint!

    var presenter: ListViewPresenterProtocol!

    var fetchMore = false

    var longTitleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.white
        label.sizeToFit()
        return label
    }()

    var indicatorAlert = IndicatorAlert()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Computers"
        let nav = self.navigationController?.navigationBar
//        nav?.barTintColor = #colorLiteral(red: 0, green: 0.737254902, blue: 0.4078431373, alpha: 1)
//        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        nav?.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        nav?.setupLarge()
        view.backgroundColor = #colorLiteral(red: 0, green: 0.737254902, blue: 0.4078431373, alpha: 1)
        tableView.register(ListCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        scrollView.delegate = self
        let rightItem = UIBarButtonItem(customView: longTitleLabel)
        self.navigationItem.rightBarButtonItem = rightItem
        setupViews()
        createCancelButton(str: "")
    }
    override func viewDidAppear(_ animated: Bool) {
       
    }
    func createCancelButton(str: String) {
        longTitleLabel.text = str
        longTitleLabel.sizeToFit()
    }
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(bottomTop)
        scrollView.addSubview(viewTop)
        scrollView.addSubview(tableView)

        bottomConstraint = scrollView.bottomAnchor.constraint(equalTo:tableView.bottomAnchor)
        bottomConstraint.priority = UILayoutPriority(rawValue: 250)

        heightConstraint = tableView.heightAnchor.constraint(equalTo: view.heightAnchor)
        heightConstraint.constant = 0
        heightConstraint.priority = UILayoutPriority(rawValue: 999)

        NSLayoutConstraint.activate([
          scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
           scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
           scrollView.topAnchor.constraint(equalTo: view.topAnchor),
           scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

           viewTop.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 2),
           viewTop.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -2),
           viewTop.topAnchor.constraint(equalTo: scrollView.topAnchor),
           viewTop.heightAnchor.constraint(equalToConstant: 70),

           bottomTop.topAnchor.constraint(equalTo: tableView.topAnchor),
           bottomTop.leadingAnchor.constraint(equalTo: view.leadingAnchor),
           bottomTop.trailingAnchor.constraint(equalTo: view.trailingAnchor),
           bottomTop.bottomAnchor.constraint(equalTo: view.bottomAnchor),

           tableView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 18),
           tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
           tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,  constant: -16),
           heightConstraint,
           bottomConstraint,
        ])
        view.layoutIfNeeded()
     }
 }

extension ListViewController: ListViewProtocol{
    func failure(error: Error) {

    }
    func success() {
        indicatorAlert.hideActivityIndicator(uiView: view)
        guard let count = presenter.list?.items?.count else { return }
        guard let total = presenter.list?.total else { return }
        createCancelButton(str: "\(count) of \(total)")
        fetchMore = false
        tableView.reloadData()
    }
}

extension ListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.list?.items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
       let headerView = UIView()
       headerView.backgroundColor = UIColor.clear
       return headerView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListCell
        heightConstraint.constant = CGFloat(112*(presenter.list?.items?.count ?? 0)!) - view.frame.height
        let list = presenter.list
        cell.nameItemText = list?.items?[indexPath.section].name
        cell.nameCompanyText = list?.items?[indexPath.section].company?.name
        return cell
    }
}
extension ListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height && !fetchMore{
            if presenter.list?.offset != presenter.list?.total {
                presenter.getList()
                indicatorAlert.showActivityIndicator(uiView: view)
                fetchMore = true
            }
        }
    }
}
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section)
        guard let id = presenter.list?.items?[indexPath.section].id else { return }
        presenter.tapOnTheItem(id: id)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(94)
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 18
    }
}

extension UINavigationBar {

    func setupLarge() {
        // ... Set up here your tintColor, isTranslucent and other properties if you need

        if #available(iOS 11.0, *) {
            prefersLargeTitles = true
            //largeTitleTextAttributes = ...Set your attributes
        }

        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = #colorLiteral(red: 0, green: 0.737254902, blue: 0.4078431373, alpha: 1)
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.shadowColor = .clear
            standardAppearance = appearance
            compactAppearance = appearance
            scrollEdgeAppearance = appearance
        }
    }
}
