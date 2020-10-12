//
//  ListView.swift
//  Whatsaname
//
//  Created by Paul Richardson on 12.10.2020.
//

import SwiftUI

struct ListView: View {
	
	var contacts: [Contact]
	
	var body: some View {
		List(contacts.sorted()) { contact in
			NavigationLink(
				destination: DetailView(contact: contact, imageUrl: ContactSaver.getDocumentsDirectory().appendingPathComponent("\(contact.id).jpeg"))) {
				Text("\(contact.lastName), \(contact.firstName)")

			}
		}
	}
	
}

struct ListView_Previews: PreviewProvider {
	static var previews: some View {
		let contact = Contact(id: UUID(), firstName: "Foo", lastName: "Bar")
		let contacts = [contact]
		ListView(contacts: contacts)
	}
}
