

import Foundation


class QueryService {
    
  let defaultSession = URLSession(configuration: .default)
  
    
  var dataTask: URLSessionDataTask?
  var errorMessage = ""
  var tracks: [Track] = []
    
  typealias JSONDictionary = [String: Any]
  typealias QueryResult = ([Track]?, String) -> Void
  
    
  func getSearchResults(completion: @escaping QueryResult) {

    dataTask?.cancel()
    
    if var urlComponents = URLComponents(string: "https://itunes.apple.com/search") {
      urlComponents.query = "term=핸드메이드&country=kr&media=software"

        guard let url = urlComponents.url else {
        return
      }
    
      dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
        defer {
          self?.dataTask = nil
        }
        
        if let error = error {
          self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
        } else if
          let data = data,
          let response = response as? HTTPURLResponse,
          response.statusCode == 200 {
          
          self?.updateSearchResults(data)
          
          DispatchQueue.main.async {
            completion(self?.tracks, self?.errorMessage ?? "")
          }
        }
      }
      
      dataTask?.resume()
    }
  }
  
    
  private func updateSearchResults(_ data: Data) {
    var response: JSONDictionary?
    tracks.removeAll()
    
    do {
      response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
    } catch let parseError as NSError {
      errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
      return
    }
    
    guard let array = response!["results"] as? [Any] else {
      errorMessage += "Dictionary does not contain results key\n"
      return
    }
    
    var index = 0
    
    for trackDictionary in array {

        if let trackDictionary = trackDictionary as? JSONDictionary,
        let previewURLString = trackDictionary["artistViewUrl"] as? String,
        let previewURL = URL(string: previewURLString),
        let name = trackDictionary["trackCensoredName"] as? String,
        let comName = trackDictionary["artistName"] as? String,
        let cateist = trackDictionary["primaryGenreName"] as? String,
        let artist = trackDictionary["formattedPrice"] as? String,
        let imageURLString = trackDictionary["artworkUrl512"] as? String,
        let imageURL = URL(string: imageURLString),
        let starPoint = trackDictionary["averageUserRating"] as? Double,
        let imageArr = trackDictionary["screenshotUrls"] as? Array<Any>,
        let AdvisoryRating = trackDictionary["contentAdvisoryRating"] as? String,
        let byte = trackDictionary["fileSizeBytes"] as? String,
        let releaseNotes = trackDictionary["releaseNotes"] as? String,
        let description = trackDictionary["description"] as? String{
        tracks.append(Track(name: name, comName: comName, cateist: cateist, artist: artist,
                            previewURL: previewURL, index: index, imageURL: imageURL, starPoint: starPoint,imageArr: imageArr,AdvisoryRating: AdvisoryRating,byte: byte,releaseNotes: releaseNotes,description: description))
          index += 1
      } else {
        errorMessage += "Problem parsing trackDictionary\n"
      }
    }
  }
}
