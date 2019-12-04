//
//  ViewController.swift
//  SongsTableViewSearchBar
//
//  Created by C4Q  on 11/6/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

enum SearchScope    {
    case song
    case artist
}

class SongController: UIViewController {

    @IBOutlet weak var songTableView: UITableView!
    @IBOutlet weak var songSearchBar: UISearchBar!
    
    var songs = [Song]()    {
        didSet  {
            songTableView.reloadData()
        }
    }
    
    var currentScope = SearchScope.song
    
    var searchQuery = ""    {
        didSet  {
            switch currentScope {
            case .song:
                songs = Song.loveSongs.filter{$0.name.lowercased().contains(searchQuery.lowercased())
                }
            case .artist:
                songs = Song.loveSongs.filter{$0.artist.lowercased().contains(searchQuery.lowercased())}
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songTableView.dataSource = self
        songSearchBar.delegate = self
        loadData()
    }
    
    func loadData() {
        songs = Song.loveSongs
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailedSongController = segue.destination as? DetailedSongController, let indexPath = songTableView.indexPathForSelectedRow else  {
            fatalError()
        }
        let song = songs[indexPath.row]
        detailedSongController.songs = song
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

extension SongController: UISearchBarDelegate   {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty   else    {
            loadData()
            return
        }
        
        searchQuery = searchText
        
        if songs.isEmpty {
            songs.append(Song(name: "No Results", artist: ""))
            searchBar.resignFirstResponder()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            currentScope = .song
        case 1:
            currentScope = .artist
        default:
            print("doesn't exist")
        }
    }
}

