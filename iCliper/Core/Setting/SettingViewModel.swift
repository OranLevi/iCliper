//
//  SettingViewModel.swift
//  iCliper
//
//  Created by Oran Levi on 27/11/2023.
//

import SwiftUI
import SwiftData

class SettingViewModel: ObservableObject {
    
    func deleteAll(context: ModelContext){
        do {
            try context.delete(model: CopiedData.self)
        } catch {
            print("Failed to clear all Country and City data.")
        }
    }
    
    func actionSheet() {
        let shareText = String(localized: "SettingViewModel_ShareText")
        let av = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)

        // Get the topmost view controller from the current scene
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let topViewController = windowScene.windows.first?.rootViewController {
                var currentViewController = topViewController
                while let presentedViewController = currentViewController.presentedViewController {
                    currentViewController = presentedViewController
                }
                
                // Set the source view for the popover presentation
                if let popoverController = av.popoverPresentationController {
                    popoverController.sourceView = currentViewController.view
                    popoverController.sourceRect = CGRect(x: currentViewController.view.bounds.midX, y: currentViewController.view.bounds.midY, width: 0, height: 0)
                }
                
                // Once the topmost view controller is found, present the new one
                currentViewController.present(av, animated: true, completion: nil)
            }
        }
    }
}
