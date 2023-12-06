//
//  KeyboardContentClipboard.swift
//  iCliper
//
//  Created by Oran Levi on 06/12/2023.
//

import SwiftUI
import SwiftData

struct KeyboardContentClipboardView: View {
    
    @StateObject private var vm = KeyboardContentClipboardViewModel()
    
    @Binding var isListMode: Bool
    
    var itemsArray: [CopiedData]
    var context: ModelContext
    var isEditMode: EditMode
    var keyboardViewController: KeyboardViewController?
    
    private let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        if isListMode {
            listMode
        } else {
            tabMode
                .padding()
        }
    }
}

struct KeyboardContentClipboardView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group{
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try! ModelContainer(for: CopiedData.self, configurations: config)
            
            KeyboardContentClipboardView(isListMode: .constant(true), itemsArray: [CopiedData(text: "CopyTest"),CopiedData(text: "Text")], context: ModelContext(container), isEditMode: .inactive)
            
            
            KeyboardContentClipboardView(isListMode: .constant(true), itemsArray: [CopiedData(text: "CopyTest"),CopiedData(text: "Text")], context: ModelContext(container), isEditMode: .inactive)
                .preferredColorScheme(.dark)
        }
    }
}


extension KeyboardContentClipboardView {
    
    private var tabMode: some View{
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(itemsArray.reversed()) { item in
                    HStack{
                        contextTextCopiedTab(text: "\(item.text)", deleteItem: item)
                    }
                    
                }
            }    .listRowInsets(EdgeInsets())
            
        }
    }
    
    private var listMode: some View {
        List{
            ForEach(itemsArray.reversed()) { item in
                contextTextCopiedList(text: "\(item.text)")
                    .padding(.vertical, -6)
            }
            .onDelete(perform: { indexSet in
                
                for index in indexSet {
                    vm.delete(context: context, deleteItem: itemsArray.reversed()[index])
                }
            })
            .listRowBackground(Color.clear)
        }
        
    }
    
    private func contextTextCopiedList(text: String) -> some View{
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(Color.theme.contentBackground)
            .shadow(color: .gray.opacity(0.3), radius: 1)
            .frame(height: 50, alignment: .center)
            .overlay {
                HStack{
                    Text(text)
                        .lineLimit(2)
                        .foregroundStyle(Color.theme.text)
                    Spacer()
                }
                .padding(.horizontal)
                
                
            }   .onTapGesture {
                keyboardViewController?.insertText(text: text)
            }
        
    }
    
    private func contextTextCopiedTab(text: String, deleteItem: CopiedData) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(Color.theme.contentBackground)
            .shadow(color: .gray.opacity(0.3), radius: 1)
            .frame(height: 79, alignment: .center)
            .overlay {
                HStack{
                    Text(text)
                        .lineLimit(2)
                        .foregroundStyle(Color.theme.text)
                    Spacer()
                    VStack{
                        if isEditMode == .active {
                            Image(systemName: "trash")
                                .onTapGesture {
                                    vm.delete(context: context, deleteItem: deleteItem)
                                }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .onTapGesture {
                keyboardViewController?.insertText(text: text)
            }
    }
}
