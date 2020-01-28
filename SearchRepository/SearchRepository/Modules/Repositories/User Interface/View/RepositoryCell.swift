//
//  RepositoryCell.swift
//  SearchRepository
//
//  Created by InKwon James Kim on 2020/01/27.
//  Copyright © 2020 InKwon Devik Kim. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {
  
  @IBOutlet private weak var repositoryNameLabel: UILabel!
  @IBOutlet private weak var repositoryDescriptionLabel: UILabel!
  @IBOutlet private weak var updatedAtLabel: UILabel!
  @IBOutlet private weak var starLabel: UILabel!
  @IBOutlet private weak var languageLabel: UILabel!
  
  func setModel(with model: Repository) {
    repositoryNameLabel.text = "\(model.owner?.login ?? "")/\(model.name ?? "nil")"
    repositoryDescriptionLabel.text = model.description
    updatedAtLabel.text = model.updatedAt
    starLabel.text = "\(model.stargazersCount ?? 0)"
    languageLabel.text = model.language
  }
}
