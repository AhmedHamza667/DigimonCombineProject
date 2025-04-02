//
//  CellView.swift
//  CombineAPI
//
//  Created by Ahmed Hamza on 3/4/25.
//

import SwiftUI

struct CellView: View {
    //@StateObject var digimonVM = DigimonViewModel(apiManager: APIServiceManager(), coreDataManager: CoreDataManager())
    var digimon: Digimon
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(digimon.name)
                    .font(.largeTitle)
                    .fontWeight(.medium)
                
                Text(digimon.level)
                    .font(.body)
                    .foregroundStyle(digimon.level == "Rookie" ? .red : digimon.level == "Champion" ? .green : digimon.level == "Ultimate" ? .blue : .gray)
            }
            Spacer()
            if let imageURL = URL(string: digimon.img){
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .frame(width: 100, height: 100)
                } placeholder: {
                    ProgressView()
                        .frame(width: 100, height: 100)
                }
                
            }
        }
    }
}

#Preview {
    CellView(digimon: Digimon(name: "Name Placeholder", level: "desc", img: "https://digimon.shadowsmith.com/img/biyomon.jpg"))
}
