//
//  UITableView+Extensions.swift
//  MyMovies
//
//  Created by Karim Amsha on 17.06.2023.
//

import UIKit

extension UITableView {
    func reloadDataBy(indexPath: IndexPath) {
      UIView.setAnimationsEnabled(false)
      self.beginUpdates()
      self.reloadRows(at: [indexPath], with: .none)
      self.endUpdates()
      UIView.setAnimationsEnabled(true)
    }

    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
      return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }

    func scrollToTop(animated: Bool) {
      let indexPath = IndexPath(row: 0, section: 0)
      if self.hasRowAtIndexPath(indexPath: indexPath) {
        self.scrollToRow(at: indexPath, at: .top, animated: animated)
      }
    }

    func setAndLayoutTableHeaderView(header: UIView) {
        self.tableHeaderView = header
        header.setNeedsLayout()
        header.layoutIfNeeded()
        header.frame.size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        self.tableHeaderView = header
    }
    
    func tableViewAutoSize(height : CGFloat) {
        self.rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = height
    }

    func dequeueTVCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Could not locate viewcontroller with with identifier \(String(describing: T.self)) in storyboard.")
        }
        return cell
    }
    
    func registerCell(id: String) {
        self.register(UINib(nibName: id, bundle: nil), forCellReuseIdentifier: id)
    }
    
    func registerCell(id: UITableViewCell.Type) {
        let _id = String(describing: id)
        self.register(UINib(nibName: _id, bundle: nil), forCellReuseIdentifier: _id)
    }
    
    func layoutTableHeaderView() {
      guard let headerView = self.tableHeaderView else { return }
      headerView.translatesAutoresizingMaskIntoConstraints = false
      let headerWidth = headerView.bounds.size.width;
      let temporaryWidthConstraints = NSLayoutConstraint.constraints(withVisualFormat: "[headerView(width)]", options: NSLayoutConstraint.FormatOptions(rawValue: UInt(0)), metrics: ["width": headerWidth], views: ["headerView": headerView])
      headerView.addConstraints(temporaryWidthConstraints)
      headerView.setNeedsLayout()
      headerView.layoutIfNeeded()
      let headerSize = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
      let height = headerSize.height
      var frame = headerView.frame
      frame.size.height = height
      headerView.frame = frame
      self.tableHeaderView = headerView
      headerView.removeConstraints(temporaryWidthConstraints)
      headerView.translatesAutoresizingMaskIntoConstraints = true
    }
}
