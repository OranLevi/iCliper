//
//  ClipBoardView.swift
//  iCliper
//
//  Created by Oran Levi on 26/11/2023.
//

import SwiftUI
import SwiftData

struct ClipBoardView: View {
    
    @Environment(\.modelContext) private var context
    @Query private var items: [CopiedData]
    
    @State private var editMode: EditMode = .inactive
    @State private var selectedItemIndex: Int?
    
    @State private var itemStates: [String: Bool] = [:]

    @StateObject private var vm = ClipBoardViewModel()
    
    var realArray: [CopiedData] {
        if vm.searchText == "" {
            return items
        } else {
            return items.filter {
                $0.text.contains(vm.searchText.lowercased()) ||
                $0.text.contains(vm.searchText.capitalized)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            
            List{
                if realArray.isEmpty {
                    empty
                }else{
                    ForEach(items.reversed()) { item in
                        HStack{
                            Text("\(item.text)")
                                .lineLimit(2)
                            Spacer()
                            copyButton(textToCopy: item.text)
                                .onTapGesture {
                                    vm.copyButton(text: item.text)

                                                        itemStates[item.text] = true

                                    
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.09) {
                                                            itemStates[item.text] = false
                                                        }

                                    
                                }
                        }
                        
                    }
                    .onDelete(perform: { indexSet in
                        for index in indexSet {
                            
                            vm.delete(context: context, deleteItem: items.reversed()[index])
                            if items.isEmpty{
                                editMode = .inactive
                            }
                        }
                        
                    })
                }
            }
            
            .environment(\.editMode, $editMode)
            .navigationTitle("\(String(localized: "Clipboard_navigationTitle"))")
            
            .toolbar {
                
                Button(action: {
                    if editMode == .active {
                        editMode = .inactive
                    } else {
                        editMode = .active
                    }
                }, label: {
                    Text(editMode == .inactive ? String(localized: "Clipboard_EditButton") : String(localized: "Clipboard_DoneButton"))
                })
            }
            
        }
        
        .searchable(
            text: $vm.searchText,
            prompt: "\(String(localized: "Clipboard_SearchTitle"))"
        )
        .disabled(vm.disableButtonEmptyArray(items: items) ? true : false)
        .onAppear{
            vm.gettingCopied(items: items, context: context)
            
        }
    }
}

#Preview {
    ClipBoardView()
}

extension ClipBoardView{
    
    
    private func copyButton(textToCopy: String) -> some View {
         Image(systemName: itemStates[textToCopy] ?? false ? "doc.text.fill" : "doc.text")
             .font(.title2)
             .foregroundColor(Color.theme.buttons)
     }
    
    private var empty: some View {
        Text("\(String(localized: "Clipboard_noCopies"))")
            .fontWeight(.light)
    }
}
