//
//  FavoritesView.swift
//  CombineAPI
//
//  Created by Ahmed Hamza on 3/4/25.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var digimonVM: DigimonViewModel

    var body: some View {
        VStack{
            if digimonVM.favs.isEmpty {
                VStack(spacing: 20) {
                    Image(systemName: "heart.slash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray.opacity(0.5))
                    
                    Text("No Favorites Yet!")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .padding()
                    
                    Text("Add some Digimon to your favorites")
                        .font(.body)
                        .foregroundColor(.gray)
                }
                .padding()
            } else {
                let col = [GridItem(), GridItem(), GridItem()]
                ScrollView {
                    LazyVGrid(columns: col) {
                        ForEach(digimonVM.favs) { digimon in
                            ZStack {
                                Color.brown.opacity(0.2)
                                VStack(alignment: .leading) {
                                    if let imageURL = URL(string: digimon.img) {
                                        AsyncImage(url: imageURL) { image in
                                            image
                                                .resizable()
                                                .frame(width: 100, height: 100)
                                                .scaledToFit()
                                        } placeholder: {
                                            ProgressView()
                                                .frame(width: 100, height: 100)
                                        }
                                    }
                                    Text(digimon.name)
                                        .font(.body)
                                        .fontWeight(.medium)

                                    Text(digimon.level)
                                        .font(.caption)
                                        .foregroundStyle(digimon.level == "Rookie" ? .red : digimon.level == "Champion" ? .green : digimon.level == "Ultimate" ? .blue : .gray)
                                }
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
                .navigationTitle("Favorites")
            }
        }
    }
}

#Preview {
    FavoritesView().environmentObject(DigimonViewModel(apiManager: APIServiceManager(), coreDataManager: CoreDataManager()))
}
