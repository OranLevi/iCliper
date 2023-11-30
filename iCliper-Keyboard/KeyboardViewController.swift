//
//  KeyboardViewController.swift
//  iCliper-Keyboard
//
//  Created by Oran Levi on 26/11/2023.
//

import UIKit
import SwiftUI
import SwiftData

class KeyboardViewController: UIInputViewController,ObservableObject {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }

    func insertText(text: String){
        self.textDocumentProxy.insertText(text)
    }
    
    func setupView(){
        let keyboardView = UIHostingController(rootView: KeyboardView(keyboardViewController: self).modelContainer(sharedModelContainer))
        addChild(keyboardView)
        view.addSubview(keyboardView.view)

        keyboardView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            keyboardView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardView.view.topAnchor.constraint(equalTo: view.topAnchor),
            keyboardView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        keyboardView.didMove(toParent: self)
    }
    

}

