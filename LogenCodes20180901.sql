BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS `codelist` (
	`category`	TEXT NOT NULL,
	`code`	INTEGER NOT NULL,
	`region1`	TEXT NOT NULL,
	`region2`	TEXT NOT NULL,
	`branch`	TEXT NOT NULL,
	`area`	TEXT NOT NULL,
	`color`	TEXT NOT NULL,
	PRIMARY KEY(`code`)
);
INSERT INTO `codelist` (category,code,region1,region2,branch,area,color) VALUES ('A4',201,'서울권','강남','서강남','논현동,신사동,압구정동','ff8c8c'),
 ('G3',202,'서울권','강동','서강동','성내동,암사동,천호동','ff8c8c'),
 ('A6',203,'서울권','강서','북강서','가양동,개화동,등촌동,마곡동,방화동,염창동','ff8c8c'),
 ('A6',204,'서울권','금천','북금천','독산동,시흥동','ff8c8c'),
 ('A4',205,'서울권','구로','동구로','가리봉동,구로동,신도림동','ff8c8c'),
 ('G2',206,'서울권','은평','서은평','갈현동,구산동,대조동,수색동,신사동,역촌동,증산동','ff8c8c'),
 ('G3',207,'서울권','노원','북노원','상계동,중계동','ff8c8c'),
 ('G3',208,'서울권','도봉','도봉','도봉구','ff8c8c'),
 ('A5',209,'서울권','서초','동서초','내곡동,서초동,신원동,양재동,염곡동,우면동,원지동','ff8c8c'),
 ('A4',210,'서울권','서대문','서대문','서대문구','ff8c8c'),
 ('G3',211,'서울권','송파','북송파','삼전동,신천동,잠실동','ff8c8c'),
 ('G3',212,'서울권','용산','동용산','갈월동,남영동,동자동,용산동,이촌동,이태원동,한강로,후암동
','ff8c8c'),
 ('A4',213,'서울권','영등포','동영등포','문래동,대림동,당산동,신길동','ff8c8c'),
 ('G4',214,'서울권','종로','서종로','가회동,견지동,경운동,계동,공평동,관수동,관철동,관훈동,교남동,교북동,구기동,궁정동,권농동,낙원동,내수동,내자동,누상동,누하동,당주동,도렴동,돈의동,묘동,무악동,봉익동,부암동,사간동,사직동,삼청동,서린동,세종로,세종로1번지,소격동,송월동,송현동,수송동,신교동,신문로,신영동,안국동,옥인동,와룡동,운니동,원서동,익선동,인사동,장사동,재동,적선동,종로1~3가,중학동,창성동,청운동,청진동,체부동,통의동,통인동,팔판동,평동,평창동,필운동,행촌동,홍지동,홍파동,화동,효자동,훈정동
','ff8c8c'),
 ('G3',215,'서울권','중구','남중구','동중구(G5-228) 관할구역 외 전지역,을지로1~4가,동국대,충정로1가 50~80','ff8c8c'),
 ('G4',216,'서울권','동작','서동작
','대방동,상도동,신대방동
','ff8c8c'),
 ('G4',217,'서울권','광진','북광진
','광장동,구의동,중곡동
','ff8c8c'),
 ('A3',218,'서울권','양천','동양천','목동,신월2,4,6동 *목동아파트1~7단지까지 목동','ff8c8c'),
 ('G5',219,'서울권','강북','강북','강북구','ff8c8c'),
 ('A5',220,'서울권','관악','북관악','(구)신림동,난곡동,난향동,대학동,미성동,삼성동,서림동,서원동,신림동,신사동,신원동,조원동','ff8c8c'),
 ('G6',221,'서울권','동대문','서동대문','신설동,용두동,이문동,제기동,청량리동,회기동','ff8c8c'),
 ('A3',222,'서울권','마포','서마포','동교동,망원동,상암동,서교동,성산동,연남동,중동,합정동','ff8c8c'),
 ('G6',223,'서울권','중랑','중랑','중랑구','ff8c8c'),
 ('G6',224,'서울권','성북','서성북','돈암동,동선동,동소문동,보문동,삼선동,성북동,안암동,정릉동','ff8c8c'),
 ('G5',225,'서울권','성동','남성동','성수1가동,성수2가동,송정동,용답동','ff8c8c'),
 ('D1',226,'서울권','강남','동강남','역삼동,대치동','ff8c8c'),
 ('G5',227,'서울권','용산','서용산','도원동,동빙고동,문배동,보광동,산천동,서계동,서빙고동,신계동,신창동,용문동,원효로,주성동,청암동,청파동,한남동,효창동','ff8c8c'),
 ('G5',228,'서울권','중구','동중구','광희동,다산동,동화동,무학동,묵정동,방산동,신당동,쌍림동,약수동,오장동,을지로5~7가,장충동,주교동,청구동,흥인동,황학동','ff8c8c'),
 ('A3',229,'서울권','서초','남서초','반포동,방배동,잠원동','ff8c8c'),
 ('A3',230,'서울권','영등포','서영등포','도림동,양평동,양화동,여의도동,영등포본동,영등포동','ff8c8c'),
 ('G5',231,'서울권','송파','남송파','가락동,거여동,마천동,문정동,오금동,장지동','ff8c8c'),
 ('A3',232,'서울권','마포','동마포','공덕동,구수동,노고산동,당인동,대흥동,도화동,마포동,상수동,신공덕동,신수동,신정동,아현동,염리동,용강동,창전동,토정동,하중동,현석동','ff8c8c'),
 ('A3',233,'서울권','강서','남강서','공항동,과해동,내발산동,오곡동,오쇠동,외발산동,우장산동,화곡동','ff8c8c'),
 ('G5',234,'서울권','노원','남노원','공릉동,월계동,하계동','ff8c8c'),
 ('A4',235,'서울권','구로','서구로','개봉동,고척동,궁동,오류동,온수동,천왕동,항동','ff8c8c'),
 ('A5',236,'서울권','관악','남관악','(구)봉천동,낙성대동,남현동,보라매동,성현동,은천동,인헌동,중앙동,청림동,청룡동,행운동,*서울대학교','ff8c8c'),
 ('G3',237,'서울권','강동','동강동','강일동,고덕동,길동,둔촌동,명일동,상일동','ff8c8c'),
 ('A3',238,'서울권','양천','서양천','신월1,3,5,7동,신정동 * 목동아파트8~14단지까지 신정동','ff8c8c'),
 ('G2',239,'서울권','은평','동은평','녹번동,불광동,응암동,진관동','ff8c8c'),
 ('G3',240,'서울권','송파','동송파','방이동,석촌동,송파동,오륜동,풍납동','ff8c8c'),
 ('A3',241,'서울권','강남','남강남','개포동,도곡동,수서동,세곡동,율현동,일원동,자곡동,포이동','ff8c8c'),
 ('G6',242,'서울권','동대문','남동대문','답십리동,장안동,전농동,휘경동','ff8c8c'),
 ('G6',243,'서울권','성북','동성북','길음동,상월곡동,석관동,장위동,종암동,하월곡동','ff8c8c'),
 ('A6',244,'서울권','금천','남금천','가산동','ff8c8c'),
 ('G4',245,'서울권','종로','동종로','동숭동,명륜동,숭인동,연건동,연지동,예지동,원남동,이화동,인의동,종로4~6가,창신동,충신동,혜화동,효제동','ff8c8c'),
 ('D1',246,'서울권','강남','북강남','삼성동,청담동','ff8c8c'),
 ('G4',247,'서울권','광진','남광진','군자동,능동,자양동,화양동
','ff8c8c'),
 ('G4
',248,'서울권','동작','동동작','노량진동,동작동,본동,사당동,흑석동
','ff8c8c'),
 ('G5',249,'서울권','성동','북성동','금호1가동~금호4가동,도선동,마장동,사근동,옥수동,왕십리동,응봉동,행당동,홍익동
','ff8c8c'),
 ('D1',301,'경기권','고양','서일산','일산서구[구산동,덕이동,일산동(1,2,3동),일산동 산들마을3,5,6단지,탄현동]','fff557'),
 ('B2',302,'경기권','이천','이천','이천시','fff557'),
 ('E6',303,'경기권','부천','서부천','상1,2,3동,중1,2,3,4동','fff557'),
 ('B2',304,'경기권','성남','성남중원','중원구','fff557'),
 ('B6',305,'경기권','수원','동수원','영통구','fff557'),
 ('E3',306,'경기권','안산','서안산','단원구[목내동,성곡동,신길동,원곡동,원시동,초지동]','fff557'),
 ('B6',307,'경기권','안양','동안양','동안구(관양동,귀인동,부림동,평안동,평촌동)','fff557'),
 ('D1',308,'경기권','의정부','동의정부','고산동,금오동,낙양동,민락동,산곡동,송산동,신곡1,2동,용현동,자금동,자일동,장암동
','fff557'),
 ('E2',309,'경기권','파주','교하','교하동,다율동,당하동,동패동,목동동,문발동,산남동,상지석동,서패동,송촌동,신촌동,야당동,연다산동,오도동,와동동,운정동,조리읍,하지석동','fff557'),
 ('A6',310,'경기권','평택','동평택','가재동,군문동,도일동,독곡동,동삭동,모곡동,비전동,서정동,세교동,소사동,신대동,신장동,용이동,월곡동,유천동,이충동,장당동,장안동,죽백동,지산동,지제동,진위면,칠괴동,칠원동,통복동,평택동,합정동','fff557'),
 ('E4',311,'경기권','파주','파주','검산동,광탄면,군내면,금능동,금촌동,맥금동,문산읍,법원읍,아동동,야동동,월롱면,장당면,적성면,진동면,진서면,탄현면,파주읍,파평면','fff557'),
 ('D1',312,'경기권','하남','하남','하남시','fff557'),
 ('D1',313,'경기권','구리','구리','구리시','fff557'),
 ('E3',314,'경기권','김포','동김포','감정동,걸포동,고촌읍,북변동,사우동,운양동,장기동,풍무동
','fff557'),
 ('D1',315,'경기권','포천','포천','포천시','fff557'),
 ('E5',316,'경기권','광명','광명','광명시','fff557'),
 ('B5',317,'경기권','군포','군포','군포시','fff557'),
 ('D1',318,'경기권','양주','양주','양주시','fff557'),
 ('E3',319,'경기권','인천','남인천','남동구(고잔동,남촌동,논현동,도림동,만수동,서창동,수산동,운연동,장수동)','fff557'),
 ('E3',320,'경기권','인천','계양','계양구','fff557'),
 ('B5',321,'경기권','용인','처인','처인구','fff557'),
 ('B3',322,'경기권','화성','북화성','기배동,기산동,기안동,남양동,마도면,매송면,무송동,문호동,반월동,반정동,배양동,병점동,봉담읍,북양동,비봉면,서신면,송림동,송산동,송산면,수화동,시동,신남동,신외동,안녕동,안석동,온석동,원천동,장덕동,장전동,진안동,화산동,활초동,황계동,삼성전자 화성사업소 H1','fff557'),
 ('E4',323,'경기권','고양','동덕양','덕양구,강매동,내곡동,대장동,덕은동,신평동,용두동,토당동,행신동,행주내동,행주외동,향동,현천동,화전동,화정동
','fff557'),
 ('E4',324,'경기권','인천','인천남구','미추홀구(남구)','fff557'),
 ('E4',325,'경기권','인천','인천검단','서구[검암동,경서동,공촌동,금곡동,원당동(원당지구),당하동(당하지구),대곡동,마전동(마전지구),백석동,불로동,시천동,심곡동,오류동,왕길동,청라2,3동],*서인천[E4-358] 제외한 "인천시 서구" 전구역','fff557'),
 ('E2',326,'경기권','시흥','남시흥','거모동,군자동,월곶동,정왕동,죽율동,안산시 단원구(대부남동,대부동동,대부북동,선감동)','fff557'),
 ('B5',327,'경기권','안성','안성','안성시','fff557'),
 ('D1',328,'경기권','양평','양평','양평군,여주시(금사면,산북면)','fff557'),
 ('B5',329,'경기권','오산','오산','오산시','fff557'),
 ('E5',330,'경기권','부천','남부천','계수동,고강동,고강본동,괴안동,내동,대장동,범박동,삼정동(신흥동),소사본동,송내동,심곡본동,여월동(성곡동),오정동,옥길동,원종동,작동,역곡3동','fff557'),
 ('E5',331,'경기권','고양','동일산','일산동구[마두동,백석동,장항동,정발산동]','fff557'),
 ('E5',332,'경기권','안산','동안산','상록구','fff557'),
 ('D1',333,'경기권','남양주','서남양주','수동면,오남읍,진건읍,진접읍,퇴계원면,화도읍','fff557'),
 ('B5',334,'경기권','성남','동분당','분당구(분당동,서현동,수내동,야탑동,율동,이매동)','fff557'),
 ('B4',335,'경기권','수원','서수원','권선구','fff557'),
 ('B3',336,'경기권','용인','수지','수지구,기흥구 보정동(롯데마트 수지점),기흥구 마북동(단국대학교)','fff557'),
 ('B4',337,'경기권','안양','서안양','만안구','fff557'),
 ('D1',338,'경기권','연천','동두천','연천군','fff557'),
 ('E5',340,'경기권','인천','동부평','부평구(구산동,부개동,부평동,십정동,일신동)','fff557'),
 ('B3',341,'경기권','용인','남기흥','고매동,공세동,구갈동,농서동,보라동,상갈동,서천동,신갈동,영덕동,지곡동,하갈동
','fff557'),
 ('B3',342,'경기권','경기광주','동경기광주','경안동,곤지암읍,남종면,남한산성면,도척면,목현동,송정동,쌍련동,역동,초월읍,탄벌동,퇴촌면,회덕동
','fff557'),
 ('B3',343,'경기권','의왕','의왕과천','의왕시','fff557'),
 ('E5',344,'경기권','인천','인천연수구','연수구','fff557'),
 ('E5',345,'경기권','인천','인천중구','동구,중구,옹진군','fff557'),
 ('E2',346,'경기권','시흥','북시흥','계수동,과림동,광석동,금이동,논곡동,능곡동,대야동,도창동,매화동,목감동,무지내동,물왕동,미산동,방산동,산현동,신천동,안현동,은행동,장곡동,장현동,조남동,포동,하상동,하중동,화정동','fff557'),
 ('B6',347,'경기권','안양','북안양','동안구(갈산동,달안동,범계동,부흥동,비산동,신촌동,호계동)','fff557'),
 ('E3',348,'경기권','김포,인천
','서김포','강화군,구래동,누산리,대곶면,마산동,양곡리,월곶면,통진면,하성면,학운리
','fff557'),
 ('D1
',349,'경기권','가평','가평','가평군','fff557'),
 ('B3',350,'경기권','화성','남화성','양감면,우정읍,장안면,정남면,팔탄면,향남읍','fff557'),
 ('E6',351,'경기권','부천','동부천','도당동,소사동,심곡1,2,3동,약대동,역곡1,2동,원미1,2동,춘의동','fff557'),
 ('B2',352,'경기권','성남','성남수정','수정구','fff557'),
 ('D1',353,'경기권','남양주','동남양주','가운동,금곡동,도농동,별내면,별내동,별내읍,삼패동,수석동,양정동,와부읍,이패동,일패동,조안면,지금동,평내동,호평동','fff557'),
 ('B3',354,'경기권','성남','서분당','분당구[구미동,궁내동,금곡동,대장동,동원동,백현동,삼평동,석운동,운중동,정자동,판교동,하산운동]
','fff557'),
 ('B6',355,'경기권','수원','남수원','팔달구','fff557'),
 ('B4',356,'경기권','수원','북수원','장안구','fff557'),
 ('E3',357,'경기권','인천','인천중앙','남동구(간석동,구월동)','fff557'),
 ('E4',358,'경기권','인천','서인천','서구(가정동,가좌동,석남동,신현동,연희동,원창동,청라1동)','fff557'),
 ('B5',359,'경기권','화성','동탄','화성시 동탄면[능동,동탄동,반송동,석우동,영천동,오산동,청계동],동탄 제2신도시,삼성전자화성사업소H2,H3','fff557'),
 ('A6',360,'경기권','평택','서평택','고덕면,서탄면,안중읍,오성면,청북면,팽성읍,포승읍,현덕면','fff557'),
 ('E2',361,'경기권','고양','북일산','일산동구[문봉동,사리현동,산황동,설문동,성석동,식사동,중산동,중산동 산들마을 1,2단지,지영동,풍동]','fff557'),
 ('D1',362,'경기권','고양','남일산','일산서구[가좌동,주엽동,법곳동,대화동]','fff557'),
 ('E4',363,'경기권','고양','서덕양','덕양구,고양동,관산동,내유동,대자동,도내동,동산동,벽제동,북한동,삼송동,선유동,성사동,신원동,오금동,원당동,원흥동,주교동,지축동,효자동','fff557'),
 ('E5',364,'경기권','인천','서부평','부평구(갈산동,산곡동,삼산동,청천동)','fff557'),
 ('B3',365,'경기권','용인','북기흥','동백동,마북동,보정동,상하동,언남동,중동,청덕동
','fff557'),
 ('D1',366,'경기권','의정부','서의정부','가능1,2,3동,녹양동,의정부1,2,3동,호원1,2동,흥선동
','fff557'),
 ('E3',367,'경기권','안산','남안산','단원구[고잔동,선부동,와동,화정동]','fff557'),
 ('B2',369,'경기권','여주','여주','여주시','fff557'),
 ('B3',372,'경기권','경기광주','서경기광주','목동,삼동,오포읍,장지동,중대동,직동,태전동
','fff557'),
 ('M1',401,'충청권','대전','서대전','서구[가수원동,가장동,관저동,괴곡동,괴정동,기성동,내동,도마동,도안동,매노동,변동,복수동,봉곡동,산직동,오동,용문동,용촌동,우명동,원정동,장안동,정림동,평촌동,흑석동]','8ae249'),
 ('M8',402,'충청권','서산','서산','서산시','8ae249'),
 ('A5',403,'충청권','천안','동천안','동남구,서북구 와촌동','8ae249'),
 ('M1',404,'충청권','청주','서청주','청주시 흥덕구 ''동''지역','8ae249'),
 ('A2',405,'충청권','충주','충주','충주시','8ae249'),
 ('M8',406,'충청권','보령','보령','보령시','8ae249'),
 ('M1',407,'충청권','금산','금산','금산군','8ae249'),
 ('M1',408,'충청권','계룡,논산','논산','계룡시,논산시','8ae249'),
 ('M1',409,'충청권','예산','예산','예산군','8ae249'),
 ('M1',410,'충청권','홍성','홍성','홍성군','8ae249'),
 ('M8',411,'충청권','대전','동대전','대덕구','8ae249'),
 ('M8',412,'충청권','당진','당진','당진시','8ae249'),
 ('A5',413,'충청권','아산','아산','아산시','8ae249'),
 ('M7',414,'충청권','공주','공주','공주시,세종시 장군면','8ae249'),
 ('M7',415,'충청권','청주,증평','원청주','청주시 전체 ''읍,면''지역,증평군','8ae249'),
 ('A2',416,'충청권','음성','음성','음성군','8ae249'),
 ('M8',417,'충청권','영동','영동','영동군','8ae249'),
 ('M1',418,'충청권','청주','동청주','청주시 상당구 ''동''지역','8ae249'),
 ('M7',419,'충청권','세종','세종','세종시','8ae249'),
 ('M1',420,'충청권','청양','청양','청양군','8ae249'),
 ('A5',421,'충청권','천안','서천안','서북구,썅용동
','8ae249'),
 ('M7',422,'충청권','태안','태안','태안군','8ae249'),
 ('M8',423,'충청권','부여','부여','부여군','8ae249'),
 ('M1',424,'충청권','대전','북대전','유성구','8ae249'),
 ('M7',425,'충청권','대전','남대전','동구','8ae249'),
 ('M7',426,'충청권','서천','서천','서천군
','8ae249'),
 ('L1',427,'충청권','제천','제천','제천시','8ae249'),
 ('G2',428,'충청권','진천','진천','진천군','8ae249'),
 ('G2',429,'충청권','보은','보은','보은군','8ae249'),
 ('G2',430,'충청권','괴산','괴산','괴산군','8ae249'),
 ('M8',431,'충청권','옥천','옥천','옥천군','8ae249'),
 ('L1',432,'충청권','단양','단양','단양군','8ae249'),
 ('M7',433,'충청권','대전','대전중구','중구','8ae249'),
 ('M1',434,'충청권','대전','대전둔산','대전시 서구[갈마동,둔산동,만년동,월평동,탄방동]','8ae249'),
 ('M1',435,'충청권','청주','남청주','청주시 서원구 ''동''지역','8ae249'),
 ('M1',436,'충청권','청주','북청주
','청주시 청원구 ''동''지역','8ae249'),
 ('M1',501,'경상권','거창','거창','거창군','49bce2'),
 ('T7',502,'경상권','경주','경주','경주시','49bce2'),
 ('R7',503,'경상권','김해','서김해','강동,관동동,내덕동,대청동,명법동,무계동,부곡동,삼문동,수가동,신문동,유하동,율하동,응달동,이동,장유동,전하동,주촌면,진례면,진영읍,풍유동,한림면,화목동,흥동','49bce2'),
 ('M1',504,'경상권','구미','구미','구미시','49bce2'),
 ('T5',505,'경상권','대구','서대구','남구,서구,중구','49bce2'),
 ('R1',506,'경상권','창원','창원의창','의창구','49bce2'),
 ('T1',507,'경상권','경산','경산','경산시','49bce2'),
 ('A2',508,'경상권','안동','안동','안동시','49bce2'),
 ('T7',509,'경상권','사천','사천','사천시','49bce2'),
 ('T7',510,'경상권','진주','진주','진주시','49bce2'),
 ('T1',511,'경상권','통영','통영','통영시
','49bce2'),
 ('R7',512,'경상권','포항,울릉
','북포항','북구,울릉군','49bce2'),
 ('M1',513,'경상권','상주','상주','상주시','49bce2'),
 ('A2',514,'경상권','영주','영주','영주시','49bce2'),
 ('T1',515,'경상권','밀양','밀양','밀양시','49bce2'),
 ('T1',516,'경상권','하동','하동','하동군','49bce2'),
 ('M1',517,'경상권','김천','김천','김천시','49bce2'),
 ('T7',518,'경상권','양산','양산','양산시','49bce2'),
 ('R7',519,'경상권','영덕','영덕','영덕군','49bce2'),
 ('K7',520,'경상권','부산','부산북구','북구','49bce2'),
 ('K1',521,'경상권','부산','동래','동래구','49bce2'),
 ('K7',522,'경상권','부산','북해운대','해운대구[반송1,2,3동,반영1,2,3,4동,석대동,재송1,2동]
','49bce2'),
 ('K1',523,'경상권','부산','진구','부산진구','49bce2'),
 ('K7',524,'경상권','부산','중부산','동구,중구','49bce2'),
 ('K1',525,'경상권','부산','사하','사하구,서구','49bce2'),
 ('K7',526,'경상권','부산','사상','사상구','49bce2'),
 ('R1',527,'경상권','울산','남울산','남구[고사동,남화동,달동,두왕동,매암동,부곡동,삼산동,상개동,선암동,성암동,야음동,여천동,용연동,용잠동,장생포동,황성동]
','49bce2'),
 ('T7',528,'경상권','울산','동울산','동구','49bce2'),
 ('T1',529,'경상권','울산','울주','울주군','49bce2'),
 ('T7',530,'경상권','대구','동대구','동구','49bce2'),
 ('T1',531,'경상권','창원','마산합포','마산합포구','49bce2'),
 ('T7',532,'경상권','남해','남해','남해군','49bce2'),
 ('T1',533,'경상권','영천','영천','영천시','49bce2'),
 ('T7',534,'경상권','울진','울진','울진군','49bce2'),
 ('R1',535,'경상권','부산','금정','금정구','49bce2'),
 ('T7',536,'경상권','창원','진해','진해구','49bce2'),
 ('K1',537,'경상권','부산','남부산','남구','49bce2'),
 ('R7',538,'경상권','거제','거제','거제시,통영시 용남면(수도,어의리(어의도))','49bce2'),
 ('M1',539,'경상권','성주,칠곡','성주칠곡','칠곡군,성주군','49bce2'),
 ('T7',540,'경상권','창녕','창녕','창녕군','49bce2'),
 ('T1',541,'경상권','합천','합천','합천군','49bce2'),
 ('T7',542,'경상권','의성','의성','의성군','49bce2'),
 ('G2',543,'경상권','문경','문경','문경시','49bce2'),
 ('G2',544,'경상권','예천','예천','예천군','49bce2'),
 ('T5',545,'경상권','대구','남대구','달서구,달성군[다사읍,하빈면]','49bce2'),
 ('T7',546,'경상권','울산','북울산','북구','49bce2'),
 ('K7',547,'경상권','부산','부산강서','강서구','49bce2'),
 ('K7',548,'경상권','부산','영도','영도구','49bce2'),
 ('T1',549,'경상권','함안의령','함안의령','함안군,의령군','49bce2'),
 ('R7',550,'경상권','대구','대구수성','수성구,달성군 가창면','49bce2'),
 ('K1',551,'경상권','부산','연제','연제구','49bce2'),
 ('R7',552,'경상권','포항','남포항','남구','49bce2'),
 ('R7',553,'경상권','김해','동김해','구산동,내동,대동면,대성동,동상동,봉황동,부원동,불암동,삼계동,삼방동,삼정동,상동면,생림면,서상동,안동,어방동,외동,지내동','49bce2'),
 ('T7',554,'경상권','산청','산청','산청군','49bce2'),
 ('T5',555,'경상권','대구,고령
','대구달성','경북 고령군,달성군','49bce2'),
 ('R1',556,'경상권','창원','창원성산','성산구','49bce2'),
 ('K1',557,'경상권','부산','수영','수영구','49bce2'),
 ('T7',558,'경상권','울산','중울산','중구','49bce2'),
 ('M1',559,'경상권','함양','함양','함양군','49bce2'),
 ('T3',560,'경상권','대구','북대구','북구,칠곡군 동명면','49bce2'),
 ('T1',561,'경상권','창원','마산회원','마산회원구','49bce2'),
 ('T7',562,'경상권','부산','기장','기장군','49bce2'),
 ('T1',563,'경상권','청도','청도','청도군','49bce2'),
 ('M1',564,'경상권','군위','군위','군위군','49bce2'),
 ('T1',565,'경상권','고성','경남고성','경남 고성군','49bce2'),
 ('A2',566,'경상권','봉화','봉화','봉화군','49bce2'),
 ('R1',567,'경상권','울산','서울산','남구[무거동,삼호동,신정1,2,3,4,5동,옥동]
','49bce2'),
 ('A2',568,'경상권','영양청송','영양청송','영양군,청송군','49bce2'),
 ('K7',569,'경상권','부산','남해운대','해운대구[송정동,우1,2동,좌1,2,3,4동,중1,2동]
','49bce2'),
 ('J1',601,'전라권','광주','남광주','남구,동구','e080f5'),
 ('J7',602,'전라권','남원','남원','남원시','e080f5'),
 ('J1',603,'전라권','목포','목포','목포시','e080f5'),
 ('J7',604,'전라권','순천','순천','순천시','e080f5'),
 ('J1',605,'전라권','여수','여수','여수시','e080f5'),
 ('M8',606,'전라권','익산','익산','익산시','e080f5'),
 ('M8',607,'전라권','전주','남전주','완산구','e080f5'),
 ('J7',608,'전라권','해남','해남','해남군','e080f5'),
 ('J7',609,'전라권','고흥','고흥','고흥군','e080f5'),
 ('M8',610,'전라권','정읍','정읍','정읍시,순창군(복흥면,쌍치면)','e080f5'),
 ('M7',611,'전라권','군산','군산','군산시','e080f5'),
 ('J1',612,'전라권','구례','구례','구례군','e080f5'),
 ('J1',613,'전라권','나주','나주','나주시','e080f5'),
 ('J1',614,'전라권','광양','광양','광양시','e080f5'),
 ('J7',615,'전라권','담양','담양','담양군','e080f5'),
 ('J7',616,'전라권','강진','강진','강진군,완도군[고금면,금일읍,생일면(덕우도 제외),약산면]','e080f5'),
 ('M8',617,'전라권','무주','무주','무주군','e080f5'),
 ('M8',618,'전라권','김제','김제','김제시','e080f5'),
 ('J7',619,'전라권','보성','보성','보성군','e080f5'),
 ('J1',620,'전라권','영광','영광','영광군','e080f5'),
 ('J7',621,'전라권','광주','북광주','북구','e080f5'),
 ('J7',622,'전라권','임실','임실','임실군','e080f5'),
 ('J1',623,'전라권','무안','무안','무안군,신안군[지도읍,증도면,임자면]','e080f5'),
 ('J1',624,'전라권','영암','영암','영암군','e080f5'),
 ('J7',625,'전라권','화순','화순','화순군','e080f5'),
 ('M8',626,'전라권','진안','진안','진안군','e080f5'),
 ('J7',627,'전라권','장흥','장흥','장흥군,완도군 금당면','e080f5'),
 ('J7',628,'전라권','진도','진도','진도군','e080f5'),
 ('J1',629,'전라권','고창','고창','고창군','e080f5'),
 ('J1',630,'전라권','광주','서광주','서구','e080f5'),
 ('J7',631,'전라권','광주','광산','광산구','e080f5'),
 ('M8',632,'전라권','전주','북전주','덕진구','e080f5'),
 ('J7',633,'전라권','순창','순창','순창군','e080f5'),
 ('J7',634,'전라권','완도','완도','완도군,생일면 덕우도','e080f5'),
 ('M8',635,'전라권','부안','부안','부안군','e080f5'),
 ('J7',636,'전라권','장수','장수','장수군','e080f5'),
 ('J1',637,'전라권','함평','함평','함평군','e080f5'),
 ('J1',638,'전라권','곡성','곡성','곡성군','e080f5'),
 ('J7',639,'전라권','장성','장성','장성군','e080f5'),
 ('M8',640,'전라권','완주','완주','완주군','e080f5'),
 ('J1',643,'전라권','신안','신안','신안군','e080f5'),
 ('L1',701,'강원권','강릉','강릉','강릉시,양양군 현남면','d4ab3b'),
 ('L1',702,'강원권','삼척','삼척','삼척시','d4ab3b'),
 ('L1',703,'강원권','영월','영월','영월군','d4ab3b'),
 ('W1',704,'강원권','양양','속초','양양군','d4ab3b'),
 ('L1',705,'강원권','동해','동해','동해시','d4ab3b'),
 ('L1',706,'강원권','원주','동원주','개운동,관설동,단구동,명륜동,반곡동,봉산동,소초면,신림면,중앙동,태장동,판부면,행구동','d4ab3b'),
 ('W1',708,'강원권','춘천','춘천','춘천시','d4ab3b'),
 ('W1',709,'강원권','홍천','홍천','홍천군','d4ab3b'),
 ('L1',710,'강원권','태백','태백','태백시,삼척시(도계읍,하장면)','d4ab3b'),
 ('L1',711,'강원권','평창','평창','평창군','d4ab3b'),
 ('W1',712,'강원권','화천','화천','화천군,춘천시 사북면','d4ab3b'),
 ('W1',713,'강원권','인제','인제','인제군','d4ab3b'),
 ('L1',714,'강원권','횡성','횡성','횡성군','d4ab3b'),
 ('L1',715,'강원권','정선','정선','정선군','d4ab3b'),
 ('L1',716,'강원권','고성','고성','고성군','d4ab3b'),
 ('D1',717,'강원권','철원','철원','철원군','d4ab3b'),
 ('W1',718,'강원권','양구','양구','양구군','d4ab3b'),
 ('L1',719,'강원권','원주','서원주','가현동,귀래면,단계동,무실동,문막읍,부론면,우산동,원동,인동,일산동,지정면,평원동,학성동,호저면,흥업면
','d4ab3b'),
 ('Y3',801,'제주권','제주','동제주','제주시[건입동,구좌읍,도남동,도련동,봉개동,삼도동,삼양동,아라동,영평동,오등동,오라동,용강동,월평동,이도동,일도동,조천읍,화북동,회천동],서귀포시[성산읍,표선면],우도면,추자면','ebd496'),
 ('Y1',802,'제주권','서귀포','서귀포','서귀포시 동단위,서귀포시[남원읍]','ebd496'),
 ('Y3',803,'제주권','제주','서제주','제주시[내도동,노형동,도두동,도평동,애월읍,연동,외도동,용담동,이호동,한경면,한림읍,해안동],서귀포시[대정읍,안덕면]','ebd496');
COMMIT;
