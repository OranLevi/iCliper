//
//  KeyboardView.swift
//  iCliper-Keyboard
//
//  Created by Oran Levi on 26/11/2023.
//

import SwiftUI
import SwiftData

struct KeyboardView: View {
    
    @Environment(\.modelContext) private var context
    
    @Query private var items: [CopiedData]
    
    @StateObject private var vm = KeyboardViewModel()
    
    @State private var heightKeyboard: CGFloat = 210
    @State private var editMode: EditMode = .inactive
    @State private var isListMode: Bool = true
    
    var keyboardViewController: KeyboardViewController?
    
    init( keyboardViewController: KeyboardViewController) {
        self.keyboardViewController = keyboardViewController
    }
    
    var body: some View {
        
        ZStack{
            Color.clear
            VStack{
                if vm.isOpenAccessGranted() {
                    
                    title
                    if items.isEmpty {
                        Spacer()
                        empty
                            .frame(height: heightKeyboard)
                    } else {
                        KeyboardContentClipboardView(isListMode: $isListMode, itemsArray: items, context: context, isEditMode: editMode, keyboardViewController: keyboardViewController)
                        
                            .environment(\.editMode, $editMode)
                            .frame(height: heightKeyboard)
                            .listStyle(.plain)
                    }
                    Spacer()
                    
                } else {
                    isOpenAccessGranted
                        .padding()
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7){
                    vm.gettingCopied(items: items, context: context)
                }
            }
        }
        
    }
}


struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            KeyboardView(keyboardViewController: KeyboardViewController())
            KeyboardView(keyboardViewController: KeyboardViewController())                .preferredColorScheme(.dark)
        }
    }
}

extension KeyboardView {
    
    private var title: some View {
        RoundedRectangle(cornerRadius: 0)
            .fill(Color.theme.contentBackground)
            .shadow(radius: 2)
            .frame(height: 47)
            .overlay {
                
                HStack{
                    HStack{
                        Button(action: {
                            if editMode == .active {
                                editMode = .inactive
                            } else {
                                editMode = .active
                            }
                        }, label: {
                            Text(editMode == .inactive || items.isEmpty ? String(localized: "KeyboardView_EditButton") : String(localized: "KeyboardView_DoneButton"))
                        })
                        .buttonStyle(.bordered)
                        .disabled(items.isEmpty ? true : false)
                    }
                    HStack(spacing: 5){
                        Button(action: {
                            isListMode.toggle()
                        }, label: {
                            Image(systemName: isListMode ? "list.dash.header.rectangle" : "list.bullet" )
                        })
                        .buttonStyle(.bordered)
                        .disabled(items.isEmpty ? true : false)
                    }.font(.title2)
                    
                    Spacer()
                    withAnimation(.spring) {
                        Text(vm.isNoTextCopied ? "\(String(localized: "KeyboardView_NoTextCopied"))" : "")
                            .fontWeight(.light)
                    }
                    Spacer()
                    
                    HStack{
                        Button(action: {
                            vm.addCopiedButton(context: context)
                        }, label: {
                            Text("\(String(localized: "KeyboardView_AddCopies"))")
                        })
                        .buttonStyle(.bordered)
                        .disabled(vm.isNoTextCopied ? true : false)
                    }
                }  .padding()
            }
    }
    
    private var empty: some View {
        Text("\(String(localized: "KeyboardView_noCopies"))")
            .fontWeight(.light)
    }
    
    private var isOpenAccessGranted: some View{
        VStack{
            ScrollView {
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("\(String(localized: "KeyboardView_OpenAccess_Text1"))")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("\(String(localized: "KeyboardView_OpenAccess_Text2"))")
                    Text("\(String(localized: "KeyboardView_OpenAccess_Text3"))")
                    Text("\(String(localized: "KeyboardView_OpenAccess_Text4"))")
                    Text("\(String(localized: "KeyboardView_OpenAccess_Text5"))")
                    Text("\(String(localized: "KeyboardView_OpenAccess_Text6"))")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    
                        .padding(.top, 16)
                    
                }     .padding()
                
                
            }
            .background(RoundedRectangle(cornerRadius: 16)
                .foregroundColor(Color(.systemBackground))
                .shadow(radius: 4))
        }
    }
}

