//
//  AuthorizationView.swift
//  MusicPlayer
//
//  Created by USER on 2022/11/05.
//

import MediaPlayer
import SwiftUI

struct AuthorizaionView: View {
    @Binding var authorizationStatus: MPMediaLibraryAuthorizationStatus
    
    var body: some View {
        Text("Authorizaion")
    }
    
    class PresentationCoordinator: ObservableObject {
        static let shared = PresentationCoordinator()
        
        @Published var authorizationStatus: MPMediaLibraryAuthorizationStatus {
            didSet {
                isAuthorizationViewPresented = (authorizationStatus != .authorized)
            }
        }
        
        @Published var isAuthorizationViewPresented: Bool
        
        private init() {
            let authorizationStatus = MPMediaLibrary.authorizationStatus()
            self.authorizationStatus = authorizationStatus
            isAuthorizationViewPresented = (authorizationStatus != .authorized)
        }
    }
    
    fileprivate struct SheetModifier: ViewModifier {
        @StateObject private var coordinator = PresentationCoordinator.shared
        
        func body(content: Content) -> some View {
            content
                .sheet(isPresented: $coordinator.isAuthorizationViewPresented) {
                    AuthorizaionView(authorizationStatus: $coordinator.authorizationStatus)
                }
        }
    }
}

extension View {
    func AuthorizaionViewSheet() -> some View {
        modifier(AuthorizaionView.SheetModifier())
    }
}
