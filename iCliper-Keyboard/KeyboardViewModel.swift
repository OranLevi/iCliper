//
//  KeyboardViewModel.swift
//  iCliper-Keyboard
//
//  Created by Oran Levi on 26/11/2023.
//

import SwiftUI
import SwiftData
import Combine

class KeyboardViewModel: ObservableObject {
    
    @Published var isNoTextCopied: Bool = false {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                self.isNoTextCopied = false
            }
        }
    }
    
    private let service = Service.shared
    private let swiftDataManager = SwiftDataManager.shared
    
    func gettingCopied(items: [CopiedData], context: ModelContext) {
        let pasted = UIPasteboard.general.string
        if items.contains(where: { $0.text == pasted }) {
            return
        } else {
            if let textPasted = pasted {
                service.gettingCopied(context: context,text: textPasted)
            }
        }
    }
    
    func addCopiedButton(context: ModelContext){
        let pasted = UIPasteboard.general.string
        if let textPasted = pasted {
            service.gettingCopied(context: context,text: textPasted)
        } else {
            isNoTextCopied = true
        }
    }
    
    func isOpenAccessGranted() -> Bool {
        let inputVC = UIInputViewController()
        return inputVC.hasFullAccess
    }
}
