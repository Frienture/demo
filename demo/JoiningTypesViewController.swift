//
//  JoiningTypesViewController.swift
//  demo
//
//  Created by macbookpro on 03/11/2021.
//

import UIKit

enum ExploreSectionType {
    case filters(viewModels: [ExploreFilterCellModel]) // 1
    case company(viewModels: [CompanyCellModel]) // 2
}

class JoiningTypesViewController: UIViewController {
    
    private var collectionView: UICollectionView = UICollectionView (
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return JoiningTypesViewController.createSectionLayout(section: sectionIndex)
        }
    )
    
    private var sections = [ExploreSectionType]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        configureCollectionView()
        configureModels()
        collectionView.backgroundColor = .systemBackground
    }
    //
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        
        
    }
    
    private func configureCollectionView () {
        collectionView.register(
            ExploreFilterCollectionViewCell.self,
            forCellWithReuseIdentifier: ExploreFilterCollectionViewCell.identifier
        )
        collectionView.register(
            CompanyCollectionViewCell.self, forCellWithReuseIdentifier: CompanyCollectionViewCell.identifier
        )
        collectionView.delegate = self
        collectionView.dataSource = self 
    }
    
    private func configureModels() {
        var filters = [ExploreFilterCellModel]()
        filters.append(ExploreFilterCellModel(name: "Filter"))
        filters.append(ExploreFilterCellModel(name: "Date"))
        filters.append(ExploreFilterCellModel(name: "People"))
        filters.append(ExploreFilterCellModel(name: "Joined"))
        filters.append(ExploreFilterCellModel(name: "Private"))

        var companys = [CompanyCellModel]()
        companys.append(CompanyCellModel(name: "Escap Room", groupnumber: "noGroup"))
        companys.append(CompanyCellModel(name: "Escap Room", groupnumber: "1 Group"))
        companys.append(CompanyCellModel(name: "Escap Room", groupnumber: "1 Group"))
        companys.append(CompanyCellModel(name: "Escap Room", groupnumber: "noGroup"))
        companys.append(CompanyCellModel(name: "Escap Room", groupnumber: "noGroup"))
        
        sections.append(.filters(viewModels: filters))
        sections.append(.company(viewModels: companys))

 
        
    }
    
    private static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        switch section {
        case 0:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)

            let horizontalgroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(100) ,
                    heightDimension: .absolute(30)),
                subitem: item,
                count: 1)
            
            let section = NSCollectionLayoutSection(group: horizontalgroup)
            section.orthogonalScrollingBehavior = .continuous
            return section
        case 1:
            //item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(
                top: 2,
                leading: 2,
                bottom: 2,
                trailing: 5
            )
            
            //group
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(300)
                ),
                subitem: item,
                count: 1
            )
            
            //section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            return section
        default:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)

            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1) ,
                    heightDimension: .absolute(20)),
                subitem: item,
                count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
       
    }
}
extension JoiningTypesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      let type = sections[section]
        switch type {
        case .filters(let viewModels):
            return viewModels.count
        case .company(let viewModels):
            return viewModels.count
        }

    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let sec = sections[indexPath.section]
            switch sec {
            case .filters: break
            case .company:
                collectionView.deselectItem(at: indexPath, animated: true)
                let vc = CompanyInfoViewController()
                vc.title = "ESCAP Room"
                vc.navigationItem.largeTitleDisplayMode = .never
                navigationController?.pushViewController(vc, animated: true)
                
            }
            
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let sec = sections[indexPath.section]
        switch sec {
        case .filters(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ExploreFilterCollectionViewCell.identifier,
                for: indexPath
            ) as? ExploreFilterCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            cell.backgroundColor = .secondarySystemBackground
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 10
            return cell
        case .company(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CompanyCollectionViewCell.identifier,
                for: indexPath
            ) as? CompanyCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 10
            return cell
        }
        
    }
    
}




