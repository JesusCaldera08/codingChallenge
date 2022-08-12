//
//  viewModelList.swift
//  FusionAlliance
//
//  Created by Consultant on 8/8/22.
//

import Foundation
import Combine

class PostVM : ObservableObject {
    
    let service : NetworkManager? //dependency injection
    
    init(service:NetworkManager){
        
        self.service = service
        getPost(from: APIlinks.url)
    }
    
    @Published var lists = [listSports](){
        didSet{
            didChange.send(self)
        }
    }
    private var subscribers = Set<AnyCancellable>()
    
    let didChange = PassthroughSubject<PostVM, Never>()
    
    func getPost(){
        lists = []
        getPost(from: APIlinks.url)
    }
    
    private func getPost(from url:String){
    
        service?.getModel([listSports].self, from: url)
            .sink { completion in
                
            }receiveValue: { [weak self] response in
                
                self!.lists = response
                
            }.store(in: &subscribers)
        
    }
}
