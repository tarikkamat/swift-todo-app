//
//  ListViewModel.swift
//  todoList
//
//  Created by Tarık KAMAT on 28.11.2021.
//

import Foundation

class ListViewModel: ObservableObject {
    
    @Published var items: [ItemModel] = [] {
        didSet{
            saveItems()
        }
    }
    let itemsKey: String = "items_list"
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
 
    init(){
        getItems()
    }
    
    func getItems(){
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? decoder.decode([ItemModel].self, from: data)
        else { return }
        
        self.items = savedItems
        
    }
    
    func deleteItem(indexSet: IndexSet){
        items.remove(atOffsets: indexSet)
        
    }
    
    func moveItem(from: IndexSet, to: Int){
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String){
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel){
        
//        I. OPTIONS
        
//        if let index = items.firstIndex{ (existingItem) -> Bool in
//            return existingItem.id == item.id
//        }{
//            // run this code
//        }
        
//      II. OPTIONS
        if let index = items.firstIndex(where: { $0.id == item.id }){
            items[index] = item.updateCompletion()
        }
    }
    
    func saveItems() {
        if let encodedData = try? encoder.encode(items){
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}
