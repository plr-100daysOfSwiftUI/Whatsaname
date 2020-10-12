//
//  DetailView.swift
//  Whatsaname
//
//  Created by Paul Richardson on 12.10.2020.
//

import SwiftUI

struct DetailView: View {
	
	var contact: Contact
	
	var body: some View {
		Text("\(contact.firstName) \(contact.lastName)")
	}
}

//struct DetailView_Previews: PreviewProvider {
//	static var previews: some View {
//		let contact = Contact(id: UUID(), firstName: "Foo", lastName: "Bar")
//		DetailView(contact: contact, imageUrl: )
//	}
//}
