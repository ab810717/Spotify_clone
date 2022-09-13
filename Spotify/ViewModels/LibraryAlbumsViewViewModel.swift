//
//  LibraryAlbumsViewViewModel.swift
//  Spotify
//
//  Created by Andy Hao on 2022/9/8.
//

import Foundation
protocol LibraryAlbumsViewViewModelOutput: AnyObject {
    func updateUI()
}
class LibraryAlbumsViewViewModel {
    var albums: [Album] = []
    weak var delegate: LibraryAlbumsViewViewModelOutput?
    
    func fetchData() {
        APICaller.shared.getCurrentUserAlbums { result in
            DispatchQueue.main.async {
                switch result {
                case .success( let albums):
                    self.albums = albums
                    self.delegate?.updateUI()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
}
