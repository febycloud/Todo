//
//  Home.swift
//  Todo
//
//  Created by Fei Yun on 2021-06-13.
//

import SwiftUI
import CoreData

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
            .shadow(color:Color(UIColor.lightGray),radius: 5,x: 0,y:0)
    }
}

struct Home: View {
    @StateObject var homeData = HomeViewModel()
    //fetch data
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key:"date",ascending:true)],animation:.spring()) var results : FetchedResults<Task>
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
            VStack(spacing:0){
                
                HStack{
                    Text("Notes")
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
                    Text("No Notes")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.black)
                        .fontWeight(.heavy)
                    Spacer()
                }
                else{
                
                ScrollView(.vertical,showsIndicators:false,content: {
                    LazyVStack(){
                        ForEach(results){ task in
                            VStack() {
                                Text(task.content ?? "")
                                    .font(.system(size:20))
                                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
                                Divider()
                                Text(task.date ?? Date(),style: .date)
                                    .font(.system(size:12))
                                    .fontWeight(.light)
                                    .padding(EdgeInsets(top: 5, leading: 20, bottom: 10, trailing: 20))
                            }
                            .foregroundColor(.black)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.white)
                            )
                            .clipped()
                            .shadow(color:Color(UIColor.lightGray),radius: 5,x: 0,y:0)
                            .padding()
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
                HStack{
                Image(systemName: "bookmark.fill")
                Text("Add Note")
                }
               
                    .foregroundColor(.white)
                    .padding(10)
                    
            })
            .padding()
            .buttonStyle(GradientButtonStyle())
            
        })
        .ignoresSafeArea(.all,edges:.top)
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all,edges:.all))
        .sheet(isPresented: $homeData.isNewData, content: {
            NewDataView(homeData: homeData)
        })
    }
}



