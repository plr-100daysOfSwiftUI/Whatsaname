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
		List(contacts) { contact in
			NavigationLink(
				destination: DetailView(contact: contact)) {
				Text("\(contact.firstName)")
				Text("\(contact.lastName)")
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
