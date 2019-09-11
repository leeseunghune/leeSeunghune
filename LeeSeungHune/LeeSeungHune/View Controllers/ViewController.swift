
import UIKit
import AVKit
import UIKit

class ViewController: UIViewController {
    
    
    let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    let queryService = QueryService()
    
    var moveIdex = Int()
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var searchResults: [Track] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.frame = CGRect.init(x: 0, y: 76, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 76)
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.estimatedRowHeight = 500
        
        search()
        
        }
    

    func search() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        queryService.getSearchResults() { [weak self] results, errorMessage in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if let results = results {
                self?.searchResults = results
                self?.tableView.reloadData()
                self?.tableView.setContentOffset(CGPoint.zero, animated: false)
            }
            
            if !errorMessage.isEmpty {
                print("Search error: " + errorMessage)
            }
        }
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TrackCell = tableView.dequeueReusableCell(withIdentifier: TrackCell.identifier,
                                                            for: indexPath) as! TrackCell
                
        let track = searchResults[indexPath.row]
        cell.configure(track: track)
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchResults.count
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        moveIdex = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "show_detail"{
            
            let track = searchResults[moveIdex]
            
            let secondVC = segue.destination as! DetailViewController
            secondVC.imageArr = track.imageArr
            secondVC.name = track.name
            secondVC.comName = track.comName
            secondVC.pay = track.artist
            secondVC.AdvisoryRating = track.AdvisoryRating
            secondVC.byte = track.byte
            secondVC.releaseNotes = track.releaseNotes
            secondVC.descriptionString = track.description
            
            let backItem = UIBarButtonItem()
            backItem.title = "핸드메이드"
            navigationItem.backBarButtonItem = backItem

        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return (UIScreen.main.bounds.width - self.view.frame.height/2.5) + UIScreen.main.bounds.width
    }
    
}


extension ViewController: URLSessionDelegate {
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        DispatchQueue.main.async {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                let completionHandler = appDelegate.backgroundSessionCompletionHandler {
                appDelegate.backgroundSessionCompletionHandler = nil
                completionHandler()
            }
        }
    }
}

