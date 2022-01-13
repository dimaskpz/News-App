//
//  AlbumService.swift
//  News App
//
//  Created by dimas pratama on 13/01/22.
//

import Foundation
class AlbumService {

    static let shared = AlbumService()

    var networkingClient = NetworkingClient()

    func getDataFromServer(parameters: String, completion: @escaping (Albums?, ErrorMapping?) -> Void) {
        guard let url = URL(string: Endpoint().base + parameters) else { return }
        print(url.absoluteString)
        networkingClient.execute(url) { data, error in
            if let error = error {
                print(error)
                completion(nil, error)
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(Albums.self, from: data)
                    completion(result, nil)
                } catch {
                    print("fail")
                }
            }
        }
    }


}


