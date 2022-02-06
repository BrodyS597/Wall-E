//
//  PhotoTableViewController.swift
//  Wall-E
//
//  Created by Brody Sears on 2/5/22.
//

import UIKit

class PhotoTableViewController: UITableViewController {
    
    // MARK: -IBOutlets
    @IBOutlet weak var roverSegmentedControl: UISegmentedControl!
    @IBOutlet weak var dateSearchBar: UISearchBar!
    
    // MARK: -Properties
    var roverName: String = "Curiosity"
    var photoArray: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateSearchBar.delegate = self
    }
    // MARK: -IBActions
    @IBAction func roverSegmentValueChanged(_ sender: Any) {
        //sets the roverindex to be the index number that identifies the selected segment the user last touched.
        let roverIndex = roverSegmentedControl.selectedSegmentIndex
        //sets the roverName to the value of the returned title from the specified/selected segment.
        roverName = roverSegmentedControl.titleForSegment(at: roverIndex) ?? ""
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? PhotoTableViewCell else { return UITableViewCell() }
        let photo = photoArray[indexPath.row]
        cell.updateViews(photo: photo)
        
        return cell
    }
} //end of class

extension PhotoTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let unwrappedDateString = searchBar.text,
              !unwrappedDateString.isEmpty
        else { return }
        NetworkController.fetchPhotos(roverName: roverName, earthDate: unwrappedDateString) { photoArray in
            self.photoArray = photoArray
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
