//
//  ViewController.swift
//  MVPPatternTest
//
//  Created by Denis Velikanov on 25.05.2021.
//

import UIKit

class UserViewController: UIViewController, FactPresenterDelegate {

    let dateLabel = UILabel()
    let explanationLabel = UILabel()
    let titleLabel = UILabel()
    let mediaButton = GradientButton(colors: [UIColor.systemPurple.cgColor, UIColor.black.cgColor])
    
    let myView = GradientView(colors: [UIColor.systemRed.cgColor, UIColor.magenta.cgColor])
    
    private let presenter = FactPresenter()
    private var currentFact: DayFact?
    
    let stackView = UIStackView()
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        constraint()
        setupPresenter()
    }
    
    func setup() {
        title = "Nasa Dayly Fact"
        
        view.addSubview(scrollView)
        scrollView.addSubview(myView)
        [titleLabel, explanationLabel, mediaButton].forEach { scrollView.addSubview($0) }
      
        [dateLabel, explanationLabel, titleLabel].forEach { $0.text = "kyky blyat" }
        [dateLabel, explanationLabel, titleLabel].forEach { $0.textAlignment = .center }
        [dateLabel, titleLabel].forEach { $0.textColor = UIColor.white }
        [dateLabel, explanationLabel, titleLabel].forEach { $0.numberOfLines = 0 }
        [dateLabel, explanationLabel, titleLabel].forEach { $0.adjustsFontSizeToFitWidth = true }
        
        dateLabel.font = UIFont.italicSystemFont(ofSize: 13)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 21)
        explanationLabel.font = UIFont.init(name: "Palatino-Roman", size: 19)
        explanationLabel.textColor = .black
        
        mediaButton.setTitle("View Media", for: .normal)
        mediaButton.addTarget(self, action: #selector(showMedia), for: .touchUpInside)
        
        scrollView.frame = view.frame
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height * 2)
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.showsHorizontalScrollIndicator = true
      //  scrollView.bounces = true
    }
    
    func constraint() {

        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        
        myView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        myView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        
        
//        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        myView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor)
        titleLabel.anchor(top: myView.topAnchor, leading: myView.leadingAnchor, bottom: explanationLabel.topAnchor, trailing: myView.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
//        dateLabel.anchor(top: titleLabel.bottomAnchor, leading: myView.leadingAnchor, bottom: explanationLabel.topAnchor, trailing: myView.trailingAnchor)
        explanationLabel.anchor(top: titleLabel.bottomAnchor, leading: myView.leadingAnchor, bottom: mediaButton.topAnchor, trailing: myView.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        mediaButton.anchor(top: explanationLabel.bottomAnchor, leading: myView.leadingAnchor, bottom: myView.bottomAnchor, trailing: myView.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
        titleLabel.heightAnchor.constraint(equalToConstant: view.frame.height / 10).isActive = true
        mediaButton.heightAnchor.constraint(equalToConstant: view.frame.height / 10).isActive = true
    }
    
    func setupPresenter() {
        presenter.setViewDelegate(delegate: self)
        presenter.getFact()
    }
    
    func presentFact(fact: DayFact) {
        self.currentFact = fact
        DispatchQueue.main.async {
            self.dateLabel.text = fact.date
            self.explanationLabel.text = fact.explanation
            self.titleLabel.text = fact.title
        }
    }
    
    func presentMedia(title: String, mediaURL: String) {
        
        guard let currentFact = currentFact else { return }
        
        if currentFact.media_type == "video" {
            let vc = VideoViewController()
            vc.fact = currentFact
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = PhotoViewController()
            vc.fact = currentFact
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    
    
    @objc func showMedia() {
        guard let currentFact = currentFact else { return }
        presenter.showMediaTap(fact: currentFact)
    }
    
}

