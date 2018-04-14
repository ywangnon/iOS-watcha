//
//  CategoryViewController.swift
//  WATCHA
//
//  Created by Seo JaeHyeong on 14/04/2018.
//  Copyright © 2018 Seo Jaehyeong. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
   
   var categories: [Category] = []
   
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
         cell.categoryTitleLabel.text = "\(category.title), pk = \(category.pk)"
         cell.backgroundColor = UIColor.white
         
         return cell
      }
   }
   
   
   
   // 테스트 위한 카테고리 작성
   func makeCategories() {
      
      var randomMovie = Category()
      randomMovie.title = "랜덤 영화"
      randomMovie.image = "github"
      randomMovie.pk = 1
      categories.append(randomMovie)
      
      var millionMovie = Category()
      millionMovie.title = "역대 100만 관객 돌파 영화"
      millionMovie.image = "github"
      millionMovie.pk = 2
      categories.append(millionMovie)
      
      var c = Category()
      c.title = "왓챠 평균별점 TOP 영화"
      c.image = "github"
      c.pk = 3
      categories.append(c)
      
      var d = Category()
      d.title = "전세계 흥행 TOP 영화"
      d.image = "github"
      d.pk = 4
      categories.append(d)
      
      var e = Category()
      e.title = "국내 누적관객수 TOP 영화"
      e.image = "github"
      e.pk = 5
      categories.append(e)
      
      var f = Category()
      f.title = "전문가 고평점 영화"
      f.image = "github"
      f.pk = 6
      categories.append(f)
      
      var g = Category()
      g.title = "저예산 독립 영화"
      g.image = "github"
      g.pk = 7
      categories.append(g)
      
      var h = Category()
      h.title = "고전 영화"
      h.image = "github"
      h.pk = 8
      categories.append(h)
      
      var i = Category()
      i.title = "느와르 영화"
      i.image = "github"
      i.pk = 9
      categories.append(i)
      
      var j = Category()
      j.title = "슈퍼 히어로 영화"
      j.image = "github"
      j.pk = 10
      categories.append(j)
      
      var k = Category()
      k.title = "스포츠 영화"
      k.image = "github"
      k.pk = 11
      categories.append(k)
      
      var l = Category()
      l.title = "범죄"
      l.image = "github"
      l.pk = 12
      categories.append(l)
      
      var m = Category()
      m.title = "드라마"
      m.image = "github"
      m.pk = 13
      categories.append(m)
      
      var n = Category()
      n.title = "코미디 영화"
      n.image = "github"
      n.pk = 14
      categories.append(n)
      
      var o = Category()
      o.title = "로맨스/멜로"
      o.image = "github"
      o.pk = 15
      categories.append(o)
      
      var p = Category()
      p.title = "스릴러"
      p.image = "github"
      p.pk = 16
      categories.append(p)
      
      var q = Category()
      q.title = "로맨틱코미디"
      q.image = "github"
      q.pk = 17
      categories.append(q)
      
      var r = Category()
      r.title = "전쟁"
      r.image = "github"
      r.pk = 18
      categories.append(r)
      
      var s = Category()
      s.title = "가족"
      s.image = "github"
      s.pk = 19
      categories.append(s)
      
      
      var t = Category()
      t.title = "판타지"
      t.image = "github"
      t.pk = 20
      categories.append(t)
      
      var u = Category()
      u.title = "액션"
      u.image = "github"
      u.pk = 21
      categories.append(u)
      
      var v = Category()
      v.title = "SF"
      v.image = "github"
      v.pk = 22
      categories.append(v)
      
      var w = Category()
      w.title = "애니메이션"
      w.image = "github"
      w.pk = 23
      categories.append(w)
      
      var x = Category()
      x.title = "다큐멘터리"
      x.image = "github"
      x.pk = 24
      categories.append(x)
      
      var y = Category()
      y.title = "공포"
      y.image = "github"
      y.pk = 25
      categories.append(y)
      
   }
   
   
}
