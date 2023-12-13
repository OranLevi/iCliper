//
//  ContentClipboardView.swift
//  iCliper
//
//  Created by Oran Levi on 06/12/2023.
//

import SwiftUI
import SwiftData

struct ContentClipboardView: View {
    
    @StateObject private var vm = ContentClipboardViewModel()
    
    @State private var itemStates: [String: Bool] = [:]
    
    @Binding var isListMode: Bool
    
    var itemsArray: [CopiedData]
    var context: ModelContext
    var isEditMode: EditMode
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        if isListMode {
            listMode
        } else {
            tabMode
        }
    }
}

struct ContentClipboardView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group{
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try! ModelContainer(for: CopiedData.self, configurations: config)
            
            
            ContentClipboardView(isListMode: .constant(false), itemsArray: [CopiedData(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1"),CopiedData(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 2"),CopiedData(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 3")], context: ModelContext(container),isEditMode: .active)
            
            
            ContentClipboardView(isListMode: .constant(false), itemsArray: [CopiedData(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1"),CopiedData(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 2"),CopiedData(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 3")], context: ModelContext(container),isEditMode: .inactive)
                .preferredColorScheme(.dark)
        }
    }
}


extension ContentClipboardView {
    
    private var listMode: some View{
        ForEach(itemsArray.reversed()) { item in
            contextTextCopiedList(text: item.text, item: item, copiedOn: Date().formattedDate(inputDate: item.date))
        }
        .onDelete(perform: { indexSet in
            for index in indexSet {
                vm.delete(context: context, deleteItem: itemsArray.reversed()[index])
            }
        })
    }
    
    private var tabMode: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(itemsArray.reversed()) { item in
                contextTextCopiedTab(text: "\(item.text)", item: item, copiedOn: Date().formattedDate(inputDate: item.date))
            }
        }
        .listRowBackground(Color.clear)
    }
    
    private func copyButton(textToCopy: String) -> some View {
        Image(systemName: itemStates[textToCopy] ?? false ? "doc.text.fill" : "doc.text")
            .font(.title2)
            .foregroundColor(Color.theme.buttons)
    }
    
    private func contextTextCopiedList(text: String, item: CopiedData, copiedOn: String) -> some View{
        VStack{
            HStack{
                Text(text)
                    .lineLimit(2)
                Spacer()
                showDateButton(copiedOn: copiedOn)
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
    }
    
    private func contextTextCopiedTab(text: String, item: CopiedData, copiedOn: String) -> some View{
        
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(Color.theme.contentBackground2)
            .shadow(color: .gray.opacity(0.3), radius: 1)
            .frame(height: 100, alignment: .center)
            .overlay {
                VStack{
                    Text(text)
                        .fontWeight(.regular)
                        .padding(8)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    
                    Spacer()
                    HStack{
                        Spacer()
                        showDateButton(copiedOn: copiedOn)
                        copyButton(textToCopy: text)
                            .onTapGesture {
                                vm.copyButton(text: text)
                                itemStates[text] = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.09) {
                                    itemStates[text] = false
                                }
                            }
                        if isEditMode == .active {
                            Image(systemName: "trash")
                                .onTapGesture {
                                    vm.delete(context: context, deleteItem: item)
                                }
                                .font(.title2)
                        }
                        
                    }
                    .padding(.bottom,3)
                    .padding(.horizontal)
                    
                }
                
            }
    }
    
    private func showDateButton(copiedOn: String) -> some View {
        Menu {
            Text("\(copiedOn)")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(Color.theme.textDate)
        } label: {
            Image(systemName: "info.circle")
                .font(.title2)
                .foregroundColor(Color.theme.buttons)
        }
    }
}
