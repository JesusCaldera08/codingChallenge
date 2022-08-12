//
//  extensionErrors.swift
//  FusionAlliance
//
//  Created by Consultant on 8/9/22.
//

import Foundation

enum requestErrors: Error{
    
    case badURL
    case decodeError(Error)
    case other(Error)
    
}
