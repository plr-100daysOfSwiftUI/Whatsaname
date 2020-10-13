//
//  DetailView.swift
//  Whatsaname
//
//  Created by Paul Richardson on 12.10.2020.
//

import SwiftUI

struct DetailView: View {
	
	var contact: Contact
	var imageUrl: URL
	var uiImage: UIImage? {
		guard let data = try? Data(contentsOf: imageUrl) else { return nil }
		guard let uiImage = UIImage(data: data) else { return nil }
		return uiImage
	}
	
	var body: some View {
		VStack {
			Image(uiImage: uiImage!)
				.resizable()
				.scaledToFit()
			NavigationLink(destination: MapView(latitude: contact.latitude, longitude: contact.longitude, locationName: contact.locationName)) {
				Text("Made contact at \(contact.locationName)")
			}
			.padding()
		}
		.navigationBarTitle(Text("\(contact.firstName) \(contact.lastName)"))
		.padding()
	}
}

//struct DetailView_Previews: PreviewProvider {
//	static var previews: some View {
//		let contact = Contact(id: UUID(), firstName: "Foo", lastName: "Bar")
//		DetailView(contact: contact, imageUrl: )
//	}
//}
