//
//  ViewController.swift
//  MVPPatternTest
//
//  Created by Denis Velikanov on 25.05.2021.
//

import UIKit

class UserViewController: UIViewController, FactPresenterDelegate {



    let stackView = UIStackView()
    let dateLabel = UILabel()
    let explanationLabel = UILabel()
    let titleLabel = UILabel()
    let mediaButton = GradientButton(colors: [UIColor.systemPurple.cgColor, UIColor.magenta.cgColor])
    
    
    private let presenter = FactPresenter()
    private var currentFact: DayFact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setup()
        constraint()
        setupPresenter()
    }
    
    func setup() {
        title = "Dayly Fact"
        view.addSubview(stackView)
        [titleLabel, dateLabel, explanationLabel, mediaButton].forEach { stackView.addArrangedSubview($0) }
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = 5
        [dateLabel, explanationLabel, titleLabel].forEach { $0.text = "kyky blyat" }
        [dateLabel, explanationLabel, titleLabel].forEach { $0.textAlignment = .center }
        [dateLabel, explanationLabel, titleLabel].forEach { $0.textColor = UIColor.white }
        [dateLabel, explanationLabel, titleLabel].forEach { $0.numberOfLines = 0 }
        [dateLabel, explanationLabel, titleLabel].forEach { $0.adjustsFontSizeToFitWidth = true }

        dateLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 21)
        explanationLabel.font = UIFont.systemFont(ofSize: 19)
        
        mediaButton.setTitle("View Media", for: .normal)
        mediaButton.addTarget(self, action: #selector(showMedia), for: .touchUpInside)
        
    }
    
    func constraint() {
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
    
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
        
        if currentFact.media_type == "photo" {
        
        let vc = PhotoViewController()
        vc.fact = currentFact
        navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = VideoViewController()
            vc.fact = currentFact
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    
    @objc func showMedia() {
        guard let currentFact = currentFact else { return }
        presenter.showMediaTap(fact: currentFact)
    }
    
}

