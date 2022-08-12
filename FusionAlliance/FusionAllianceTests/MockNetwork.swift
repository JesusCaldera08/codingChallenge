//
//  MockNetwork.swift
//  FusionAllianceTests
//
//  Created by Consultant on 8/11/22.
//

import Foundation
import Combine
@testable import FusionAlliance

class MockNetwork : NetworkManager {
    
    var data : Data?
    var error : requestErrors?
    
    func getModel<Model>(_ model: Model.Type, from url: String) -> AnyPublisher<Model, requestErrors> where Model : Decodable {
        
        if let data = data {
            do{
                let result = try JSONDecoder().decode(model, from: data)
                return CurrentValueSubject<Model, requestErrors>(result).eraseToAnyPublisher()
            }catch { }
        }
        
        if let error = error {
            return Fail<Model,requestErrors>(error: error).eraseToAnyPublisher()
        }
        
        return Fail<Model, requestErrors>(error: .badURL ).eraseToAnyPublisher()
    }
    
    func getData(from url: String, completionHandler: @escaping (Data?) -> Void) {
        if let data = data{
            completionHandler(data)
        }
    }
    
    
    
    
    
}
