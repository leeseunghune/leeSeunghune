
import UIKit

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
    
}

class DetailViewController: UIViewController {
    
    var tableViewData = [cellData]()

    @IBOutlet weak var mainScroll: UIScrollView!
    @IBOutlet weak var imageScroll: UIScrollView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var compLabel: UILabel!
    @IBOutlet weak var payLabel: UILabel!
    @IBOutlet weak var webViewBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var expandableTVC: UITableView!
    

    public var imageArr : Array<Any> = []
    public var artist: String = ""
    public var index: Int = 0
    public var name: String = ""
    public var comName : String = ""
    public var cateist : String = ""
    public var pay : String = ""
    
    public var AdvisoryRating : String = ""
    public var byte : String = ""
    public var releaseNotes : String = ""
    public var descriptionString : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainScroll.frame = CGRect.init(x: 0, y: 76, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 76)
        
        mainScroll.contentSize.height = self.view.frame.height*1.3

        
        imageScroll.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2 - 76)
        
        appNameLabel.frame = CGRect.init(x: 0, y: imageScroll.frame.height*1.025,
                                         width: UIScreen.main.bounds.width, height: 20)
        
        compLabel.frame = CGRect.init(x: 0, y: imageScroll.frame.height*1.05 + 20,
                                      width: UIScreen.main.bounds.width, height: 20)
        
        payLabel.frame = CGRect.init(x: 0, y: imageScroll.frame.height*1.075 + 40,
                                     width: UIScreen.main.bounds.width, height: 20)
        
        webViewBtn.frame = CGRect.init(x: 0, y: imageScroll.frame.height*1.1 + 60,
                                       width: UIScreen.main.bounds.width/2, height: 40)
        
        webViewBtn.backgroundColor = .clear
        webViewBtn.layer.cornerRadius = 5
        webViewBtn.layer.borderWidth = 0.5
        webViewBtn.layer.borderColor = UIColor.black.cgColor
        
        shareBtn.frame = CGRect.init(x: UIScreen.main.bounds.width/2, y: imageScroll.frame.height*1.1 + 60,
                                     width: UIScreen.main.bounds.width/2, height: 40)
        
        shareBtn.backgroundColor = .clear
        shareBtn.layer.cornerRadius = 5
        shareBtn.layer.borderWidth = 0.5
        shareBtn.layer.borderColor = UIColor.black.cgColor
        
        var byteInt :Int = Int(byte)!
        byteInt = byteInt/1048576
        print(byteInt)
        byte = String(byteInt)
        
        tableViewData = [cellData(opened: false, title: "크기", sectionData: [byte + " MB"]),
                         cellData(opened: false, title: "연령", sectionData: [AdvisoryRating]),
                         cellData(opened: false, title: "새로운기능", sectionData: ["",releaseNotes])]

        
        expandableTVC.frame = CGRect.init(x: 0, y: imageScroll.frame.height*1.1 + 100,
                                          width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
        
        expandableTVC.tableFooterView = UIView()
                
        for i in 0..<imageArr.count{
            let imageView = UIImageView()
            
            if let data = try? Data(contentsOf: URL(string: imageArr[i] as! String)!){
                if let image = UIImage(data: data){
                    imageView.image = image
                }
            }

            
            imageView.contentMode = .scaleAspectFit
            
            let xPosition = self.view.frame.width/2.4 * CGFloat(i)
            
            imageView.frame = CGRect(x: xPosition, y: 0,
                                     width: self.imageScroll.frame.width/2.4,
                                     height: self.imageScroll.frame.height)
            
            imageScroll.contentSize.width =
                self.view.frame.width/2.4 * CGFloat(1+i)
            
            imageScroll.addSubview(imageView)
            
        }
        
        appNameLabel.text = name
        compLabel.text = comName
        payLabel.text = pay

    }
}

extension DetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true{
            return tableViewData[section].sectionData.count
        }else{
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell")else{return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].title
            cell.detailTextLabel?.text = tableViewData[indexPath.section].sectionData[0]
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell")else{return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[indexPath.row]
            cell.detailTextLabel?.text = tableViewData[indexPath.section].sectionData[0]
            cell.textLabel?.lineBreakMode
            cell.textLabel?.numberOfLines = 0
            return cell
        }
        
    }
}
extension DetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            
            if tableViewData[indexPath.section].opened == true{
                tableViewData[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
                
            }else{
                tableViewData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        }
    }
}
