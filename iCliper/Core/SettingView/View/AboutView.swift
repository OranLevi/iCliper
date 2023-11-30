//
//  AboutView.swift
//  iCliper
//
//  Created by Oran Levi on 28/11/2023.
//

import SwiftUI

struct AboutView: View {
    
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 20) {
                Image("iCliperapp")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                
                Text("iCliper")
                    .font(.title)
                    .fontWeight(.bold)
                
                HStack{
                    Text("\(String(localized: "AboutView_Version"))")
                    Text("\(appVersion ?? "")")
                }
                .font(.headline)
                .foregroundColor(.gray)
                
                Text("\(String(localized: "AboutView_Description"))")
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
                
                
            }
            .padding()
            .navigationBarTitle(String(localized: "AboutView_AboutTitle"), displayMode: .inline)
        }
        
    }
}

#Preview {
    AboutView()
}
