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
    @State private var isCopyButton:Bool = false {
        didSet{
            if isCopyButton {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.09){
                    isCopyButton = false
                }
            }
        }
    }
    
    private let segmentIcons = ["list.bullet", "list.dash.header.rectangle"]
    
    var timer: Timer?
    

    
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
                            List{
                                ForEach(items.reversed()) { item in
                                    contextTextCopiedList(text: "\(item.text)")
                                        .padding(.vertical, -6)
                                }
                                .onDelete(perform: { indexSet in
                                    for index in indexSet {
                                        vm.delete(context: context, deleteItem: items.reversed()[index])
                                    }
                                })
                                .onAppear{
                                    
//                                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//                                        
                                        vm.gettingCopied(items: items, context: context)
//                                    }
                                }
                                .onDisappear {
//                                    timer?.invalidate()
                                }
                                .listRowBackground(Color.clear)
                            }
                           
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
                    Spacer()
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
                    
                
            }  .onTapGesture {
                keyboardViewController?.insertText(text: text)
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
            .background(RoundedRectangle(cornerRadius: 16) // Background with rounded corners
                    .foregroundColor(Color(.systemBackground))
                    .shadow(radius: 4))
        }
    }
}

