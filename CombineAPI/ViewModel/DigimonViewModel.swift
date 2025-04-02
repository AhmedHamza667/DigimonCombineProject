//
//  DigimonViewModel.swift
//  CombineAPI
//
//  Created by Ahmed Hamza on 3/3/25.


import Foundation
import Combine


enum DigimonViewState{
    case loading
    case loaded([Digimon])
    case error(Error)
}
class DigimonViewModel: ObservableObject{
    @Published var digimonList: [Digimon] = []
    @Published private var originalDigimonList: [Digimon] = []
    @Published var favs: [Digimon] = []
    @Published var digimonViewState: DigimonViewState = .loading
    @Published var searchText: String = ""
    @Published var filterByLevel: String = ""
    private var cancelable = Set<AnyCancellable>()
    private var coreDataManager: CoreDataManagerActions
    let apiManager: APIServicing
    
    
    init(apiManager: APIServicing, coreDataManager: CoreDataManagerActions) {
        self.apiManager = apiManager
        self.coreDataManager = coreDataManager
        setUpSearch()
        setUpFilterByLevel()
    }
    func setUpSearch(){
        $searchText
            .removeDuplicates()
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink { search in
                Task{
                    await self.filterDigimon(filterText: search)
                }
            }.store(in: &cancelable)
    }
    
    func filterDigimon(filterText: String) async {
        if filterText.isEmpty{
            DispatchQueue.main.async{
                self.digimonList = self.originalDigimonList
            }
        } else{
            DispatchQueue.main.async{
                
                self.digimonList = self.originalDigimonList.filter{
                    $0.name.lowercased().contains(filterText.lowercased())
                }
            }
            
        }
    }
    func setUpFilterByLevel(){
        $filterByLevel
            .removeDuplicates()
            .sink { filter in
                Task{
                    await self.filterDigimonByLevel(level: filter)
                }
            }.store(in: &cancelable)
    }
    func filterDigimonByLevel(level: String) async {
        if level.isEmpty{
            DispatchQueue.main.async{
                self.digimonList = self.originalDigimonList
            }
        } else{
            DispatchQueue.main.async{
                self.digimonList = self.originalDigimonList.filter{
                    $0.level == level
                }
            }
            
        }
    }
    
    
    func toggleFav(_ digimon: Digimon) {
        if let index = favs.firstIndex(where: { $0.name == digimon.name }) {
            favs.remove(at: index)
        } else {
            favs.append(digimon)
        }
        print(favs)
    }
    
    private func getSqlitePath() {
        guard let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else { return }
        let path = url.appendingPathComponent("DigimonStorage")
        print(path)
    }
    @MainActor
    func loadDigimonFromDatabase() {
        Task {
            do {
                let data = try await coreDataManager.getDataFromDatabase()
                    self.digimonList = data
                    self.digimonViewState = .loaded(data)
                
            } catch {
                    self.digimonViewState = .error(error)
                
            }
        }
    }

    
    func getDigimon(){
        self.apiManager.fetchData(from: APIConstants.digimonEndPoint, modelType: [Digimon].self)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    
                case .finished:
                    print("Task is finished")
                case .failure(let error):
                    switch error{
                        
                    default:
                        print(error.localizedDescription)
                        self.digimonViewState = .error(error)
                        
                    }
                }
            } receiveValue: { [weak self] digimons in
                self?.digimonList = digimons
                self?.originalDigimonList = digimons
                self?.digimonViewState = .loaded(digimons)
                Task{
                    do {
                        try await self?.coreDataManager.saveDataIntoDatabase(digimonList: digimons)
                        self?.getSqlitePath()
                    } catch {
                        print("Failed to save data: \(error.localizedDescription)")
                    }
                }
            }
            .store(in: &cancelable)
        
    }
}
