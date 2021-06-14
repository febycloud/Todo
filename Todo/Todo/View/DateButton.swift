//
//  DateButton.swift
//  Todo
//
//  Created by Fei Yun on 2021-06-13.
//

import SwiftUI

struct DateButton: View {
    var title:String
    @ObservedObject var homeData:HomeViewModel
    var body: some View {
        Button(action: {homeData.updateDate(value: title)}, label: {
            Text(title)
                .fontWeight(.bold)
                .foregroundColor(homeData.checkDate() == title ? .white : .gray)
                .padding(.vertical,10)
                .padding(.horizontal,20)
                .background(
                    homeData.checkDate() == title ?
                    LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                    
                    : LinearGradient(gradient: .init(colors: [Color.white]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                
                
                ).cornerRadius(6)
        })
    }
}

