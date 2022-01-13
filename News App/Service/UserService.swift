//
//  UserService.swift
//  News App
//
//  Created by dimas pratama on 13/01/22.
//

import Foundation


class UserService {

    static let shared = UserService()

    var networkingClient = NetworkingClient()

    func getUsersDataFromServer(parameters: String, completion: @escaping (Users?, ErrorMapping?) -> Void) {
        guard let url = URL(string: Endpoint().base + parameters) else { return }
        print(url.absoluteString)
        networkingClient.execute(url) { data, error in
            if let error = error {
                print(error)
                completion(nil, error)
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(Users.self, from: data)
                    completion(result, nil)
                } catch {
                    print("fail")
                }
            }
        }
    }


}
