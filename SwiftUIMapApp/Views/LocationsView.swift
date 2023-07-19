//
//  LocationView.swift
//  SwiftUIMapApp
//
//  Created by Trung Nguyen on 20/03/2023.
//

import SwiftUI
import MapKit

struct LocationsView: View {
  
  @EnvironmentObject private var viewModel: LocationsViewModel
  
  var body: some View {
    ZStack {
      Map(coordinateRegion: $viewModel.mapRegion)
        .ignoresSafeArea()
      
      VStack(spacing: 0) {
        header
          .padding()
        
        Spacer()
        
        ZStack {
          ForEach(viewModel.locations) { location in
            if viewModel.mapLocation == location {
              LocationPreviewView(location: location)
                .shadow(
                  color: Color.black.opacity(0.3),
                  radius: 20
                )
                .padding()
                .transition(.asymmetric(
                  insertion: .move(edge: .trailing),
                  removal: .move(edge: .leading))
                )
            }
          }
        }
      }
    }
  }
}

struct LocationsView_Previews: PreviewProvider {
  static var previews: some View {
    LocationsView()
      .environmentObject(LocationsViewModel())
  }
}

private extension LocationsView {
  var header: some View {
    VStack(spacing: 0) {
      Button(action: viewModel.toogleLocationsList) {
        Text(viewModel.mapLocation.name + ", " + viewModel.mapLocation.cityName)
          .font(.title2)
          .fontWeight(.black)
          .foregroundColor(.primary)
          .frame(height: 55)
          .frame(maxWidth: .infinity)
          .animation(.none, value: viewModel.mapLocation)
          .background(Color.white)
          .overlay(alignment: .leading) {
            Image(systemName: "arrow.down")
              .font(.headline)
              .foregroundColor(.primary)
              .padding()
              .rotationEffect(Angle(degrees: viewModel.showLocationList ? 180 : 0))
        }
      }
      
      if viewModel.showLocationList {
        LocationsListView()
          .background(Color.white)
      }
    }
    .backgroundStyle(.thickMaterial)
    .cornerRadius(10)
    .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 15)
  }
}
