//
//  LocationDetailView.swift
//  SwiftUIMapApp
//
//  Created by Trung Nguyen on 19/07/2023.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
  
  @EnvironmentObject private var viewModel: LocationsViewModel
  
  let location: Location
  
  var body: some View {
    ScrollView {
      VStack {
        imageSection
          .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
        
        VStack(alignment: .leading, spacing: 16.0) {
          titleSection
          Divider()
          descriptionSection
          Divider()
          mapLayer
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
      }
    }
    .ignoresSafeArea()
    .background(.ultraThinMaterial)
    .overlay(backButton, alignment: .topLeading)
  }
}

struct LocationDetailView_Previews: PreviewProvider {
  static var previews: some View {
    LocationDetailView(location: LocationsDataService.locations.first!)
      .environmentObject(LocationsViewModel())
  }
}

private extension LocationDetailView {
  var imageSection: some View {
    TabView {
      ForEach(location.imageNames, id: \.self) {
        Image($0)
          .resizable()
          .scaledToFill()
          .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
          .clipped()
      }
    }
    .frame(height: 500)
    .tabViewStyle(PageTabViewStyle())
  }
  
  var titleSection: some View {
    VStack(alignment: .leading, spacing: 8.0) {
      Text(location.name)
        .font(.largeTitle)
        .fontWeight(.semibold)
      Text(location.cityName)
        .font(.title3)
        .foregroundColor(.secondary)
    }
  }
  
  var descriptionSection: some View {
    VStack(alignment: .leading, spacing: 16.0) {
      Text(location.description)
        .font(.subheadline)
      
      if let url = URL(string: location.link) {
        Link("Read more on Wikipedia", destination: url)
          .font(.headline)
          .tint(.blue)
      }
    }
  }
  
  var mapLayer: some View {
    Map(coordinateRegion: .constant(
      MKCoordinateRegion(
        center: location.coordinates,
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))),
        annotationItems: [location]
    ) { location in
      MapAnnotation(coordinate: location.coordinates) {
        LocationMapAnnotionView()
          .shadow(radius: 10)
      }
    }
    .allowsHitTesting(false)
    .aspectRatio(1, contentMode: .fit)
    .cornerRadius(30)
  }
  
  var backButton: some View {
    Button {
      viewModel.sheetLocation = nil
    } label: {
      Image(systemName: "xmark")
        .font(.headline)
        .padding(16)
        .foregroundColor(.primary)
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(radius: 4)
        .padding()
    }
  }
}
