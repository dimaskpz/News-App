//
//  PostService.swift
//  News App
//
//  Created by dimas pratama on 13/01/22.
//

import Foundation

class PostService {

    static let shared = PostService()

    var networkingClient = NetworkingClient()

    func getPostDataFromServer(parameters: String, completion: @escaping (Posts?, ErrorMapping?) -> Void) {
        guard let url = URL(string: Endpoint().base + parameters) else { return }
        print(url.absoluteString)
        networkingClient.execute(url) { data, error in
            if let error = error {
                print(error)
                completion(nil, error)
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(Posts.self, from: data)
                    completion(result, nil)
                } catch {
                    print("fail")
                }
            }
        }
    }

    func getUsersDataFromServer(parameters: String, completion: @escaping (Posts?, ErrorMapping?) -> Void) {
        guard let url = URL(string: Endpoint().base + parameters) else { return }
        print(url.absoluteString)
        networkingClient.execute(url) { data, error in
            if let error = error {
                print(error)
                completion(nil, error)
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(Posts.self, from: data)
                    completion(result, nil)
                } catch {
                    print("fail")
                }
            }
        }
    }


}
