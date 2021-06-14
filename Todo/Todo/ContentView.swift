//
//  ContentView.swift
//  Todo
//
//  Created by Fei Yun on 2021-06-10.
//

import SwiftUI
import CoreData

struct ContentView: View {
    init(){
        UITextView.appearance().backgroundColor = .clear
    }
    var body: some View{
        Home()
    }
}
