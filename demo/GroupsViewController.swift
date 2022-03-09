//
//  ViewController.swift
//  demo
//
//  Created by macbookpro on 19/9/2021.
//

import UIKit
import Firebase

enum SectionType {
    case type(viewModels:[TypeCollectionViewCellModel])  // 1
    case avaible(viewModels:[GroupInfo]) // 2
    case news(viewModels:[LatestNewsCellViewModel])
    
    var title: String {
        switch self {
        case .avaible:
            return "My Groups"
        case .type:
            return "Types"
        case .news:
            return "Latest News"
        }
    }
    var page: Int {
        switch self {
        case .avaible: return 0
        case .type: return 0
        case .news: return 3
        }
    }
}

class GroupsViewController: UIViewController {
    private var collectionViews: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return GroupsViewController.createSectionLayout(section: sectionIndex)
        }
    )
    
    
    private let pageControl: UIPageControl = {
        let control = UIPageControl()
        control.currentPage = 0
        control.numberOfPages = 3
        control.translatesAutoresizingMaskIntoConstraints = false
        control.pageIndicatorTintColor = .lightGray
        control.currentPageIndicatorTintColor = .darkGray
        return control
    }()
    
    private let noGroupsLabel: UILabel = {
        let label = UILabel()
        label.text = "No Groups!"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.isHidden = true
        return label
    }()
    
    private var sections = [SectionType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Add subviews
        view.addSubview(collectionViews)
        //setup
        startListeningForGroups()
        configureCollectionView()
        
        collectionViews.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionViews.frame = view.bounds
    }
    
    
    private func configureCollectionView() {
        
        collectionViews.register(
            LatestNewsCollectionViewCell.self,
            forCellWithReuseIdentifier: LatestNewsCollectionViewCell.identifier
        )
        collectionViews.register(
            GroupListCollectionViewCell.self,
            forCellWithReuseIdentifier: GroupListCollectionViewCell.identifier
        )
        collectionViews.register(
            TypeCollectionViewCell.self,
            forCellWithReuseIdentifier: TypeCollectionViewCell.identifier
        )
        collectionViews.register(
            TitleHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TitleHeaderCollectionReusableView.identifier
        )
        collectionViews.register(
            PageFooterCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: PageFooterCollectionReusableView.identifier
        )
        
        collectionViews.dataSource = self
        collectionViews.delegate = self
        
    }
    
    
    
    private func startListeningForGroups() {
        let title:String
        title = "Groups"
        //        print("start fetch...")
        
        
        DatabaseManager.shared.getAllGroupInfo(for: title, completion: {[weak self] result in
            switch result{
            case .success(let model):
                print("Successfully got info")
                guard !model.isEmpty else {
                    return
                }
                
                //                if ((self?.sections.isEmpty) != nil)  {
                //                    self?.sections.removeAll()
                //                }
                //                else{
                self?.sections.append(.avaible(viewModels: model))
                DispatchQueue.main.async {
                    self?.collectionViews.reloadData()
                }
                
                //                }
            case .failure(let error):
                print("failed to get info \(error)")
            }
        })
        
        configureModels()
        collectionViews.reloadData()
        
    }
    
    private func configureModels() {
        var types = [TypeCollectionViewCellModel]()
        var news = [LatestNewsCellViewModel]()
        types.append(TypeCollectionViewCellModel(name: "All", backgroundColor: .systemTeal, imageURL: UIImage(named: "icon2")!))
        types.append(TypeCollectionViewCellModel(name: "Sport", backgroundColor: .systemPink, imageURL: UIImage(named: "icon4")!))
        types.append(TypeCollectionViewCellModel(name: "Meal", backgroundColor: .systemBlue, imageURL: UIImage(named: "icon1")!))
        types.append(TypeCollectionViewCellModel(name: "Leisure", backgroundColor: .systemGreen, imageURL: UIImage(named: "icon3")!))
        
        
        news.append(LatestNewsCellViewModel(imageURL: UIImage(named: "news1")!))
        news.append(LatestNewsCellViewModel(imageURL: UIImage(named: "news2")!))
        news.append(LatestNewsCellViewModel(imageURL: UIImage(named: "news3")!))
        
        sections.append(.news(viewModels: news))
        sections.append(.type(viewModels: types))
    }
}

extension GroupsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = sections[section]
        switch type {
        case .news(let viewModels):
            return viewModels.count
        case .type(let viewModels):
            return viewModels.count
        case .avaible(let viewModels):
            return viewModels.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
    return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sec = sections[indexPath.section]
        switch sec {
            //MARK: News Config
        case .news(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: LatestNewsCollectionViewCell.identifier,
                for: indexPath
            ) as? LatestNewsCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            return cell
            
            //MARK: Types Config
        case .type(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TypeCollectionViewCell.identifier,
                for: indexPath
            ) as? TypeCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 20
            return cell
            //MARK: My Groups Config
        case .avaible(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: GroupListCollectionViewCell.identifier,
                for: indexPath
            ) as? GroupListCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 10
            return cell
        }
        
    }
    
    //Select item
func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sec = sections[indexPath.section]
        switch sec {
        case .avaible:
            collectionView.deselectItem(at: indexPath, animated: true)
            let vc = GroupInfoViewController()
            vc.title = "Name"
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        case .news: break
            
        case .type:
            collectionView.deselectItem(at: indexPath, animated: true)
            let vc = JoiningTypesViewController()
            vc.title = "Exploring Groups"
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    //Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section =  indexPath.section
        if kind == UICollectionView.elementKindSectionHeader {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: TitleHeaderCollectionReusableView.identifier,
            for: indexPath
        ) as? TitleHeaderCollectionReusableView else {
            return UICollectionReusableView()
        }
            let title = sections[section].title
            header.configure(with: title)
            return header
        }
        guard let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: PageFooterCollectionReusableView.identifier,
            for: indexPath
        ) as? PageFooterCollectionReusableView else {
            return UICollectionReusableView()
        }
        
        let page = sections[section].page
        
        
        footer.configure(with: page)
        return footer
        
        
    }
    
    
    
    static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        let supplementaryViews = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(50)
                ),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top),
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(20)
                ),
                elementKind: UICollectionView.elementKindSectionFooter,
                alignment: .bottom)
        ]
        switch section {
        case 0:
            //item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(350)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: 1,
                bottom: 0,
                trailing: 0
            )
            
            //group
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(350)
                ),
                subitem: item,
                count: 1
            )
            
            //section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
        section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = supplementaryViews
            
            return section
        case 1:
            //item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(150),
                    heightDimension: .absolute(150)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(
                top: 5,
                leading: 2,
                bottom: 5,
                trailing: 5
            )
            
            //group
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(150),
                    heightDimension: .absolute(150)
                ),
                subitem: item,
                count: 1
            )
            
            //section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            section.boundarySupplementaryItems = supplementaryViews

            return section
        case 2:
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
            section.boundarySupplementaryItems = supplementaryViews
            return section
            
        default:
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
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(160)
                ),
                subitem: item,
                count: 1
            )
            
            
            //section
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = supplementaryViews
            return section
        }
    }
    
}


