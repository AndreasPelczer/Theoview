//
//  CameraZugriffContentView.swift
//  CameraZugriff
//
//  Created by Andreas Pelczer on 29.01.24.
/*
import SwiftUI
//import FirebaseStorage
import UIKit

struct CameraZugriffContentView: View {
    @State private var photo: UIImage?
    @State private var showCameraView = false

    var body: some View {
        VStack {
            if let photo = self.photo {
                Image(uiImage: photo)
                    .resizable()
                    .scaledToFit()
            }
            Spacer()
            HStack {
                Button("Show camera") {
                    showCameraView = true
                }
                .disabled(!CameraZugriffView.canCaptureImages)
                
                Button("Speichern") {
                    savePhoto()
                }
                .disabled(photo == nil)
            }
        }
        .sheet(isPresented: $showCameraView) {
            CameraZugriffView(photo: $photo, showsCameraView: $showCameraView)
        }
    }
    func savePhoto() {
            guard let photo = self.photo else { return }
            
            UIImageWriteToSavedPhotosAlbum(photo, nil, nil, nil)
        }
    }
    
  /*  func savePhoto() {
        guard let photo = self.photo else { return }
        
        // Firebase Storage Referenz
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        // Eindeutigen Dateinamen generieren
        let filename = UUID().uuidString
        
        // Referenz für das Bild im Storage
        let imageRef = storageRef.child("images/\(filename).jpg")
        
        // Bild als JPEG-Daten konvertieren
        if let imageData = photo.jpegData(compressionQuality: 0.5) {
            // Bild in Firebase Storage hochladen
            _ = imageRef.putData(imageData, metadata: nil) { metadata, error in
                if let error = error {
                    print("Fehler beim Hochladen des Bildes: \(error)")
                } else {
                    print("Bild erfolgreich hochgeladen.")
                    // Hier können Sie weitere Aktionen ausführen, z.B. Benachrichtigungen aktualisieren, etc.
                }
            }
        }
    }*/
 */
