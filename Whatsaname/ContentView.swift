//
//  ContentView.swift
//  Whatsaname
//
//  Created by Paul Richardson on 11.10.2020.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
	
	@State private var image: Image?
	@State private var firstName: String = ""
	@State private var lastName: String = ""
	@State private var locationName: String = ""
	
	@State private var showingImagePicker = false
	@State private var inputImage: UIImage?
	
	/*
	TODO: the contacts array must be updated after saving
	*/
	
	@State private var contacts = ContactSaver.decodeContacts()
		
	let locationFetcher = LocationFetcher()
	
	var body: some View {
		
		NavigationView {
			VStack(spacing: 20.0) {
				ZStack {
					Rectangle()
						.fill(Color.secondary)
					
					if image != nil {
						image?
							.resizable()
							.aspectRatio(inputImage!.size, contentMode: .fit)
						//							.scaledToFit()
					} else {
						Text("Tap to make a picture")
							.foregroundColor(.white)
							.font(.headline)
					}
				}
				.onTapGesture {
					// start location tracking
					self.locationFetcher.start()
					// select an image
					self.showingImagePicker = true
				}
				VStack(spacing: 20.0) {
					TextField("First Name", text: $firstName)
					TextField("Last Name", text: $lastName)
					TextField("Location", text: $locationName)
				}
				.textFieldStyle(RoundedBorderTextFieldStyle())
				HStack {
					Spacer()
					Button("Save") {
						guard let _ = self.image else { return }
						guard !firstName.isEmpty && !lastName.isEmpty && !locationName.isEmpty else { return }
						
						// save the data
						let contactSaver = ContactSaver()
						let location = locationFetcher.lastKnownLocation
						let latitude = location?.latitude ?? 0.0
						let longitude = location?.longitude ?? 0.0
						contactSaver.saveContact(image: inputImage!, firstName: firstName, lastName: lastName, latitude: latitude, longitude: longitude, locationName: locationName)
						
						// TODO: alert the user and clear the image and text fields
						
					}
				}
			}
			.padding([.horizontal, .bottom])
			.navigationBarTitle("Whatsaname")
			.navigationBarItems(trailing: NavigationLink(
														destination: ListView(contacts: contacts),
														label: {
															Image(systemName: "list.dash")
														})
			)
			.sheet(isPresented: $showingImagePicker, onDismiss: (loadImage)) {
				ImagePicker(image: $inputImage)
			}
		}
		
	}
	
	func loadImage() {
		guard let inputImage = inputImage else { return }
		image = Image(uiImage: inputImage)
	}
	
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
