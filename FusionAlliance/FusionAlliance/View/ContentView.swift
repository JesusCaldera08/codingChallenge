//
//  ContentView.swift
//  FusionAlliance
//
//  Created by Consultant on 8/8/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model = PostVM(service: Network())
    
    var body: some View {
        NavigationView{
            
            List(model.lists, id: \.self){
                RowView(title: $0.title, subtitle: $0.sportDescription)
            }.navigationTitle("Sports")
        }
        
    }
}

private struct RowView:View {
    var title: String
    var subtitle : String
    
    var body: some View{
        VStack(alignment: .leading){
            Text(title)
                .font(.headline)
            Text(subtitle)
                .font(.subheadline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
