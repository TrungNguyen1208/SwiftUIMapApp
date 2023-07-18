//
//  SwiftUIMapApp.swift
//  SwiftUIMapApp
//
//  Created by Trung Nguyen on 20/03/2023.
//

import SwiftUI

@main
struct SwiftUIMapApp: App {
  
  @StateObject private var locationViewModel = LocationsViewModel()
  
  var body: some Scene {
    WindowGroup {
      LocationsView()
        .environmentObject(locationViewModel)
    }
  }
}
