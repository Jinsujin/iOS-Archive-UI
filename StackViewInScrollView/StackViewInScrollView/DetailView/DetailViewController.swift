import UIKit

class DetailViewController: UIViewController {
    static let nibName = "DetailViewController"
    private var viewData: Entity = .mock
    
    @IBOutlet weak var showMoreButton: UIButton!
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var screenshotsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenshotsCollectionView.register(ScreenShotImageCell.self, forCellWithReuseIdentifier: ScreenShotImageCell.identifier)
        titleLabel.text = viewData.trackName
        descriptionLabel.text = viewData.description
        logoImageView.setImageUrl(viewData.artworkUrl100)
    }
    
    func updateView(_ data: Entity) {
        self.viewData = data
    }

    static func instantiateFromNib(with data: Entity) -> DetailViewController {
        let controller = DetailViewController(nibName: DetailViewController.nibName, bundle: nil)
        controller.updateView(data)
        return controller
    }
    
    @IBAction func touchUpShowMoreButton(_ sender: Any) {
        self.descriptionLabel.numberOfLines = 0
        self.showMoreButton.isHidden = true
    }
}


extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.size.height
        return CGSize(width: height/1.7755102040816326, height: height)
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("cell count", viewData.screenshotUrls.count)
        return viewData.screenshotUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenShotImageCell.identifier, for: indexPath) as? ScreenShotImageCell else {
            return UICollectionViewCell()
        }
        let screenshotUrlString = viewData.screenshotUrls[indexPath.row]
        cell.load(with: screenshotUrlString)
        return cell
    }
}


struct Entity {
    let trackName: String
    let artistName: String
    let description: String
    let userRatingCount: Int
    let averageUserRating: Double
    let artworkUrl60, artworkUrl512, artworkUrl100: String
    let screenshotUrls: [String]
    let genres: [String]
}

extension Entity {
    static let mock: Self = {
        Entity(
            trackName: "Yelp: Food, Delivery & Reviews",
            artistName: "Yelp", // "artistId":284910353
            description: "Yelp has over 199 million reviews of businesses worldwide. Whether you’re looking for a new pizza place to try, a great coffee shop nearby, or need to book a haircut, Yelp is your local guide for finding the perfect place to eat, shop, drink, explore, and relax. The Yelp app is available for iPhone, iPad, and Apple Watch.\n\nYelp features:\n\nFood Near You - Find Restaurants\n• Find the newest and hottest restaurants in your area\n• Make reservations, order delivery or pickup—all from your phone\n• Filter restaurant search results by price, location, open now, and more\n\nSearch for Nearby Businesses, Services, & Professionals\n• Discover great local businesses, from hair salons to trusted doctors and movers\n• Read millions of reviews by the Yelp community\n• Home need repairs? Find the best rated contractors and handymen\n• Find great deals offered by local businesses, get quotes instantly, and book appointments\n\nBeauty - Pamper Yourself \n• Find highly-rated salons, spas, massage therapists, and more\n• Book appointments through Yelp at the most relaxing staycation destinations\n\nSearch Filters \n• Filter your search results by neighborhood, distance, rating, price, and hours of operation\n• Look up addresses and phone numbers, call a business, or make reservations directly from the app\n\nOther Features\n• Read expert user reviews and browse through beautiful photos of each business\n• Write and read reviews, check-in to local businesses, upload photos and add tips for other Yelp users\n\nFind local restaurants, read expert customer reviews, and start searching for businesses near you with Yelp. \n\nNeed Help? Contact Yelp at https://www.yelp.com/support\nNote: Continued use of GPS running can dramatically decrease battery life.",
            userRatingCount: 545,
            averageUserRating: 4.63853000000000026403768060845322906970977783203125,
            artworkUrl60: "https://picsum.photos/60/60",
            artworkUrl512: "https://picsum.photos/512/512",
            artworkUrl100: "https://picsum.photos/100/100",
            screenshotUrls: [
                "https://picsum.photos/392/696",
                "https://picsum.photos/392/696",
                "https://picsum.photos/392/696",
                "https://picsum.photos/392/696",
                "https://picsum.photos/392/696"
            ],
            genres: ["음식 및 음료", "여행"]
        )
    }()
}
