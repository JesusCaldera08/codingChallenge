//
//  networking.swift
//  FusionAlliance
//
//  Created by Consultant on 8/8/22.
//

import Foundation
import Combine

protocol NetworkManager{
    
    func getModel<Model: Decodable>(_ model: Model.Type, from url: String) -> AnyPublisher<Model, requestErrors>
    func getData(from url: String, completionHandler: @escaping (Data?) -> Void)
    
}

class Network: NetworkManager{
    
    func getModel<Model: Decodable>(_ model: Model.Type, from url: String) -> AnyPublisher<Model, requestErrors> {
        
        guard let url = URL(string: url) else{
            return Fail<Model,requestErrors>(error: .badURL).eraseToAnyPublisher()
        }
                
        
        return URLSession
            .shared
            .dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map { result -> Data in
                return result.data
            }
            .decode(type: model, decoder: JSONDecoder())
            .mapError{ error -> requestErrors in
                return .other(error)
            }
            .eraseToAnyPublisher()
    }
    
    func getData(from url: String, completionHandler: @escaping (Data?) -> Void) {
        
        guard let url = URL(string: url) else{
            completionHandler(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url){ data, _, _ in
            completionHandler(data)
            
        }.resume()
    }
    
    

}
