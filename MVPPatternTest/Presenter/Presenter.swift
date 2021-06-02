//
//  Presenter.swift
//  MVPPatternTest
//
//  Created by Denis Velikanov on 25.05.2021.
//

import Foundation
import UIKit


protocol FactPresenterDelegate: AnyObject {
    func presentFact(fact: DayFact)
    func presentMedia(title: String, mediaURL: String)
    func showMedia()
}

typealias PresenterDelegate = FactPresenterDelegate & UIViewController


class FactPresenter {
    
    let requestUrl = "https://api.nasa.gov/planetary/apod?api_key=Iev45RfuUJZgaHAWlQ2qulPwSWDjS3DdkBjqXVD1"
    
    weak var delegate: PresenterDelegate?
    
    func getFact() {
        guard let url = URL(string: requestUrl) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            guard let data = data, error == nil else { return }
            do {
                let fact = try JSONDecoder().decode(DayFact.self, from: data)
                self?.delegate?.presentFact(fact: fact)
                print(fact.url)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    public func showMediaTap(fact: DayFact) {
        delegate?.presentMedia(title: fact.title, mediaURL: fact.url)
    }
}
