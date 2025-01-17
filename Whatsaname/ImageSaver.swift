//
//  ImageSaver.swift
//  Whatsaname
//
//  Created by Paul Richardson on 11.10.2020.
//

import UIKit

class ContactSaver: NSObject {
	
	func writetoJSON(image: UIImage, firstName: String, lastName: String) {
		
		let contact = Contact(id: UUID(), firstName: firstName, lastName: lastName)

		let imageUrl = self.getDocumentsDirectory().appendingPathComponent("\(contact.id).jpeg")
		let contactsUrl = self.getDocumentsDirectory().appendingPathComponent("contacts.json")
		
		// initialise contacts
		var contacts = [Contact]()
		
		if let decoded = try? Data(contentsOf: contactsUrl) {
			contacts = try! JSONDecoder().decode([Contact].self, from: decoded)
		}
		
		// save contacts
		do {
			contacts.append(contact)
			let encoded = try! JSONEncoder().encode(contacts)
			try encoded.write(to: contactsUrl, options: [.atomic])
			print("Data saved")
			
		} catch {
			print(error.localizedDescription)
		}
		
		// save image
		do {
	
			if let jpegData = image.jpegData(compressionQuality: 0.8) {
				try jpegData.write(to: imageUrl, options: [.atomicWrite, .completeFileProtection])
				print("Image saved.")
			}
		} catch {
			print(error.localizedDescription)
		}
		
	}
	
	func getDocumentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths[0]
	}
	
}
