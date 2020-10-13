//
//  MapView.swift
//  Whatsaname
//
//  Created by Paul Richardson on 13.10.2020.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: UIViewRepresentable {
	
	var latitude: CLLocationDegrees
	var longitude: CLLocationDegrees
	
	var location: CLLocationCoordinate2D {
		return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
	}
	
	func makeUIView(context: Context) -> MKMapView {
		let mapView = MKMapView()

		let distance: CLLocationDistance = 5000.0
		let region = MKCoordinateRegion(center: location, latitudinalMeters: distance, longitudinalMeters: distance)
		mapView.region = region

		let annotation = MKPointAnnotation()
		annotation.coordinate = location
		mapView.addAnnotation(annotation)

		mapView.delegate = context.coordinator

		return mapView
	}
	
	func updateUIView(_ uiView: MKMapView, context: Context) {
		
	}
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}

	class Coordinator: NSObject, MKMapViewDelegate {
		var parent: MapView
		
		init(_ parent: MapView) {
			self.parent = parent
		}
		
		func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {

		}
		
		func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
			let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
			annotationView.canShowCallout = false
			return annotationView
		}
		
	}

}

struct MapView_Previews: PreviewProvider {
	static var previews: some View {
		MapView(latitude: 0.0, longitude: 0.0)
	}
}
