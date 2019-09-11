
import UIKit

protocol TrackCellDelegate {
    func cancelTapped(_ cell: TrackCell)
    func downloadTapped(_ cell: TrackCell)
    func pauseTapped(_ cell: TrackCell)
    func resumeTapped(_ cell: TrackCell)
}

class TrackCell: UITableViewCell {
 
    static let identifier = "TrackCell"

    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var cateLabel: UILabel!
    @IBOutlet weak var LineView: UIView!
    @IBOutlet weak var storeImageView: UIImageView!

    @IBOutlet weak var starPoint1: UIImageView!
    @IBOutlet weak var starPoint2: UIImageView!
    @IBOutlet weak var starPoint3: UIImageView!
    @IBOutlet weak var starPoint4: UIImageView!
    @IBOutlet weak var starPoint5: UIImageView!
    
    var delegate: TrackCellDelegate?

    func configure(track: Track) {
        titleLabel.text = track.name
        artistLabel.text = track.artist
        subtitleLabel.text = track.comName
        cateLabel.text = track.cateist

    DispatchQueue.main.async {
        if let data = try? Data(contentsOf: track.imageURL){
            if let image = UIImage(data: data){
                self.storeImageView.image = image
            }
        }
        
        switch track.starPoint{
        
        case 5:
            
            self.starPoint1.image = UIImage.init(named: "full")
            self.starPoint2.image = UIImage.init(named: "full")
            self.starPoint3.image = UIImage.init(named: "full")
            self.starPoint4.image = UIImage.init(named: "full")
            self.starPoint5.image = UIImage.init(named: "full")
            
            break
            
        case 4.5:
            
            self.starPoint1.image = UIImage.init(named: "full")
            self.starPoint2.image = UIImage.init(named: "full")
            self.starPoint3.image = UIImage.init(named: "full")
            self.starPoint4.image = UIImage.init(named: "full")
            self.starPoint5.image = UIImage.init(named: "half")
            
            break
        case 4:
            self.starPoint1.image = UIImage.init(named: "full")
            self.starPoint2.image = UIImage.init(named: "full")
            self.starPoint3.image = UIImage.init(named: "full")
            self.starPoint4.image = UIImage.init(named: "full")
            self.starPoint5.image = UIImage.init(named: "null")
            break
        
        case 3.5:
            self.starPoint1.image = UIImage.init(named: "full")
            self.starPoint2.image = UIImage.init(named: "full")
            self.starPoint3.image = UIImage.init(named: "full")
            self.starPoint4.image = UIImage.init(named: "half")
            self.starPoint5.image = UIImage.init(named: "null")
            break
            
        case 3:
            self.starPoint1.image = UIImage.init(named: "full")
            self.starPoint2.image = UIImage.init(named: "full")
            self.starPoint3.image = UIImage.init(named: "full")
            self.starPoint4.image = UIImage.init(named: "null")
            self.starPoint5.image = UIImage.init(named: "null")
            break
        
        case 2.5:
            self.starPoint1.image = UIImage.init(named: "full")
            self.starPoint2.image = UIImage.init(named: "full")
            self.starPoint3.image = UIImage.init(named: "half")
            self.starPoint4.image = UIImage.init(named: "null")
            self.starPoint5.image = UIImage.init(named: "null")
            break
            
        case 2:
            self.starPoint1.image = UIImage.init(named: "full")
            self.starPoint2.image = UIImage.init(named: "full")
            self.starPoint3.image = UIImage.init(named: "null")
            self.starPoint4.image = UIImage.init(named: "null")
            self.starPoint5.image = UIImage.init(named: "null")
            break
            
        case 1.5:
            self.starPoint1.image = UIImage.init(named: "full")
            self.starPoint2.image = UIImage.init(named: "half")
            self.starPoint3.image = UIImage.init(named: "null")
            self.starPoint4.image = UIImage.init(named: "null")
            self.starPoint5.image = UIImage.init(named: "null")
            break
            
        case 1:
            self.starPoint1.image = UIImage.init(named: "full")
            self.starPoint2.image = UIImage.init(named: "null")
            self.starPoint3.image = UIImage.init(named: "null")
            self.starPoint4.image = UIImage.init(named: "null")
            self.starPoint5.image = UIImage.init(named: "null")
            
            break
            
        case 0.5:
            self.starPoint1.image = UIImage.init(named: "half")
            self.starPoint2.image = UIImage.init(named: "null")
            self.starPoint3.image = UIImage.init(named: "null")
            self.starPoint4.image = UIImage.init(named: "null")
            self.starPoint5.image = UIImage.init(named: "null")
            
            break
            
        default:
            
            self.starPoint1.image = UIImage.init(named: "null")
            self.starPoint2.image = UIImage.init(named: "null")
            self.starPoint3.image = UIImage.init(named: "null")
            self.starPoint4.image = UIImage.init(named: "null")
            self.starPoint5.image = UIImage.init(named: "null")
            
            break
        }
    }
    
    self.storeImageView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
    
    titleLabel.frame = CGRect.init(x: 0, y: self.storeImageView.frame.height, width: UIScreen.main.bounds.width, height: 20)
    
    subtitleLabel.frame = CGRect.init(x: 0, y: titleLabel.frame.height + self.storeImageView.frame.height, width: UIScreen.main.bounds.width, height: 15)
    
    LineView.frame = CGRect.init(x: 5, y: titleLabel.frame.height*2 + self.storeImageView.frame.height, width: UIScreen.main.bounds.width-10, height: 1)
    
    cateLabel.frame =  CGRect.init(x: 0, y: titleLabel.frame.height*3 + self.storeImageView.frame.height, width: UIScreen.main.bounds.width, height: 20)

    starPoint1.frame =  CGRect.init(x: UIScreen.main.bounds.width - 20*5 - 5, y: titleLabel.frame.height*3 + self.storeImageView.frame.height, width: 20, height: 20)

    starPoint2.frame =  CGRect.init(x: UIScreen.main.bounds.width - 20*4 - 4, y: titleLabel.frame.height*3 + self.storeImageView.frame.height, width: 20, height: 20)
    
    starPoint3.frame =  CGRect.init(x: UIScreen.main.bounds.width - 20*3 - 3, y: titleLabel.frame.height*3 + self.storeImageView.frame.height, width: 20, height: 20)
    
    starPoint4.frame =  CGRect.init(x: UIScreen.main.bounds.width - 20*2 - 2, y: titleLabel.frame.height*3 + self.storeImageView.frame.height, width: 20, height: 20)
    
    starPoint5.frame =  CGRect.init(x: UIScreen.main.bounds.width - 20*1 - 1, y: titleLabel.frame.height*3 + self.storeImageView.frame.height, width: 20, height: 20)
    
    artistLabel.frame =  CGRect.init(x: 0, y: titleLabel.frame.height*4 + self.storeImageView.frame.height, width: UIScreen.main.bounds.width, height: 20)

    }
}
