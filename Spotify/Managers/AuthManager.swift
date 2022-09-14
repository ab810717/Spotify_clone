//
//  AuthManager.swift
//  Spotify
//
//  Created by Andy Hao on 2022/7/19.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    private var refreshingToken = false
    private init() {}
    
    public var signInUrl: URL? {
        let baseUrl = "https://accounts.spotify.com/authorize"
        let paramsStr = "\(baseUrl)?response_type=code&client_id=\(Constants.clientId)&scope=\(Constants.scopes)&redirect_uri=\(Constants.redirectURI)&show_dialog=TRUE"
        return URL(string: paramsStr)
    }
    
    var isSignedIn: Bool {
        return accessToken != nil
    }
    
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    private var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationData = tokenExpirationDate else { return false }
        let currentData = Date()
        let fiveMinute: TimeInterval = 300
        
        return currentData.addingTimeInterval(fiveMinute) >= expirationData
    }
    
    public func exchangeCodeForToken(code: String, completion: @escaping ((Bool) -> Void)) {
        
        guard let url = URL(string: Constants.tokenAPIURL) else { return }
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI)
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = Constants.clientId + ":" + Constants.clientSeceret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("DEBUG: failure to get base64")
            completion(false)
            return
        }
        
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let self = self else { return }
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            do {
                print("DEBUG: Get data: \(data)")
                let result =  try JSONDecoder().decode(AuthResponse.self, from: data)
                self.cacheToken(result: result)
                print("DEBUG: Get AuthResponse successfully! ")
                completion(true)
                
            } catch let error {
                print("DEBUG: Get an error: \(error.localizedDescription)")
                completion(false)
            }
        }
        
        task.resume()
    }
    
    private var onRefreshBlocks = [((String) -> Void)]()
    
    /// Supplies valid token to be used  with API calls
    public func withValidToken(completion: @escaping (String) -> Void) {
        
        guard !refreshingToken else {
            // Append the completion
            onRefreshBlocks.append(completion)
            return
        }
        
        if shouldRefreshToken {
            refreshTokenIfNeeded { [weak self] success in
                guard let self = self else { return }
                if success {
                    if let token = self.accessToken {
                        completion(token)
                    }
                }
            }
            // Refresh token
        } else if let token = accessToken {
            completion(token)
        }
    }
    
    public func refreshTokenIfNeeded(completion: ((Bool) -> Void)?) {
        
        guard !refreshingToken else { return }
        
        guard shouldRefreshToken else {
            completion?(true)
            return
        }
        
        guard let resfreshToken = self.refreshToken else { return }
        
        // Refresh the token
        guard let url = URL(string: Constants.tokenAPIURL) else { return }
        
        refreshingToken = true
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: resfreshToken)
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = Constants.clientId + ":" + Constants.clientSeceret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("DEBUG: failure to get base64")
            completion?(false)
            return
        }
        
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let self = self else { return }
            self.refreshingToken = false
            guard let data = data, error == nil else {
                completion?(false)
                return
            }
            
            do {
                let result =  try JSONDecoder().decode(AuthResponse.self, from: data)
                print("Successfully refreshed with token \(String(describing: self.accessToken))")
                self.onRefreshBlocks.forEach {$0(result.accessToken)}
                self.onRefreshBlocks.removeAll()
                self.cacheToken(result: result)
                completion?(true)
                
            } catch let error {
                print("DEBUG: Get an error: \(error.localizedDescription)")
                completion?(false)
            }
        }
        
        task.resume()
    }
    
    public func signOut(completion: ((Bool) -> Void)) {
        UserDefaults.standard.setValue(nil, forKey: "access_token")
        UserDefaults.standard.setValue(nil, forKey: "refresh_token")
        UserDefaults.standard.setValue(nil, forKey: "expirationDate")
        completion(true)
    }
    
    private func cacheToken(result: AuthResponse) {
        UserDefaults.standard.setValue(result.accessToken, forKey: "access_token")
        if let refreshToken = result.refreshToken {
            UserDefaults.standard.setValue( refreshToken, forKey: "refresh_token")
        }
        
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expiresIn)), forKey: "expirationDate")
    }
    
}
