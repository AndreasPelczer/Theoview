import SwiftUI
import UIKit

struct ContentView: View {
    @State private var photo: UIImage?
    @State private var showCameraView = false
    
    let imageSaver = ImageSaver()
    
    var body: some View {
        VStack {
            if let photo = self.photo {
                ZStack {
                    // Hintergrund: Gespiegeltes Bild
                    Image(uiImage: photo)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(x: -1, y: 1) // Horizontales Spiegeln des Bildes
                    
                    // Vordergrund: Originalbild mit 50% Transparenz
                    Image(uiImage: photo)
                        .resizable()
                        .scaledToFit()
                        .opacity(0.5) // Setzen der Transparenz auf 50%
                }
            }
            Spacer()
            Button("Show Camera") {
                showCameraView = true
            }
            Button("Bild speichern") {
                if let imageToSave = self.photo {
                    if var savedImage = self.combineImages(imageToSave, imageToSave) {
                        self.imageSaver.saveImage(savedImage)
                    }
                }
            }
            .sheet(isPresented: $showCameraView) {
                CameraView(photo: $photo, takePhoto: { image in
                    // Speichern des Bildes in den eigenen Bildern
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                })
            }
            .padding()
        }
    }
    
    func combineImages(_ image1: UIImage, _ image2: UIImage) -> UIImage? {
        // Größe des resultierenden Bildes basierend auf dem größten der beiden Bilder
        let maxSize = CGSize(width: max(image1.size.width, image2.size.width),
                             height: max(image1.size.height, image2.size.height))
        
        // Beginnen des Zeichnens im Grafikkontext
        UIGraphicsBeginImageContextWithOptions(maxSize, false, 0.0)
        
        // Zeichnen des ersten Bildes
        image1.draw(in: CGRect(origin: .zero, size: image1.size), blendMode: .normal, alpha: 0.5)
        
        // Zeichnen des zweiten Bildes mit Transparenz
        image2.draw(in: CGRect(origin: .zero, size: image2.size), blendMode: .normal, alpha: 0.5)
        
        // Extrahieren des resultierenden Bildes aus dem Grafikkontext
        let compositeImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // Beenden des Grafikkontexts
        UIGraphicsEndImageContext()
        
        return compositeImage
    }
}

class ImageSaver: NSObject {
    func saveImage(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // Fehler beim Speichern des Bildes
            print("Fehler beim Speichern des Bildes:", error.localizedDescription)
        } else {
            // Bild wurde erfolgreich gespeichert
            print("Bild wurde erfolgreich gespeichert.")
        }
    }
}
