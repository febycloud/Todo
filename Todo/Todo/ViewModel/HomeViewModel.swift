//
//  HomeViewModel.swift
//  Todo
//
//  Created by Fei Yun on 2021-06-13.
//

import SwiftUI
import CoreData

class HomeViewModel:ObservableObject{
    @Published var content = ""
    @Published var date = Date()
    // create new sheet
    @Published var isNewData = false
    // checking and update date
    
    //storage updated item
    @Published var updateItem : Task!
    
    let calender = Calendar.current
    func checkDate()->String{
        if calender.isDateInToday(date){
            return "Today"
        }
        else if calender.isDateInTomorrow(date){
            return "Tomorrow"
        }
        else{
            return "Other Date"
        }
    }
    func updateDate(value:String){
        if value == "Today"{
            date=Date()
        }
        else if value == "Tomorrow" {
            date = calender.date(byAdding: .day, value: 1, to: Date())!
        }
        else {
            // do sth
        }
    }
    func writeData(context:NSManagedObjectContext){
        //update data
        if updateItem != nil{
            updateItem.date = date
            updateItem.content = content
            try! context.save()
            //remove updating item after updated
            
            updateItem = nil
            isNewData.toggle()
            content = ""
            date = Date()
            return
        }
        
        
        let newTask = Task(context: context)
        newTask.date=date
        newTask.content=content
        // saving
        do{
            try context.save()
            isNewData.toggle()
            content = ""
            date = Date()
        }
        catch{
            print(error.localizedDescription)
        }
        
        
    }
    func editItem(item:Task){
        updateItem=item
        //toggle the item
        date=item.date!
        content=item.content!
        isNewData.toggle()
    }
    
}
