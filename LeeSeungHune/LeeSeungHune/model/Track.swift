
import Foundation.NSURL

class Track {

    let artist: String
    let index: Int
    let name: String
    let previewURL: URL
    let imageURL: URL
    let comName : String
    let cateist : String
    let starPoint : Double
    let imageArr : Array<Any>
    let AdvisoryRating : String
    let byte : String
    let releaseNotes : String
    let description : String

    
    

    var downloaded = false

    init(name: String, comName: String, cateist: String, artist: String, previewURL: URL, index: Int, imageURL: URL ,starPoint: Double, imageArr: Array<Any>,AdvisoryRating : String, byte : String, releaseNotes : String, description : String) {
        
        self.name = name
        self.artist = artist
        self.previewURL = previewURL
        self.index = index
        self.imageURL = imageURL
        self.comName = comName
        self.cateist = cateist
        self.starPoint = starPoint
        self.imageArr = imageArr
        self.AdvisoryRating = AdvisoryRating
        self.byte = byte
        self.releaseNotes = releaseNotes
        self.description = description
        
    }
    
}
