//
//  NetworkingClient.swift
//
//
//  Created by dimas pratama on 20/11/21.
//

import Foundation
import Alamofire

class NetworkingClient {

    typealias WebServiceResponse = (Data?, ErrorMapping?) -> Void

    func execute(_ url: URL, completion: @escaping WebServiceResponse) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Api-Key": pokemonServerKey
        ]
        if Connectivity.isConnectedToInternet {
            AF.request(url, method: .get , headers: headers).validate().responseJSON { response in
                if let error = response.error {
                    let errorData = ErrorMapping(code: response.response?.statusCode ?? 0, message: error.localizedDescription)
                    completion(nil, errorData)
                } else { // success
                    completion(response.data, nil)
                }
            }
        } else {
            let errorData = ErrorMapping(code: 503, message: "No Internet Connection")
            completion(nil, errorData)
        }
    }

}

struct ErrorMapping {
    var statusCode: Int
    var message: String

    init(code: Int, message: String) {
        self.statusCode = code
        self.message = message
    }
}

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
