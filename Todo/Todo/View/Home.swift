//
//  Home.swift
//  Todo
//
//  Created by Fei Yun on 2021-06-13.
//

import SwiftUI
import CoreData

struct Home: View {
    @StateObject var homeData = HomeViewModel()
    //fetch data
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key:"date",ascending:true)],animation:.spring()) var results : FetchedResults<Task>
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
            VStack(spacing:0){
                
                HStack{
                    Text("Tasks")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                    Spacer()
                }
                .padding()
                .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                .background(Color.white)
                
                if results.isEmpty{
                    Spacer()
                    Text("No Task")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.black)
                        .fontWeight(.heavy)
                    Spacer()
                }
                else{
                
                ScrollView(.vertical,showsIndicators:false,content: {
                    LazyVStack(alignment: .leading, spacing: 20){
                        ForEach(results){ task in
                            VStack(alignment: .leading, spacing: 5, content: {
                                Text(task.content ?? "")
                                    .font(.title)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                
                                Text(task.date ?? Date(),style: .date)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            })
                            .foregroundColor(.black)
                            .contextMenu(ContextMenu(menuItems: {
                                Button(action: {homeData.editItem(item: task)
                                }, label: {
                                    Text("Edit")
                                })
                                Button(action: {
                                    context.delete(task)
                                    try! context.save()
                                }, label: {
                                    Text("Delete")
                                })
                            }))
                            
                        }
                    }
                    .padding()
                })
                }
            }
            //add button
            Button(action: {homeData.isNewData.toggle()}, label: {
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(
                        AngularGradient(gradient: .init(colors: [Color("Color"),Color("Color1")]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    )
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            })
            .padding()
            
            
        })
        .ignoresSafeArea(.all,edges:.top)
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all,edges:.all))
        .sheet(isPresented: $homeData.isNewData, content: {
            NewDataView(homeData: homeData)
        })
    }
}


