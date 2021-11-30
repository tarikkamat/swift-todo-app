//
//  todoListApp.swift
//  todoList
//
//  Created by Tarık KAMAT on 28.11.2021.
//

import SwiftUI

@main
struct todoListApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ListView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(listViewModel)
        }
    }
}
