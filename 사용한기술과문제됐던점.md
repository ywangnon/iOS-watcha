# 기술과 문제점

## 기술

- Alamofire와 FacebookLogin

```
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let token = strToken, let searchWord = searchTextField.text else { return false }
        
        // 토큰헤더 형식으로
        let headerToken = "token " + token
        let userToken: HTTPHeaders = [
            "Authorization": headerToken
        ]
        
        // searchWord는 한글로도 입력가능하기때문에 변환
        // addingPercentEncoding: 지정한 문자 집합에 없는 문자열의 모든 문자를 퍼센트 인코딩된 문자로 바꾸어 만든 새 문자열을 반환합니다.
        // urlQueryAllowed: 쿼리 URL구성 요소에 허용되는 문자 집합을 반환합니다.
        let search = searchWord.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://justdo2t.com/api/movie/search/?movie=\(search)"
        
        // 기본 SessionManager를 사용하여 지정된 URL, 메서드, 매개 변수, 인코딩 및 헤더의 내용을 검색하는 DataRequest를 만듭니다.
        // validate: 응답에 지정된 시퀀스의 상태 코드가 있는지 확인합니다. 유효성 검사가 실패하면 이후의 응답 핸들러 호출은 연관된 오류를 갖습니다.
        // 요청이 완료되면 호출 할 처리기를 추가합니다.
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: userToken)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if let error = response.error {
                // 에러 처리
                // 만약 결과가 실패, nil, 다른 문제가 있다면 연관된 결과값을 리턴합니다.
                    dump(error)
                    return
                }
                
                do {
                    let data = try JSONSerialization.data(withJSONObject: response.result.value!, options: .prettyPrinted)
                    let decoder: JSONDecoder = JSONDecoder()
                    self.searchResult = try decoder.decode(SearchMovie.self, from: data)
                    self.SearchMovies = self.searchResult.results
                    self.searchBool = true
                    self.HometableView.reloadData()
                } catch {
                // 에러 처리
                // 위의 에러처리와의 차이점은 위는 통신상의 오류라면, do-catch에서는 형식상, 또는 잘못된 값 등의 오류를 잡는다.
                }
        }
        
        return true
    }
```

- 정규식

```
    /// password 형태 검사
    ///
    /// - Parameter password: 입력된 패스워드
    /// - Returns: 지정된 형식의 패스워드 아님
    func isValidPassword(_ password: String) -> Bool {

    // 패스워드 정규식 : 6-20자 이내
        let passwordRegEx = "^(?=.*[a-zA-Z0-9]).{6,20}$"

        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)

        return passwordTest.evaluate(with: password)
    }

    /// email 형태 검사
    ///
    /// - Parameter email: 입력된 email
    /// - Returns: true는 이메일 형식, false는 이메일 형식 아님
    func isValidEmailAddress(email: String) -> Bool {

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)

        return emailTest.evaluate(with: email)
    }
```

- search

```
func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("\n---------- [ Search ] ----------\n")
        
        print("\n---------- [ header ] ----------\n")
        guard let token = strToken, let searchWord = searchTextField.text else { return false }
        
        let headerToken = "token " + token
        let userToken: HTTPHeaders = [
            "Authorization": headerToken
        ]
        print(headerToken)
        
        let search = searchWord.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://justdo2t.com/api/movie/search/?movie=\(search)"
        
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: userToken)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if let error = response.error {
                    print("\n---------- [ error3 ] ----------\n")
                    dump(error)
                    return
                }
                
                do {
                    print("\n---------- [ Search JSONSerialization ] ----------\n")
                    let data = try JSONSerialization.data(withJSONObject: response.result.value!, options: .prettyPrinted)
                    let decoder: JSONDecoder = JSONDecoder()
                    self.searchResult = try decoder.decode(SearchMovie.self, from: data)
                    self.SearchMovies = self.searchResult.results
                    print(self.SearchMovies)
                    self.searchBool = true
                    self.HometableView.reloadData()
                } catch {
                    print("\n---------- [ error4 ] ----------\n")
                    print(error)
                }
        }
        
        return true
    }
```

- 에러처리 Animation

```
                    if error.localizedDescription == "Response status code was unacceptable: 400." {
                        
                        // 한번밖에 안됨, 리팩토링 필요
                        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 1, options: [], animations: {
                            print("animation")
                            self.view.frame.origin.x = 5
                            self.view.layoutIfNeeded()
                            self.view.frame.origin.x = -5
                            self.view.setNeedsLayout()
                        }, completion: { (bool) in
                            print("alert")
                            let alertController = UIAlertController(title: "아이디 혹은 비밀번호를 잘못 입력하였습니다.", message: "다시 입력해주세요.", preferredStyle: UIAlertControllerStyle.alert)
                            
                            alertController.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default,handler: nil))
                            
                            self.present(alertController, animated: true, completion: nil)
                        })
                    }
```

- 데이터 모델링

```
// API
// USER
// SEARCH

struct user: Decodable {
    var pk: Int
    var email: String?
    var nickname: String
    var imgProfile: String?
    var firstName: String
    var lastName: String
    
    private enum CodingKeys: String, CodingKey {
        case imgProfile = "img_profile"
        case firstName = "first_name"
        case lastName = "last_name"
        case pk, email, nickname
    }
}

struct login_User: Decodable {
    var token: String
    var user: user
}


struct MyPage: Codable {
   var pk: Int
   var email: String
   var nickName: String
   var profileImage: String?
   var totalRunnigTime: Int
   var checkedMovieCount: Int
   var stillImage: StillImage
   
   private enum CodingKeys: String, CodingKey {
      case pk, email
      case nickName = "nickname"
      case profileImage = "img_profile"
      case totalRunnigTime = "total_running_time"
      case checkedMovieCount = "interesting_movie_cnt"
      case stillImage = "still_cut_img"
   }
}


struct StillImage: Codable {
   var id: Int
   var movieId: Int
   var imageUrl: String
   var imageUrlWeb: String
   
   private enum CodingKeys: String, CodingKey {
      case id
      case movieId = "movie"
      case imageUrl = "still_img_x3"
      case imageUrlWeb = "still_img"
   }
}

```

<!--1. Cocoapods을 이용한 오픈소스 라이브러리 사용--> 
<!--2. Alamofire 이용한 네트워크 통신 -->
<!--3. FacebookLogin SDK를 이용한 로그인 방식 적용 -->
<!--4. 회원가입 에러처리 Animation 적용-->
<!--5. 회원가입 정규식 처리-->
<!--6. 데이터 모델링-->

## 문제점

- 로그인하고 메인 화면에서 왼쪽 끝에서 오른쪽으로 제스쳐를 넣으면 다시 로그인으로 돌아갔다.

> 이는 show segue로 화면 전환을 주어서 문제가 되었던 것 같다. show segue는 stack구조로서 원래 화면 위에 새 화면을 덮는 형식이다. 이를 해결하기 위해서는 로그인 성공 후에 첫화면을 루트뷰로 설정하면 될 것 같다.

