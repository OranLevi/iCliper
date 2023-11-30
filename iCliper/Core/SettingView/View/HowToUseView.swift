//
//  HowToUseView.swift
//  iCliper
//
//  Created by Oran Levi on 28/11/2023.
//

import SwiftUI
import AVKit

struct HowToUseView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var vm = HowToUseViewModel()
    
    @State private var tabSelection: Int = 1
    @State private var numberSteps:Int = 4
    
    var body: some View {
        VStack {
            TabView(selection: $tabSelection){
                stepOne
                    .tabItem {
                        Text("Step One")
                    }.tag(1)
                stepTwo
                    .tabItem {
                        Text("Step Two")
                    }.tag(2)
                stepThree
                    .tabItem {
                        Text("Step Three")
                    }.tag(3)
                stepFour
                    .tabItem {
                        Text("Step Four")
                    }.tag(4)
                finalSteps
                    .tabItem {
                        Text("final steps")
                    }.tag(5)
            }      .padding()
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
    
    
}

#Preview {
    HowToUseView()
}

extension HowToUseView {
    
    private var stepOne: some View {
        VStack{
            Spacer()
            
            
            HStack(spacing:4){
                Text(" \(String(localized: "HowToUseView_Step"))")
                Text("\(tabSelection)")
                Text(" \(String(localized: "HowToUseView_StepOf"))")
                Text("\(numberSteps)")
            }
            .font(.title)
            .fontWeight(.bold)
            .padding()
            Text("\(String(localized: "HowToUseView_Step1_Text1"))")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()
            
            Image("iCliperapp")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .padding()
            
            Text("\(String(localized: "HowToUseView_Step1_Text2"))")
            Text("\(String(localized: "HowToUseView_Step1_Text3"))")
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Button(action: {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
                tabSelection = 2
            }) {
                Text("\(String(localized: "HowToUseView_Step1_Button"))")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
    }
    
    private var stepTwo: some View {
        VStack{
            Spacer()
            
            HStack(spacing:4){
                Text(" \(String(localized: "HowToUseView_Step"))")
                Text("\(tabSelection)")
                Text(" \(String(localized: "HowToUseView_StepOf"))")
                Text("\(numberSteps)")
            }
            .font(.title)
            .fontWeight(.bold)
            .padding()
            
            Text("\(String(localized: "HowToUseView_Step2_Text1"))")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()
            
            Image("Keyboards\(vm.currentLanguage)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .padding()
            
            Spacer()
            Button(action: {
                tabSelection = 3
            }) {
                Text("\(String(localized: "HowToUseView_Step2_ButtonNext"))")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
    }
    
    private var stepThree: some View {
        VStack{
            Spacer()
            HStack(spacing:4){
                Text(" \(String(localized: "HowToUseView_Step"))")
                Text("\(tabSelection)")
                Text(" \(String(localized: "HowToUseView_StepOf"))")
                Text("\(numberSteps)")
            }
            
            .font(.title)
            .fontWeight(.bold)
            .padding()
            Text("\(String(localized: "HowToUseView_Step3_Text1"))")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()
            
            Image("FullAccess\(vm.currentLanguage)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .padding()
            Spacer()
            Button(action: {
                tabSelection = 4
            }) {
                Text("\(String(localized: "HowToUseView_Step3_ButtonNext"))")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
    }
    
    private var stepFour: some View {
        VStack{
            Spacer()
            HStack(spacing:4){
                Text(" \(String(localized: "HowToUseView_Step"))")
                Text("\(tabSelection)")
                Text(" \(String(localized: "HowToUseView_StepOf"))")
                Text("\(numberSteps)")
            }
            .font(.title)
            .fontWeight(.bold)
            .padding()
            Text("\(String(localized: "HowToUseView_Step4_Text1"))")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()
            
            Image("PasteOtherApp\(vm.currentLanguage)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .padding()
            
            
            Spacer()
            Button(action: {
                tabSelection = 5
            }) {
                Text("\(String(localized: "HowToUseView_Step4_ButtonNext"))")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
    }
    
    private var finalSteps: some View {
        VStack{
            Spacer()
            Text("\(String(localized: "HowToUseView_FinalSteps_Text1"))")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            
            Text("\(String(localized: "HowToUseView_FinalSteps_Text2"))")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()
            
            
            if let videoURL = Bundle.main.url(forResource: "ShowKeyboard\(vm.currentLanguage)", withExtension: "mp4") {
                let player = AVPlayer(url: videoURL)
                let videoPlayer = VideoPlayer(player: player)
                videoPlayer
                    .onTapGesture {
                        player.play()
                    }
                    .frame(height: 250, alignment: .center)
                    .onAppear() {
                        player.play()
                    }
                    .onDisappear() {
                        player.pause()
                    }
            } else {
                Text("Error: Unable to find the video file.")
            }
            
            Button(action: {
                
                dismiss()
                
            }) {
                Text("\(String(localized: "HowToUseView_FinalSteps_ButtonDone"))")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
            Spacer()
        }
    }
}
