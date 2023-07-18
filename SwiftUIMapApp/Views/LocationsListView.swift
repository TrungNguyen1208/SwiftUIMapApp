//
//  LocationsListView.swift
//  SwiftUIMapApp
//
//  Created by Trung Nguyen on 14/07/2023.
//

import SwiftUI

struct LocationsListView: View {
  
  @EnvironmentObject private var viewModel: LocationsViewModel
  
  var body: some View {
    List {
      ForEach(viewModel.locations) { location in
        Button {
          viewModel.showLocation(location)
        } label: {
          buildListRowView(location)
        }
        .padding(.vertical, 4)
        .listRowBackground(Color.clear)
      }
    }
    .listStyle(PlainListStyle())
  }
}

struct LocationsListView_Previews: PreviewProvider {
  static var previews: some View {
    LocationsListView()
      .environmentObject(LocationsViewModel())
  }
}

private extension LocationsListView {
  func buildListRowView(_ location: Location) -> some View {
    HStack {
      if let imageName = location.imageNames.first {
        Image(imageName)
          .resizable()
          .scaledToFill()
          .frame(width: 45, height: 45)
          .cornerRadius(10)
      }
      
      VStack(alignment: .leading) {
        Text(location.name)
          .font(.headline)
        Text(location.cityName)
          .font(.subheadline)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
  }
}
