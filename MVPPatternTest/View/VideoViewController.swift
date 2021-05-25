//
//  VideoViewController.swift
//  MVPPatternTest
//
//  Created by Denis Velikanov on 25.05.2021.
//

import UIKit
import youtube_ios_player_helper
import AVKit

class VideoViewController: UIViewController, YTPlayerViewDelegate {
    
    var fact: DayFact?

    var videoURL: URL?
    var array = [Character]()
    var iD = String()
    
    let player = YTPlayerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //  view.backgroundColor = .blue
        title = fact?.title
        checkURL(url: fact?.url ?? "")

        setup()
        constraint()
    }
    
    
    func checkURL(url: String) {
        guard let fact = fact else { return }
        getID(string: fact.url)
    }

    func getID(string: String) {
        
            for i in string {
                array.append(i)
                print(i)
                print(array)
            }
        
   
            array.removeFirst(30)
            array.removeLast(6)
            
            print(array as Any)
        
        for i in array {
            iD.append(i)
        }
        
    print(iD)
  
    }

    
    
    func setup() {
        view.addSubview(player)
        player.load(withVideoId: iD)
        player.delegate = self
    }
    
    func constraint() {
        player.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        player.playVideo()
    }

}
