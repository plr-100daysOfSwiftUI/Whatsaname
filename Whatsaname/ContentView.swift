//
//  ContentView.swift
//  Whatsaname
//
//  Created by Paul Richardson on 11.10.2020.
//

import SwiftUI

struct ContentView: View {
	
	@State private var image: Image?
	@State private var name: String = ""
	
	@State private var showingImagePicker = false
	@State private var inputImage: UIImage?
	
	var body: some View {
		
		NavigationView {
			VStack {
				ZStack {
					Rectangle()
						.fill(Color.secondary)
					
					if image != nil {
						image?
							.resizable()
							.scaledToFit()
					} else {
						Text("Tap to select a picture")
							.foregroundColor(.white)
							.font(.headline)
					}
				}
				.onTapGesture {
					// select an image
					self.showingImagePicker = true
				}
				HStack {
					TextField("Name", text: $name)
				}
				HStack {
					Spacer()
					Button("Save") {
						// save the data
					}
				}
			}
			.padding([.horizontal, .bottom])
			.navigationBarTitle("Whatsaname")
			.sheet(isPresented: $showingImagePicker) {
				ImagePicker(image: $inputImage)
			}
		}

	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
