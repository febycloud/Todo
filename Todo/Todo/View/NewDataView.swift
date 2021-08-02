//
//  NewDataView.swift
//  Todo
//
//  Created by Fei Yun on 2021-06-13.
//

import SwiftUI

struct NewDataView: View {
    @ObservedObject var homeData:HomeViewModel
    @Environment(\.managedObjectContext) var context
    var body: some View {
        VStack{
            
            HStack{
                Text("\(homeData.updateItem == nil ? "Add New" : "Update" ) Note")
                    .font(.system(size:35))
                    .fontWeight(.heavy)
                    .foregroundColor(Color("Foreground"))
                Spacer(minLength: 0)
            }
            .padding()
            TextEditor(text:$homeData.content).padding()
            
            Divider().padding(.horizontal)
            HStack{
                Text("Add Date")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color("Foreground"))
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            }
            .padding()
            HStack(spacing:10){
                DateButton(title: "Today", homeData: homeData)
                DateButton(title: "Tomorrow", homeData: homeData)
                DatePicker("", selection: $homeData.date,displayedComponents:.date)
                    .labelsHidden()
            }
            .padding()
            
            Button(action: {homeData.writeData(context: context)}, label: {
                Label(
                    title: { Text( homeData.updateItem == nil ? "Add Now" : "Update")
                        .font(.title2)
                        .foregroundColor(.white)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    },
                    icon: { Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(Color("Background"))
                    }).padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 30)
                    .background(
                        LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                    )
                    .cornerRadius(8)
                    
            })
            .padding()
            //disable button when no date
            .disabled(homeData.content == "" ? true : false)
            .opacity(homeData.content == "" ? 0.5 : 1)
        }
        .background(Color.black.opacity(0.05).ignoresSafeArea(.all,edges: .bottom))
    }
}

