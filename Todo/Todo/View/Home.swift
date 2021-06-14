//
//  Home.swift
//  Todo
//
//  Created by Fei Yun on 2021-06-13.
//

import SwiftUI

struct Home: View {
    @StateObject var homeData = HomeViewModel()
    var body: some View {
        Button(action: {homeData.isNewData.toggle()}, label: {
            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
        }).sheet(isPresented: $homeData.isNewData, content: {
            NewDataView(homeData: homeData)
        })
    }
}


