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
  
  private let maxWidthForIpad: CGFloat = 700
  
  var body: some View {
    ZStack {
      mapLayer

      VStack(spacing: 0) {
        header
          .padding()
          .frame(maxWidth: maxWidthForIpad)
        Spacer()
        locationsPreviewStack
      }
    }
    .sheet(item: $viewModel.sheetLocation) { location in
      LocationDetailView(location: location)
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
  var mapLayer: some View {
    Map(coordinateRegion: $viewModel.mapRegion,
        annotationItems: viewModel.locations,
        annotationContent: { location in
      MapAnnotation(coordinate: location.coordinates) {
        LocationMapAnnotionView()
          .scaleEffect(viewModel.mapLocation == location ? 1 : 0.7)
          .shadow(radius: 10)
          .onTapGesture {
            viewModel.showLocation(location)
          }
      }
    })
    .ignoresSafeArea()
  }
  
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
    .background(.thickMaterial)
    .cornerRadius(10)
    .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 15)
  }
  
  var locationsPreviewStack: some View {
    ZStack {
      ForEach(viewModel.locations) { location in
        if viewModel.mapLocation == location {
          LocationPreviewView(location: location)
            .shadow(
              color: Color.black.opacity(0.3),
              radius: 20
            )
            .padding()
            .frame(maxWidth: maxWidthForIpad)
            .frame(maxWidth: .infinity)
            .transition(.asymmetric(
              insertion: .move(edge: .trailing),
              removal: .move(edge: .leading))
            )
        }
      }
    }
  }
}
