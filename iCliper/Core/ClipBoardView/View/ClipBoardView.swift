//
//  ClipBoardView.swift
//  iCliper
//
//  Created by Oran Levi on 26/11/2023.
//

import SwiftUI
import SwiftData

struct ClipBoardView: View {
    
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.modelContext) private var context
    
    @Query private var items: [CopiedData]
    
    @State private var editMode: EditMode = .inactive
    
    @State private var itemStates: [String: Bool] = [:]
    @State private var isListMode: Bool = true
    
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
                        .onAppear{
                            editMode = .inactive
                        }
                    
                } else {
                    ContentClipboardView(isListMode: $isListMode, itemsArray: realArray, context: context, isEditMode: editMode)
                        .listRowInsets(!isListMode ? EdgeInsets() : nil)
                }
            }
            .environment(\.editMode, $editMode)
            .navigationTitle("\(String(localized: "Clipboard_navigationTitle"))")
            
            .toolbar {
                Button(action: {
                    isListMode.toggle()
                }, label: {
                    Image(systemName: isListMode ? "list.dash.header.rectangle" : "list.bullet")
                })
                
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
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                vm.gettingCopied(items: items, context: context)
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: CopiedData.self, configurations: config)
    
    for i in 1..<10 {
        let data = CopiedData(text: "CopyText")
        container.mainContext.insert(data)
    }
    return ClipBoardView()
        .modelContainer(container)
}

extension ClipBoardView{
    
    private var empty: some View {
        Text("\(String(localized: "Clipboard_noCopies"))")
            .fontWeight(.light)
    }
}
