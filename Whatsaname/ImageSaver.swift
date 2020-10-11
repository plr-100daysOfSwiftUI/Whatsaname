//
//  ImageSaver.swift
//  Whatsaname
//
//  Created by Paul Richardson on 11.10.2020.
//

import UIKit

class ImageSaver: NSObject {
	
	func writetoJSON(image: UIImage, firstName: String, lastName: String) {
		
		let contact = Contact(firstName: firstName, lastName: lastName)
		let imageUrl = self.getDocumentsDirectory().appendingPathComponent("\(contact.id).jpeg")
		
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
