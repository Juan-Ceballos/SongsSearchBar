//
//  DetailedSongController.swift
//  SongsTableViewSearchBar
//
//  Created by Juan Ceballos on 12/2/19.
//  Copyright © 2019 C4Q . All rights reserved.
//

import UIKit

class DetailedSongController: UIViewController {

    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var defaultImageView: UIImageView!
    
    var songs: Song?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        guard let song = songs else {
            fatalError()
        }
        songLabel.text = song.name
        artistLabel.text = song.artist
        defaultImageView.image = #imageLiteral(resourceName: "loveSongs")
    }
}
