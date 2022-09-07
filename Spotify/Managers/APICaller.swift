//
//  APICaller.swift
//  Spotify
//
//  Created by Andy Hao on 2022/7/19.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    struct Constansts {
        static let baseURL = "https://api.spotify.com/v1"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    // MARK: - Get Album details
    public func getAlbumDetails(for album: Album, completion: @escaping (Result<AlbumDetailsResponse, Error>) -> Void ) {
        createRequest(with: URL(string: Constansts.baseURL + "/albums/" + album.id), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(AlbumDetailsResponse.self, from: data)
                    completion(.success(result))
                } catch let error {
                    print("DEBUG: Could not get album details error: \(error.localizedDescription)")
                    completion(.failure(APIError.failedToGetData))
                }

            }
            task.resume()
        }
    }
    
    // MARK: - Get Playlists Detail
    
    public func getPlaylistsDetail(for playlist: Playlist, completion: @escaping (Result<PlaylistDetailsResponse,Error>) -> Void) {
        createRequest(with: URL(string: Constansts.baseURL + "/playlists/" + playlist.id), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil  else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(PlaylistDetailsResponse.self, from: data)
                    completion(.success(result))
                } catch let error {
                    print(error.localizedDescription)
                    completion(.failure(APIError.failedToGetData))
                }

            }
            task.resume()
        }
    }
    
    public func getCurrentUserPlaylists(completion: @escaping (Result<[Playlist], Error>) -> Void) {
        createRequest(with: URL(string: Constansts.baseURL + "/me/playlists?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(LibraryPlaylistsResponse.self, from: data)
                    completion(.success(result.items))
                } catch {
                    print(error)
                    completion(.failure(APIError.failedToGetData))
                }
                
            }
            task.resume()
        }
    }
    
    public func createPlaylist(with name: String, completion: @escaping (Bool) -> Void) {
        getCurrentUserProfile { [weak self] result  in
            switch result {
                case .success(let profile):
                    let urlString = Constansts.baseURL + "/users/\(profile.id)/playlists"
                    print(urlString)
                    self?.createRequest(with: URL(string: urlString), type: .POST, completion: { baseRequest in
                        var request = baseRequest
                        let json = ["name" : name]
                        
                        request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
                        let task = URLSession.shared.dataTask(with: request) { data, _, error in
                            guard let data = data , error == nil else {
                                completion(false)
                                return
                            }
                            
                            do {
                                let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                                if let response = result as? [String: Any], response["id"] as? String != nil {
                                    print("Created")
                                    completion(true)
                                } else {
                                    print("Failed to get id")
                                    completion(false)
                                }

                            } catch  {
                                print(error.localizedDescription)
                                completion(false)
                            }
                        }
                        task.resume()
                    })
                case .failure(_):
                    completion(false)
                }
        }
    }
    
    public func addTarckToPlaylist(track: AudioTrack, playlist: Playlist, completion: @escaping (Bool) -> Void) {
        createRequest(with: URL(string: Constansts.baseURL + "/playlists/\(playlist.id)/tracks"), type: .POST) { baseRequest in
            var request = baseRequest
            let json = [
                "uris": ["spotify:track:\(track.id)"]
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil  else {
                    completion(false)
                    return
                }
                do {
                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    // "snapshot_id": "abc"
                    if let response = result as? [String:Any], response["snapshot_id"] as? String != nil {
                        completion(true)
                    }
                } catch  {
                    print(error.localizedDescription)
                    completion(false)
                }

            }
            task.resume()
        }
    }
    
    public func removeTrackFromPlaylist(track: AudioTrack) {
        
    }
    
    // MARK: - Get CurrentUserProfile
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        createRequest(with: URL(string: Constansts.baseURL + "/me"), type: .GET) { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _ , error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    print("DEBUG: the result of getCurrentUserProfile: \(result) ")
                    completion(.success(result))
                } catch  {
                    print("DEBUG: Get an error : \(error.localizedDescription)")
                    completion(.failure(error))
                }

            }
            task.resume()
        }
    }
    
    // MARK: - Get NewReleases
    public func getNewReleases(comlection: @escaping ((Result<NewReleasesResponse, Error>)) -> Void) {
        createRequest(with: URL(string: Constansts.baseURL + "/browse/new-releases?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data , error == nil else {
                    return
                }
                do {
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    comlection(.success(result))
                } catch let error {
                    print("DEBUG: Get an error: \(error)")
                    comlection(.failure(APIError.failedToGetData))
                }

            }
            task.resume()
        }
    }
    
    // MARK: - Get FeaturePlayList
    public func getFeaturePlayLists(completion: @escaping ((Result<FeaturedPlayListsResponse, Error>) -> Void)) {
        createRequest(with: URL(string: Constansts.baseURL + "/browse/featured-playlists") , type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(FeaturedPlayListsResponse.self, from: data)
                    completion(.success(result))
                } catch let error {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Get RecommendationGenres
    public func getRecommendationGenres(completion: @escaping ((Result<RecommendedGenresResponse,Error>) -> Void)) {
        createRequest(with: URL(string: Constansts.baseURL + "/recommendations/available-genre-seeds"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(RecommendedGenresResponse.self, from: data)
                    completion(.success(result))
                } catch let error {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
        
    }
    
    // MARK: - Get Recommendations
    public func getRecommendations(genres: Set<String>,completion: @escaping ((Result<RecommendationsResponse,Error>) -> Void) ) {
        let seeds = genres.joined(separator: ",")
        createRequest(with: URL(string: Constansts.baseURL + "/recommendations?limit=40&seed_genres=\(seeds)") , type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(RecommendationsResponse.self, from: data)
                    completion(.success(result))
                } catch let error {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Get Categories
    public func getCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        createRequest(with: URL(string: Constansts.baseURL + "/browse/categories?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(AllCategoriesResponse.self, from: data)
                    completion(.success(result.categories.items))
                } catch let error {
                    print("DEBUG: Get an error: \(error.localizedDescription)")
                    completion(.failure(APIError.failedToGetData))
                }
            }
            
            task.resume()
        }
    }
    
    // MARK: - Get Category playlists
    public func getCategoryPlaylists(category: Category, completion: @escaping (Result<[Playlist], Error>) -> Void) {
        createRequest(with: URL(string: Constansts.baseURL + "/browse/categories/\(category.id)/playlists?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(CategoryPlaylistsResponse.self, from: data)
                    let playlists = result.playlists.items
                    completion(.success(playlists))
                } catch let error {
                    print("DEBUG: Get an error: \(error.localizedDescription)")
                }
            }
            
            task.resume()
        }
    }
    
    // MARK: - Search
    public func search(with query: String, completion: @escaping (Result<[SearchResult], Error>) -> Void) {
        createRequest(with: URL(string: Constansts.baseURL + "/search?limit=10&type=album,artist,playlist,track&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "" )"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(SearchResultResponse.self, from: data)
                    var searchResults:[SearchResult] = []
                    searchResults.append(contentsOf: result.albums.items.compactMap({ .album(model: $0)}))
                    searchResults.append(contentsOf: result.tracks.items.compactMap({ .track(model: $0)}))
                    searchResults.append(contentsOf: result.playlists.items.compactMap({ .playlist(model: $0)}))
                    searchResults.append(contentsOf: result.artists.items.compactMap({ .artist(model: $0)}))
                    completion(.success(searchResults))
                   
                } catch {
                    completion(.failure(APIError.failedToGetData))
                }

            }
            task.resume()
        }
    }
    
    // MARK: - Private
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    private func createRequest(with url: URL?,type: HTTPMethod, completion: @escaping (URLRequest) -> Void) {
        AuthManager.shared.withValidToken { token in
            guard let apiURL = url else { return }
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
    
    
    
}
