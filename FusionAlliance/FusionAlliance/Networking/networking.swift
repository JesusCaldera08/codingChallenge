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
        

}
