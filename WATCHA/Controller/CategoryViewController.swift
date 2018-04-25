//
//  CategoryViewController.swift
//  WATCHA
//
//  Created by Seo JaeHyeong on 14/04/2018.
//  Copyright © 2018 Seo Jaehyeong. All rights reserved.
//

import UIKit

protocol CategoryDelegate {
   func passData(url: String, genre: String)
}


class CategoryViewController: UIViewController {
   
   var categories: [Category] = []
   var delegate: CategoryDelegate?
   
   @IBOutlet weak var tableView: UITableView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      tableView.delegate = self
      tableView.dataSource = self
      tableView.separatorStyle = .none
      
      makeCategories()
      
   }
   
   
   @objc func cancleButtonPressed() {
      
      dismiss(animated: true, completion: nil)
   }
   
   
   @objc func upperViewTapped() {
      self.dismiss(animated: true, completion: nil)
   }
   
   
}


// MARK: - Table view data source
extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
   
   func numberOfSections(in tableView: UITableView) -> Int {
      // #warning Incomplete implementation, return the number of sections
      return 2
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
      if section == 1 {
         return categories.count
      }
      
      return 1
   }
   
   
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      if section == 1 {
         return 40
      }
      
      return 300
   }
   
   
   func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      var result = ""
      if section == 1 {
         result = "카테고리 선택"
      }
      return result
   }
   
   
   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      
      let width = self.view.frame.size.width
      
      if section == 0 {
         let upperView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 300))
         upperView.backgroundColor = UIColor.clear
         let tap = UITapGestureRecognizer(target: self, action: #selector(self.upperViewTapped))
         upperView.addGestureRecognizer(tap)
         
         return upperView
      } else {
         
         let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 40))
         //headerView.frame = CGRect(x: 0, y: 0, width: width, height: 40)
         headerView.backgroundColor = UIColor.white
         
         let cancleButton: UIButton = UIButton(frame: CGRect(x: 5, y: 0, width: 40, height: 40))
         cancleButton.setTitle("취소", for: .normal)
         cancleButton.setTitleColor(UIColor.blue, for: .normal)
         cancleButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 17)
         cancleButton.addTarget(self, action: #selector(self.cancleButtonPressed), for: .touchUpInside)
         
         let titleLb: UILabel = UILabel(frame: CGRect(x: width/2 - 50, y: 0, width: 100, height: 40))
         titleLb.text = "카테고리 선택"
         titleLb.textColor = UIColor.darkGray
         titleLb.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 17)
         
         headerView.addSubview(cancleButton)
         headerView.addSubview(titleLb)
         
         return headerView
      }
      
   }
   
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
      return 40
   }
   
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      
      if indexPath.section == 0 {
         let upCell = UITableViewCell()
         upCell.backgroundColor = UIColor.clear
         
         return upCell
      } else {
         let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
         let category = categories[indexPath.row]
         
         cell.categoryImageView.image = UIImage(named: category.image)
         cell.categoryTitleLabel.text = "\(category.title)"
         cell.backgroundColor = UIColor.white
         
         return cell
      }
   }
   
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let categoryName = categories[indexPath.row].name
      let categoryKind = categories[indexPath.row].kind
      
      delegate?.passData(url: API.Movie.detail+categoryKind+"/"+categoryName+"/", genre: categoryName)
      self.dismiss(animated: true, completion: nil)
   }
   
   
   
   // 테스트 위한 카테고리 작성
   func makeCategories() {
      
      var a = Category()
      a.title = "국내 누적관객수 TOP 영화"
      a.name = "top-korea"
      a.image = "github"
      a.kind = "tag"
      categories.append(a)
      
      var b = Category()
      b.title = "역대 100만 관객 돌파 영화"
      b.name = "million-seller"
      b.image = "github"
      b.kind = "tag"
      categories.append(a)
      
      var c = Category()
      c.title = "슈퍼 히어로 영화"
      c.image = "github"
      c.name = "hero"
      c.kind = "tag"
      categories.append(c)
      
      var d = Category()
      d.title = "전세계 흥행 TOP 영화"
      d.name = "top-world"
      d.image = "github"
      d.kind = "tag"
      categories.append(d)

      var f = Category()
      f.title = "스포츠 영화"
      f.image = "github"
      f.name = "sports"
      f.kind = "tag"
      categories.append(f)

      var g = Category()
      g.title = "가족"
      g.image = "github"
      g.name = "family"
      g.kind = "tag"
      categories.append(g)
      
      var e = Category()
      e.title = "액션"
      e.image = "github"
      e.name = "action"
      e.kind = "genre"
      
      var l = Category()
      l.title = "범죄"
      l.name = "crime"
      l.image = "github"
      l.kind = "genre"
      categories.append(l)
      
      var m = Category()
      m.title = "드라마"
      m.name = "drama"
      m.image = "github"
      m.kind = "genre"
      categories.append(m)
      
      var n = Category()
      n.title = "코미디 영화"
      n.name = "comedy"
      n.image = "github"
      n.kind = "genre"
      categories.append(n)
      
      var o = Category()
      o.title = "로맨스/멜로"
      o.name = "romance"
      o.image = "github"
      o.kind = "genre"
      categories.append(o)
      
      var p = Category()
      p.title = "스릴러"
      p.name = "thriller"
      p.image = "github"
      p.kind = "genre"
      categories.append(p)
      
      var q = Category()
      q.title = "로맨틱코미디"
      q.name = "roco"
      q.image = "github"
      q.kind = "genre"
      categories.append(q)
      
      var r = Category()
      r.title = "전쟁"
      r.name = "war"
      r.image = "github"
      r.kind = "genre"
      categories.append(r)
      
      var t = Category()
      t.title = "판타지"
      t.name = "fantasy"
      t.image = "github"
      t.kind = "genre"
      categories.append(t)
      
      var v = Category()
      v.title = "SF"
      v.name = "sf"
      v.image = "github"
      v.kind = "genre"
      categories.append(v)
      
      var w = Category()
      w.title = "애니메이션"
      w.name = "animation"
      w.image = "github"
      w.kind = "genre"
      categories.append(w)
      
      var x = Category()
      x.title = "다큐멘터리"
      x.name = "documentary"
      x.image = "github"
      x.kind = "genre"
      categories.append(x)
      
      var y = Category()
      y.title = "공포"
      y.name = "horror"
      y.image = "github"
      y.kind = "genre"
      categories.append(y)
      
//      var u = Category()
//      u.title = "서부"
//      u.name = "western"
//      u.image = "github"
//      u.kind = "genre"
//      categories.append(u)
//
//      var h = Category()
//      h.title = "뮤지컬"
//      h.name = "musical"
//      h.image = "github"
//      h.kind = "genre"
//      categories.append(h)
//
//      var i = Category()
//      i.title = "무협"
//      i.image = "github"
//      i.name = "martial-arts"
//      i.kind = "genre"
//      categories.append(i)

      var j = Category()
      j.title = "미스터리"
      j.name = "mistery"
      j.image = "github"
      j.kind = "genre"
      categories.append(j)

//      var k = Category()
//      k.title = "컬트"
//      k.name = "cult"
//      k.image = "github"
//      k.kind = "genre"
//      categories.append(k)
      
   }
   
   
}
