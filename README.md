# iTunnesTopFreeBoks

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
