//
//  SettingView.swift
//  iCliper
//
//  Created by Oran Levi on 27/11/2023.
//

import SwiftUI

struct SettingView: View {
    
    @Environment(\.modelContext) private var context

    @StateObject private var vm = SettingViewModel()
    @State private var showAlert:Bool = false
    
    var body: some View {
        NavigationStack{
            List{
                Section{
                    HStack{
                        Image(systemName: "star")
                        Text(String(localized: "SettingView_RateUs"))
                            .onTapGesture {
                                let urlString = "https://apps.apple.com/app/iCliper/6473295955?action=write-review"

                                if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
                                    UIApplication.shared.open(url) { success in
                                        print(success ? "URL opened successfully." : "Error opening URL.")
                                    }
                                } else {
                                    print("Invalid URL or cannot open URL.")
                                }
                            }
                    }
                   
                    HStack{
                        Image(systemName: "square.and.arrow.up")

                        Text(String(localized: "SettingView_ShareApp"))
                            .onTapGesture {
                                vm.actionSheet()
                            }
                    }
            
                    HStack{
                        Image(systemName: "hand.app")
                        NavigationLink(String(localized: "SettingView_HowToUse")) {
                            HowToUseView()
                        }
                    }
                    
                    HStack{
                        Image(systemName: "info.circle")
                       
                   
                    NavigationLink("About") {
                     AboutView()
                    }
                    }
                   
                }
                Section{
                    Text(String(localized: "SettingView_AlertDeleteAll"))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.red)
                        .onTapGesture {
                            showAlert.toggle()
                        }  .alert(String(localized: "SettingView_AlertDeleteAll"), isPresented: $showAlert) {
                            Button(String(localized: "SettingView_AlertDeleteButton"), role: .destructive) {
                                vm.deleteAll(context: context)
                            }
                        } message: {
                            Text("\(String(localized: "SettingView_MessageAlert"))")
                        }
                }
                }     .navigationTitle("SettingView_Tittle")
                .navigationBarTitleDisplayMode(.inline)
            }
       
        }
        
        
    }


#Preview {
    SettingView()
}
