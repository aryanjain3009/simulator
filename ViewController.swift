
import UIKit

class ViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let vc = storyboard?.instantiateViewController(identifier: "Main_vc") as! MainViewController
        present(vc, animated: true)
    }


}

