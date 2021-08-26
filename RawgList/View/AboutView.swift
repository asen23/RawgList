//
//  AboutView.swift
//  RawgList
//
//  Created by IT-Mobile-Dev on 18/08/21.
//

import SwiftUI

struct AboutView: View {
    @State private var isEditing = false
    @State private var name = UserDefaults.standard.string(forKey: "name") ?? "Andersen"
    @State private var email = UserDefaults.standard.string(forKey: "email") ?? "andersenlim23@gmail.com"
    var body: some View {
        VStack {
            Image("profile")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .clipShape(Circle())
            if isEditing {
                TextField("Name...", text: $name)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.black, lineWidth: 1)
                    )
                TextField("Email...", text: $email)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.black, lineWidth: 1)
                    )
            } else {
                Text(name)
                    .font(.title)
                Text(email)
                    .font(.title2)
            }
        }
        .padding(.horizontal, 32)
        .navigationTitle("About")
        .toolbar {
            if isEditing {
                Button(action: {
                    isEditing.toggle()
                    if !name.isEmpty {
                        UserDefaults.standard.set(name, forKey: "name")
                    }
                    if !email.isEmpty {
                        UserDefaults.standard.set(email, forKey: "email")
                    }
                }) {
                    Image(systemName: "checkmark.circle")
                }
            } else {
                Button(action: { isEditing.toggle() }) {
                    Image(systemName: "pencil.circle")
                }
            }
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
