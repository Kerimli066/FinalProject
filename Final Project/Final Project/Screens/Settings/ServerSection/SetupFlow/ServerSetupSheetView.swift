//
//  ServerSetupSheetView.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//
import SwiftUI

struct ServerSetupSheetView: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: Context) -> ServerSetupViewController {
        let vc = ServerSetupViewController()
        vc.onComplete = { isPresented = false }
        return vc
    }

    func updateUIViewController(_ uiViewController: ServerSetupViewController, context: Context) {}
}
