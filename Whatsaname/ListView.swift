//
//  ListView.swift
//  Whatsaname
//
//  Created by Paul Richardson on 12.10.2020.
//

import SwiftUI

struct ListView: View {
	
	@Binding var contacts: [Contact]
	
	var body: some View {
		List {
			ForEach(contacts.sorted()) { contact in
				NavigationLink(
					destination: DetailView(contact: contact, imageUrl: ContactSaver.getDocumentsDirectory().appendingPathComponent("\(contact.id).jpeg"))) {
					Text("\(contact.lastName), \(contact.firstName)")
					
				}
			}
			.onDelete(perform: delete)
		}
		.navigationBarTitle(Text("My Contacts"))
		.navigationBarItems(trailing: EditButton())
	}

	func delete(at offsets: IndexSet) {
		contacts.remove(atOffsets: offsets)
		ContactSaver.saveContacts(contacts)
	}
	
}

struct ListView_Previews: PreviewProvider {
	static var previews: some View {
		let contact = Contact(id: UUID(), firstName: "Foo", lastName: "Bar", latitude: 0.0, longitude: 0.0, locationName: "Test Location")
		let contacts = [contact]
		ListView(contacts: .constant(contacts))
	}
}
