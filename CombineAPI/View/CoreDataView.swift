//
//  CoreDataView.swift
//  CombineAPI
//
//  Created by Ahmed Hamza on 3/10/25.
//

import SwiftUI
import CoreData

struct CoreDataView: View {
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
            .onAppear {
                digimonVM.loadDigimonFromDatabase()
            }
            .searchable(text: $digimonVM.searchText, prompt: "Search for Digimon")
        }
    }
    @ViewBuilder func showDigionList()-> some View{
        List (digimonVM.digimonList){ digimon in
            CellView(digimon: Digimon(name: digimon.name, level: digimon.level, img: digimon.img))
            
        }
    }
}

#Preview {
    CoreDataView().environmentObject(DigimonViewModel(apiManager: APIServiceManager(), coreDataManager: CoreDataManager()))
}
