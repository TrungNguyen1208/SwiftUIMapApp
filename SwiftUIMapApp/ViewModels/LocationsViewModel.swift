//
//  LocationsViewModel.swift
//  SwiftUIMapApp
//
//  Created by Trung Nguyen on 14/07/2023.
//

import Foundation
import MapKit
import SwiftUI

final class LocationsViewModel: ObservableObject {
  @Published var locations: [Location]
  
  @Published var mapLocation: Location {
    didSet {
      updateMapRegion(location: mapLocation)
    }
  }
  
  // Show list of locations
  @Published var showLocationList: Bool = false
  
  @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
  
  let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
  
  
  init() {
    let locations = LocationsDataService.locations
    self.locations = locations
    self.mapLocation = locations.first!
    self.updateMapRegion(location: locations.first!)
  }
  
  func toogleLocationsList() {
    withAnimation(.easeInOut) {
      showLocationList.toggle()
    }
  }
  
  func showLocation(_ location: Location) {
    withAnimation(.easeInOut) {
      mapLocation = location
      showLocationList = false
    }
  }
}

private extension LocationsViewModel {
  func updateMapRegion(location: Location) {
    withAnimation(.easeInOut) {
      mapRegion = MKCoordinateRegion(
        center: location.coordinates,
        span: mapSpan
      )
    }
  }
}
