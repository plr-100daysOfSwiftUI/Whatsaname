//
//  Contact.swift
//  Whatsaname
//
//  Created by Paul Richardson on 11.10.2020.
//

import Foundation
import CoreLocation

struct Contact: Identifiable, Comparable, Codable {
	
	let id: UUID
	let firstName: String
	let lastName: String
	let latitude: CLLocationDegrees
	let longitude: CLLocationDegrees
	let locationName: String
	
	static func < (lhs: Contact, rhs: Contact) -> Bool {
		lhs.lastName < rhs.lastName
	}
}
