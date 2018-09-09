//
//  NetworkService.swift
//  test
//
//  Created by Daenim on 9/9/18.
//  Copyright © 2018 rokobit. All rights reserved.
//

import UIKit
import PluggableApplicationDelegate
import Alamofire

extension JSONDecoder {
    static let appDefault : JSONDecoder = {
        let d = JSONDecoder()
        //additional config
        return d
    }()
}

struct Serializer<T : Decodable>: DataResponseSerializerProtocol {
    typealias SerializedObject = T
    
    var serializeResponse: (URLRequest?, HTTPURLResponse?, Data?, Error?) -> Result<T>
    
    init()
    {
        self.serializeResponse = {
            request, response, data, error in
            
            let resultData = Request.serializeResponseData(response: response, data: data, error: error)
            switch resultData {
            case .success(let data):
                do {
                    let result = try JSONDecoder.appDefault.decode(T.self, from: data)
                    return .success(result)
                } catch {
                    return .failure( error )
                }
            case .failure(let error):
                if let data = data, data.count > 0 {
                    return .failure( error )
                }
                return .failure(error)
            }
        }
    }
}

class NetworkService: NSObject, ApplicationService {
    static let shared = NetworkService()
    
    func login(username: String, password: String, callback: @escaping (User?, Error?) -> () ) {
        let url = "https://reqres.in/api/users/2"
        guard username == "+380961235555", password == "test" else {
            callback(nil, AFError.invalidURL(url: url))
            return
        }
        
        request(url).response(responseSerializer: Serializer<User>()) { (response) in
            callback(response.value, response.error)
        }
    }
    
    func getImage(_ url : URLConvertible, callback: @escaping (UIImage?, Error?) -> () ) {
        request(url).responseData { (response) in
            switch response.result {
            case .success(let data):
                callback(UIImage(data: data), nil)
            case .failure(let error):
                callback(nil, error)
            }
        }
    }
}
