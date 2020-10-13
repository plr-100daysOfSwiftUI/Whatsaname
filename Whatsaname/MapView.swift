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
	
	/*
	TODO: How do we add a navigation bar title to this view?
	*/
	
	var latitude: CLLocationDegrees
	var longitude: CLLocationDegrees
	var locationName: String
	
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
		annotation.title = locationName
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
			let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: nil)

			return annotationView
		}
		
	}

}

struct MapView_Previews: PreviewProvider {
	static var previews: some View {
		MapView(latitude: 0.0, longitude: 0.0, locationName: "Test Location")
	}
}
