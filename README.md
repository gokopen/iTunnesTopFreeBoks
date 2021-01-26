# iTunnesTopFreeBoks

--- SON SÜRÜM ---
İlk sürümde çok fazla zamanım yoktu ve demo projesinde bir takım şeylerlerle çok zaman kaybetmiştim. Anca vakit bulabildim ve ciddi oranda toparladım. Değişiklikler;

Swift dilinin bazı sıkıntılarından dolayı generic setlediğim bazı layerlar (presenter, viewController vs.) aslında classın tamamını baz almıştı bu sebepten dolayı izolasyon ve protocol orriented programming sağlanamamıştı düzeltildi.
Bu çalışmayı yaptığım zamanda yeterli zaman olmaması ve özellikle kurmak istediğim yapıyla çok uğraşmam dolayısıyla modüller için unit teste zaman ayıramamıştım şuanda sadece Home modülü için detaylı bir unit test yapısı kurdum. ViewController - Presenter - Interactor ilişkisi HomeModuleTest içinde test edilebiliyor.
Generic yapılar ile her modül layerının (presenter, viewController, interactor vs.) super classta da iletişim kurabilmesi ve pratik bir yapıyla daha rahat erişilebilir olmalarına çok uğraşmıştım ancak çok tutarlı bir yapı olmamıştı. Şuanda bu konuda daha da iyi yapı kurguladım. Bir tek Home'da biraz daha farklılaşıp type castingi doğrudan yaparak viewController ve interactor çekiliyor çünkü ne yaparsam yapayım Swift dili dışardan paremetre ile daha farklı bir Type setlemeye izin vermiyor mockViewController ve mockInteractor kullanabilmek için bunları burada böyle kullanmak gerekti. 
Routerlar kendi içinde yaratılıp utils gibi kullanmak yerine RouterInitializer aracılığıyla yaratılması sağlandı. Bu yaklaşım daha doğru. Böylece super class'taki gerekmeyen kodlar tekrar  tekrar gelmemiş olması sağlandı ve bu amaca yönelik bir class ile bu iş yapılmış oldu.

---- İLK SÜRÜM ----
Bu uygulama ilettilen projeye göre tasarlanmıştır. 
Talebe göre 3 tablı yapı entegre edilmiştir.
Görsel tasarımlara önem verilmemiştir mimariye ağırlık verilmiştir.
VIPER mimarisi seçilmiştir. İçi boş gözüken yerler olsa da aslında tekrarlayan işler super classlarda pratik bir şekilde çözülmüştür. Core klasörüne bakınız.
Vakit darlığından daha iyi yapılabilecek kısımları var ancak bu kadar yetiştirebildim. 
Loading ve error handlinge yeterince vakit olmadı.
Proje içi daha kapsamlı Unit test yazılabilirdi vakit olmadı.
Hiçbir 3. parti kütüphane kurulmaması istendiğinden bazı şeyler çok ciddi zaman kaybettirdi. Örneğin Network iletişimi için Alamofire, resimlerin yüklenmesinde Kingfisher, observable yapılar içinde RxSwift kullanılsa daha hızlı yapabilirdim. Bu noktada ihtiyaçları kendim yazmam gerektiğinden bazı diğer şeylere odaklanacak vakit bulamadım.
Örnek api pagination için uygun değildi ancak kendimce bir yolla bir çözüm ürettim. 
Normalde aynı business işi yapan kodları toplarım ve tek yerden yönetirim ancak bunu yapsaydım proje anlaşılamaz duruma gelecekti VIPER örneği için dolayısıyla kod tekrarlarını bilerek yaptım bazı yerlerde.
Swift dilinde Generic yapılar biraz dertli olabiliyor  çok detaya girmeyeceğim ama Presenterda güzel yapı kurgulansada diğer ViewController ve Interactor vs. gibi parçalarda typealias ile cast edilerek çözmek zorunda kaldım. İStediğim yapıyı tam kuramadım ama idare eder bir yapı oldu. VM yapısında bunu oturtsamda VIPER da daha fazla katman var daha iyisi için daha fazla vakit lazımdı.
