//
//  EnvView.swift
//  CombineAPI
//
//  Created by Ahmed Hamza on 3/3/25.
//

import SwiftUI

struct EnvView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    var body: some View {
        ZStack{
            Color(colorScheme == .light ? .brown : .black)
                .ignoresSafeArea(.all)
            VStack{
                HStack{
                    Button(action: {
                        dismiss()
                        
                    })
                    {
                        Image(systemName: "arrow.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                            .padding(.leading, 20)
                            .foregroundStyle(colorScheme == .light ? .black : .white)
                    }
                    Spacer()
                }
                Spacer()
                Text(colorScheme == .light ? "Light mode!" : "Dark mode!")
                    .foregroundStyle(colorScheme == .light ? .white : .red)
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    EnvView()
}
