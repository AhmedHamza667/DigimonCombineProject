//
//  ProfileView.swift
//  CombineAPI
//
//  Created by Ahmed Hamza on 3/5/25.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack{
            Text("Profile")
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    Text("Name")
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                        .frame(width: geometry.size.width * 0.33)
                        .background(.green)
                    Text("Email")
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                        .frame(width: geometry.size.width * 0.67)
                        .background(.red)
                }
            }
            .frame(height: 50)
        }
    }
}

#Preview {
    ProfileView()
}
