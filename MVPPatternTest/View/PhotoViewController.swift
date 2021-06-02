//
//  PhotoViewController.swift
//  MVPPatternTest
//
//  Created by Denis Velikanov on 25.05.2021.
//

import UIKit

class PhotoViewController: UIViewController {

    var fact: DayFact?
    
    let titleLabel = UILabel()
    let image = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        constraint()
        setImage()
        setLabel()
    }
    
    func setup() {
        [titleLabel, image].forEach { view.addSubview($0) }
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .red
        titleLabel.textAlignment = .center
        
        image.contentMode = .scaleAspectFit
    }
    
    func constraint() {
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: image.topAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        image.anchor(top: titleLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }
    
    func setImage() {
        guard let fact = fact else { return }
        let data = try? Data(contentsOf: URL(string: fact.url)!)
        DispatchQueue.main.async {
            guard let data = data else { return }
            self.image.image = UIImage(data: data)
        }
    }
    
    func setLabel() {
        titleLabel.text = fact?.title
    }



}
