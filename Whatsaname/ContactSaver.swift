//
//  ContactSaver.swift
//  Whatsaname
//
//  Created by Paul Richardson on 11.10.2020.
//

import UIKit
import CoreLocation

class ContactSaver: NSObject {
	
	func saveContact(image: UIImage, firstName: String, lastName: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees, locationName: String) {
		let contact = Contact(id: UUID(), firstName: firstName, lastName: lastName, latitude: latitude, longitude: longitude, locationName: locationName)
		writeToJSON(contact)
		saveImage(image: image, id: contact.id)
	}
		
	func writeToJSON (_ contact: Contact) {
		let url = Self.getDocumentsDirectory().appendingPathComponent("contacts.json")
		
		// initialise contacts
		var contacts = [Contact]()
		
		do {
			if let decoded = try? Data(contentsOf: url) {
				contacts = try! JSONDecoder().decode([Contact].self, from: decoded)
			}
			contacts.append(contact)
			let encoded = try! JSONEncoder().encode(contacts)
			try encoded.write(to: url, options: [.atomic])
			print("Data saved")
		} catch {
			print(error.localizedDescription)
		}
	}
	
	func saveImage (image: UIImage, id: UUID) {
		
		let imageUrl = Self.getDocumentsDirectory().appendingPathComponent("\(id).jpeg")
		
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
	
	static func saveContacts(_ contacts: [Contact]) {
		let url = self.getDocumentsDirectory().appendingPathComponent("contacts.json")

		if let encoded = try? JSONEncoder().encode(contacts) {
			try? encoded.write(to: url, options: [.atomic])
		}
		
	}
	
	static func decodeContacts() -> [Contact] {
		let url = self.getDocumentsDirectory().appendingPathComponent("contacts.json")
		
		// initialise contacts
		var contacts = [Contact]()
		
		
		if let decoded = try? Data(contentsOf: url) {
			contacts = try! JSONDecoder().decode([Contact].self, from: decoded)
		}
		
		return contacts
	}
	
	static func getDocumentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths[0]
	}
	
}
