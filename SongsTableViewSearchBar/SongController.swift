//
//  ViewController.swift
//  SongsTableViewSearchBar
//
//  Created by C4Q  on 11/6/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class SongController: UIViewController {

    @IBOutlet weak var songTableView: UITableView!
    
    var songs = [Song]()    {
        didSet  {
            songTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songTableView.dataSource = self
        loadData()
    }
    
    func loadData() {
        songs = Song.loveSongs
    }
}

extension SongController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let songCell = songTableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        let song = songs[indexPath.row]
        songCell.textLabel?.text = song.name
        songCell.detailTextLabel?.text  = song.artist
        return songCell
    }
}

