//
//  ContentView.swift
//  Whatsaname
//
//  Created by Paul Richardson on 11.10.2020.
//

import SwiftUI

struct ContentView: View {
	
	@State private var image: Image?
	@State private var firstName: String = ""
	@State private var lastName: String = ""
	
	@State private var showingImagePicker = false
	@State private var inputImage: UIImage?
	@State private var contacts: [Contact] = ContactSaver.decodeContacts()
	
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
				VStack {
					TextField("First Name", text: $firstName)
					TextField("Last Name", text: $lastName)
				}
				HStack {
					Spacer()
					Button("Save") {
						guard let _ = self.image else { return }
						guard !firstName.isEmpty && !lastName.isEmpty else { return }
						
						// save the data
						let contactSaver = ContactSaver()
						contactSaver.saveContact(image: inputImage!, firstName: firstName, lastName: lastName)
						contacts = ContactSaver.decodeContacts()
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
