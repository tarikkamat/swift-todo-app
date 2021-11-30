//
//  ListView.swift
//  todoList
//
//  Created by Tarık KAMAT on 28.11.2021.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listModelView: ListViewModel
    
    var body: some View {
        ZStack {
            if listModelView.items.isEmpty {
                NoItemsView()
            }else{
                List{
                    ForEach(listModelView.items){ item in
                        ListRowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear){
                                    listModelView.updateItem(item: item)
                                }
                            }
                    }
                    .onDelete(perform: listModelView.deleteItem)
                    .onMove(perform: listModelView.moveItem)
                }.listStyle(PlainListStyle())
            }
        }
        .navigationTitle("Todo List 📝")
        .navigationBarItems(
            leading: EditButton(),
            trailing:
                NavigationLink("Add", destination: AddView())
        )
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ListView()
        }.environmentObject(ListViewModel())
    }
}
