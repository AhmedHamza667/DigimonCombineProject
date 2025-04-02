//
//  ContentView.swift
//  CombineAPI
//
//  Created by Ahmed Hamza on 3/3/25.
//

import SwiftUI

struct DigimonListView: View {
//    @StateObject var digimonVM = DigimonViewModel(apiManager: APIServiceManager())
    
    @EnvironmentObject var digimonVM: DigimonViewModel

    var body: some View {
        NavigationStack{
            VStack {
                HStack(spacing: 15){
                    Button {
                        digimonVM.filterByLevel = ""
                    } label: {
                        Text("All")
                            .font(.body)
                            .foregroundStyle(.black)
                    }
                    Button {
                        digimonVM.filterByLevel = "Ultimate"
                    } label: {
                        Text("Ultimate")
                            .font(.body)
                            .foregroundStyle(.blue)
                    }
                    Button {
                        digimonVM.filterByLevel = "Champion"
                    } label: {
                        Text("Champion")
                            .foregroundStyle(.green)
                    }
                    Button {
                        digimonVM.filterByLevel = "Rookie"
                    } label: {
                        Text("Rookie")
                            .foregroundStyle(.red)
                    }
                    Button {
                        digimonVM.filterByLevel = "In Training"
                    } label: {
                        Text("In Training")
                            .foregroundStyle(.gray)
                    }
                }
                HStack(spacing: 15){
                    NavigationLink {
                        FavoritesView()
                    } label: {
                        Text("Favorites")
                            .font(.body)
                            .foregroundStyle(.red)
                    }
                    
                    NavigationLink {
                        CoreDataView()
                    } label: {
                        Text("Core Data")
                            .font(.body)
                            .foregroundStyle(.green)
                        Image(systemName: "arrow.down.square")
                            .font(.body)
                            .foregroundStyle(.green)

                    }
                }
                switch digimonVM.digimonViewState{
                case .loading:
                    ProgressView()
                case .loaded(let digionList):
                    showDigionList()

                    
                case .error(let error):
                    Text("Error: \(error)")
                        .font(.body)
                        .foregroundStyle(.red)
                }
            }
            .task{
                digimonVM.getDigimon()
            }

            .searchable(text: $digimonVM.searchText, prompt: "Search for Digimon")
        }
    }
    @ViewBuilder func showDigionList()-> some View{
        List (digimonVM.digimonList){ digimon in
            CellView(digimon: digimon)
                .overlay(alignment: .topTrailing) {
                    Button {
                        withAnimation(.easeInOut(duration: 0.3)){
                            digimonVM.toggleFav(digimon)
                        }
                    } label: {
                        Image(systemName: digimonVM.favs.contains(where: {$0.name == digimon.name}) ? "heart.fill" : "heart")
                            .font(.body)
                            .foregroundStyle(.green)
                            .shadow(radius: 10)
                            .padding(5)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.black)
                                    .foregroundStyle(Color.white)
                            }
                    }


                }
          
        }
    }
}

#Preview {
    DigimonListView().environmentObject(DigimonViewModel(apiManager: APIServiceManager(), coreDataManager: CoreDataManager()))
}
