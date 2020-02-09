//
//  DetailViewController.swift
//  computer-list
//
//  Created by Савелий Вепрев on 03.02.2020.
//  Copyright © 2020 Савелий Вепрев. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = #colorLiteral(red: 0, green: 0.737254902, blue: 0.4078431373, alpha: 1)
        return scrollView
    }()
    let viewTop: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0, green: 0.737254902, blue: 0.4078431373, alpha: 1)
        return view
    }()
    let bottomTop: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMinYCorner]
        return view
    }()
    let centerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = #colorLiteral(red: 0.958066658, green: 0.958066658, blue: 0.958066658, alpha: 1)
        return imageView
    }()
    private let titleLabel: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.font = UIFont.systemFont(ofSize: 14)
        label.text = ""
       label.textColor = #colorLiteral(red: 0, green: 0.737254902, blue: 0.4078431373, alpha: 1)
       return label
    }()
    private let titleLabel2: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.font = UIFont.systemFont(ofSize: 24)
       label.text = ""
       label.textColor = #colorLiteral(red: 0.368627451, green: 0.3725490196, blue: 0.3803921569, alpha: 1)
       return label
    }()
    private let descriptionLabel: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.font = UIFont.systemFont(ofSize: 24)
       label.text = ""
       label.textColor = #colorLiteral(red: 0.368627451, green: 0.3725490196, blue: 0.3803921569, alpha: 1)
       label.numberOfLines = 2
       label.lineBreakMode = .byTruncatingTail
       return label
    }()
    private let moreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "arrowbt"), for: .normal)
        button.addTarget(self, action: #selector(moreAction), for: .touchUpInside)
        return button
    }()
    var tableView: UITableView =  {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9647058824, alpha: 1)
        tableView.isScrollEnabled = false
        tableView.layer.cornerRadius = 12
        tableView.isHidden = true
        return tableView
    }()

    weak var heightDesConstraint: NSLayoutConstraint!
    
    var presenter: DetailViewPresenterProtocol!
    var indicatorAlert = IndicatorAlert()
    
    var more = true
    
    var buttunItem: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "arrowbt"), for: .normal)
        button.addTarget(self, action: #selector(actionBt), for: .touchUpInside)
        return button
    }()
    
    weak var bottomConstraint: NSLayoutConstraint!
    weak var heightConstraint: NSLayoutConstraint!
    
    var isSame = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nav = self.navigationController?.navigationBar
        nav?.barTintColor = #colorLiteral(red: 0, green: 0.737254902, blue: 0.4078431373, alpha: 1)
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        nav?.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        nav?.tintColor = UIColor.white
        setupViews()
        scrollView.delegate = self
        indicatorAlert.showActivityIndicator(uiView: view)
        pulseSetup()
    }
    func pulseSetup() {
        let pulseAnimation = CABasicAnimation(keyPath: "opacity")
        pulseAnimation.duration = 0.7
        pulseAnimation.fromValue = 0
        pulseAnimation.toValue = 1
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .greatestFiniteMagnitude
        self.centerImageView.layer.add(pulseAnimation, forKey: nil)
    }
    func nukeAllAnimations() {
        self.centerImageView.backgroundColor = .clear
        self.centerImageView.subviews.forEach({$0.layer.removeAllAnimations()})
        self.centerImageView.layer.removeAllAnimations()
        self.centerImageView.layoutIfNeeded()
    }
    func rotate(type: CGAffineTransform) {
        UIView.animate(withDuration: 0.5) {
            self.moreButton.transform = type
        }
    }
    @objc func moreAction() {
        if more {
            self.rotate(type: CGAffineTransform(rotationAngle: .pi))
            self.descriptionLabel.numberOfLines = 0
            self.descriptionLabel.lineBreakMode = .byWordWrapping
            more = false
        }
        else {
            self.rotate(type: CGAffineTransform.identity)
            self.descriptionLabel.numberOfLines = 2
            self.descriptionLabel.lineBreakMode = .byTruncatingTail
            more = true
        }
    }
    @objc func actionBt() {
    
    }
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(bottomTop)
        scrollView.addSubview(centerImageView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(titleLabel2)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(moreButton)
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

          bottomTop.topAnchor.constraint(equalTo: scrollView.topAnchor),
          bottomTop.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          bottomTop.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          bottomTop.bottomAnchor.constraint(equalTo: view.bottomAnchor),

          centerImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
          centerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
          centerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
          centerImageView.heightAnchor.constraint(equalToConstant: view.frame.height/2),

          titleLabel.topAnchor.constraint(equalTo: centerImageView.bottomAnchor, constant: 4),
          titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

          titleLabel2.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
          titleLabel2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
          
          descriptionLabel.topAnchor.constraint(equalTo: titleLabel2.bottomAnchor, constant: 4),
          descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
          descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        
          moreButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
          moreButton.heightAnchor.constraint(equalToConstant: 15),
          moreButton.widthAnchor.constraint(equalToConstant: 30),
          moreButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
          
          tableView.topAnchor.constraint(equalTo: moreButton.bottomAnchor, constant: 4),
          tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
          tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,  constant: -16),
        
          heightConstraint,
          bottomConstraint,
       ])
       view.layoutIfNeeded()
    }
    
    func reloadDataField() {
        self.navigationItem.title = presenter.detail?.name ?? ""
        imageLoad(url: presenter.detail?.imageUrl ?? "")
        titleLabel.text = presenter.detail?.company?.name ?? ""
        titleLabel2.text = presenter.detail?.name ?? ""
        descriptionLabel.text = presenter.detail?.description ?? ""
    }
    func imageLoad(url: String) {
        guard let url = URL(string: url) else {
            self.centerImageView.image = UIImage(named: "default")
            self.nukeAllAnimations()
            return
        }
        DispatchQueue.global().async {
            
            guard let data = try? Data(contentsOf: url) else {
                DispatchQueue.main.async {
                    self.centerImageView.image = UIImage(named: "default")
                    self.nukeAllAnimations()
                }
                return
            }
            DispatchQueue.main.async {
                self.centerImageView.image = UIImage(data: data)
                self.nukeAllAnimations()
            }
        }
    }
    

}
extension DetailViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        if translation.y > 0 {
            
        } else if isSame {
           presenter.getSame()
           isSame = false
           tableView.register(SameCell.self, forCellReuseIdentifier: "cell")
           tableView.dataSource = self
           tableView.delegate = self
           tableView.isHidden = false
        }
    }
}
extension DetailViewController: DetailViewProtocol {
    func success() {
        reloadDataField()
        indicatorAlert.hideActivityIndicator(uiView: view)
        tableView.reloadData()
    }
    func failure(error: Error) {
        
    }
}
extension DetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.same?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SameCell
        heightConstraint.constant = CGFloat(cell.frame.height*(5)) - view.frame.height
        cell.linkItemText = presenter.same?[indexPath.row].name ?? ""
        return cell
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.tapOnTheItem(id: presenter.same?[indexPath.row].id ?? 0)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(40)
    }
}
