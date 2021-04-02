//
//  LocationViewModel.swift
//  MosesAyankoya
//
//  Created by Moses on 08/11/2018.
//  Copyright © 2018 Moses Ayankoya. All rights reserved.
//

import Foundation

protocol ILocationsViewModel {
    var remoteRepository : ILocationRemoteRepository! { get set }
    var annotations : [Annotation] { get }
    mutating func fetchCars(map toCity: Bool, request: LocationRequest, render: @escaping ((StateModel<List<Location>>) -> Void) )
}

struct DataListViewModel : ILocationsViewModel {
    fileprivate static var _annotations = [Annotation]()
    var remoteRepository : ILocationRemoteRepository!
    var annotations: [Annotation] {
        return DataListViewModel._annotations
    }
    
    mutating func fetchCars(map toCity: Bool, request: LocationRequest, render: @escaping ((StateModel<List<Location>>) -> Void)) {
        
        // loader view should start animating
        let initialState : State<List<Location>> = State.loading
        let initialStateModel = StateModel<List<Location>>.init(state: initialState)
        render(initialStateModel)
        
        remoteRepository.fetchCars(request: request) { (response) in
            
            switch response {
                
                case .error(let errorMessage):
                    
                    let state : State<List<Location>> = State.error(errorMessage)
                    let stateModel = StateModel<List<Location>>.init(state: state)
                    render(stateModel)
                    
                    break
                
                case .success(let message, let locations):
                    
                    if toCity {
                        LocationUtil.mapToCoties(locations: locations, handler: { (modifiedLocations) in
                            let stateModel = DataListViewModel.getSuccessFinalStateModel(locations: modifiedLocations, message: message)
                            render(stateModel)
                        })
                    } else {
                        let stateModel = DataListViewModel.getSuccessFinalStateModel(locations: locations, message: message)
                        render(stateModel)
                    }
                    break
            }
            
            
        }
    }
}

extension DataListViewModel {
    
    fileprivate static func getSuccessFinalStateModel(locations: [Location] , message: String) -> StateModel<List<Location>> {
        
        _annotations = locations.compactMap({ location in
            let coordinate = CLLocationCoordinate2D.init(latitude: location.coordinate!.latitude, longitude: location.coordinate!.longitude)
           return Annotation.init(coordinate: coordinate, icon: location.fleetType.lowercased())
        })
        
        let list = List<Location>.init(list: locations)
        let state : State<List<Location>> = State.dataLoaded(list, message)
        return StateModel<List<Location>>.init(state: state)
    }
}

