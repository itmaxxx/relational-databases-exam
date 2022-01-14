----------------------------------------------
-- Title:	WorldCup 2010 Exam Paper    --
-- Author:	Max Dmitriev                --
-- Date:	13.12.2019                  --
----------------------------------------------

IF DB_ID('WorldCup2010') IS NOT NULL
    DROP DATABASE WorldCup2010
GO

CREATE DATABASE WorldCup2010
GO

USE WorldCup2010
GO

CREATE TABLE Countries
(
	Id int NOT NULL PRIMARY KEY IDENTITY(1, 1),
	Name varchar(25)
)
GO

CREATE TABLE Cities
(
	Id int NOT NULL PRIMARY KEY IDENTITY(1, 1),
	Name varchar(25)
)
GO

CREATE TABLE Stadiums
(
	Id int NOT NULL PRIMARY KEY IDENTITY(1, 1),
	Name varchar(25),
	Capacity bigint,
	CityFK int,

	FOREIGN KEY (CityFK) REFERENCES Cities(Id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
)
GO

CREATE TABLE Equipments
(
	Id int NOT NULL PRIMARY KEY IDENTITY(1, 1),
	Name varchar(25)
)
GO

CREATE TABLE FAssociation
(
	Id int NOT NULL PRIMARY KEY IDENTITY(1, 1),
	Name varchar(25)
)
GO

CREATE TABLE Referees
(
	Id int NOT NULL PRIMARY KEY IDENTITY(1, 1),
	FirstName varchar(25),
	LastName varchar(25),
	CountryFK int,
	FAssociationFK int,

	FOREIGN KEY (FAssociationFK) REFERENCES FAssociation(Id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	FOREIGN KEY (CountryFk) REFERENCES Countries(Id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION 
)
GO

CREATE TABLE Coaches
(
	Id int NOT NULL PRIMARY KEY IDENTITY(1, 1),
	FirstName varchar(25),
	LastName varchar(25),
	CountryFK int,

	FOREIGN KEY (CountryFK) REFERENCES Countries(Id)
		ON DELETE NO ACTION
)
GO

CREATE TABLE Positions
(
	Id int NOT NULL PRIMARY KEY IDENTITY(1, 1),
	Name varchar(25)
) 
GO

CREATE TABLE Players
(
	Id int NOT NULL PRIMARY KEY IDENTITY(1, 1),
	FirstName varchar(25),
	LastName varchar(25),
	PositionFK int,
	CountryFK int,

	FOREIGN KEY (PositionFK) REFERENCES Positions(Id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	FOREIGN KEY (CountryFK) REFERENCES Countries(Id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
)
GO

CREATE TABLE MatchTypes
(
	Id int PRIMARY KEY IDENTITY(1, 1),
	Name varchar(25)
)
GO

CREATE TABLE Matches
(
	Id int PRIMARY KEY IDENTITY(1, 1),
	[DateTime] datetime,
	Score1 int,
	Score2 int,
	StadiumFK int,
	Viewers int,
	MatchTypeFK int,
	Team1FK int,
	Team2FK int,

	FOREIGN KEY (StadiumFK) REFERENCES Stadiums(Id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	FOREIGN KEY (MatchTypeFK) REFERENCES MatchTypes(Id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	FOREIGN KEY (Team1FK) REFERENCES Countries(Id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	FOREIGN KEY (Team2FK) REFERENCES Countries(Id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
)
GO

CREATE TABLE FavoritePlayers
(
	Id int PRIMARY KEY IDENTITY(1, 1),
	MatchFK int,
	PlayerFK int,
	Minutes int,

	FOREIGN KEY (MatchFK) REFERENCES Matches(Id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	FOREIGN KEY (PlayerFK) REFERENCES Players(Id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
)

CREATE TABLE GroupStageResults
(
	Id int PRIMARY KEY IDENTITY(1, 1),
	CountryFK int,
	Score int DEFAULT 0,
	[Group] int

	FOREIGN KEY (CountryFK) REFERENCES Countries(Id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
)
GO

CREATE TABLE Final1_8Results
(
	Id int PRIMARY KEY IDENTITY(1, 1),
	CountryFK int,
	Score int DEFAULT 0,

	FOREIGN KEY (CountryFK) REFERENCES Countries(Id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
)
GO

CREATE TABLE Final1_4Results
(
	Id int PRIMARY KEY IDENTITY(1, 1),
	CountryFK int,
	Score int DEFAULT 0,

	FOREIGN KEY (CountryFK) REFERENCES Countries(Id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
)
GO

CREATE TABLE Final1_2Results
(
	Id int PRIMARY KEY IDENTITY(1, 1),
	CountryFK int,
	Score int DEFAULT 0,

	FOREIGN KEY (CountryFK) REFERENCES Countries(Id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
)
GO

CREATE TABLE FinalCupResults
(
	Id int PRIMARY KEY IDENTITY(1, 1),
	CountryFK int,
	Place int DEFAULT 0,

	FOREIGN KEY (CountryFK) REFERENCES Countries(Id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
)
GO

INSERT INTO Countries (Name) VALUES ('Австралия'), ('КНДР'), ('Республика Корея'), ('Япония'), ('Алжир'), ('Гана'), ('Камерун'), 
('Кот-д’Ивуар'), ('Нигерия'), ('ЮАР'), ('Гондурас'), ('Мексика'), ('США'), ('Аргентина'), ('Бразилия'), ('Парагвай'), ('Уругвай'), 
('Чили'), ('Новая Зеландия'), ('Англия'), ('Германия'), ('Греция'), ('Дания'), ('Испания'), ('Италия'), ('Нидерланды'), ('Португалия'), 
('Сербия'), ('Словакия'), ('Словения'), ('Франция'), ('Швейцария')

INSERT INTO Cities (Name) VALUES ('Bloemfontein'), ('Cape Town'), ('Durban'), ('Johannesburg'), ('Kimberley'), ('Klerksdorp'), 
('Nelspruit'), ('Orkney'), ('Polokwane'), ('Port Elizabeth'), ('Pretoria'), ('Rustenburg')

INSERT INTO Stadiums (Name, Capacity, CityFK) VALUES ('Soccer City', 84490, 4), ('Cape town', 64100, 2), ('Moses Mabida', 62760, 3), 
('Coca-Cola Park', 55686, 4), ('Loftus Versfeld', 42858, 11), ('Nelson Mandela Bay', 42486, 10), ('Peter Mokaba', 41733, 9), 
('Mbombela', 40929, 7), ('Free-State', 40911, 1), ('Royal Bafokeng', 38646, 12)

INSERT INTO Equipments (Name) VALUES ('Adidas'), ('Nike'), ('Puma'), ('Umbro'), ('Joma'), ('Brooks'), ('Legea')

INSERT INTO FAssociation (Name) VALUES ('AFC'), ('CAF'), ('CONCACAF'), ('CONMEBOL'), ('OFC'), ('UEFA')

INSERT INTO Referees (FirstName, LastName, FAssociationFK) VALUES ('Халил', 'Аль-Гамди', 1), ('Равшан', 'Ирматов', 1), 
('Субхиддин', 'Мохд Саллех', 1), ('Юити', 'Нисимура', 1), ('Коман', 'Кулибали', 2), ('Джером', 'Деймон', 2), ('Эдди', 'Майе', 2), 
('Хоэль', 'Агилар', 3), ('Бенито', 'Арчундиа', 3), ('Карлос', 'Батрес', 3), ('Марко', 'Родригес', 3), ('Эктор', 'Бальдасси', 4), 
('Хорхе', 'Ларрионда', 4), ('Пабло', 'Посо', 4), ('Оскар', 'Руис', 4), ('Карлуш', 'Симон', 4), ('Мартин', 'Васкес', 4), 
('Майкл', 'Хестер', 5), ('Питер', 'ОЛири', 5), ('Олегарио', 'Бенкеренса', 6), ('Массимо', 'Бузакка', 6), ('Франк', 'Де Блекере', 6),
('Мартин', 'Ханссон', 6), ('Виктор', 'Кашшаи', 6), ('Стефан', 'Ланнуа', 6), ('Роберто', 'Розетти', 6), ('Вольфганг', 'Штарк', 6), 
('Альберто', 'Ундиано', 6), ('Ховард', 'Уэбб', 6)

INSERT INTO Coaches (FirstName, LastName, CountryFK) VALUES ('Пим', 'Вербеек', 12), ('Рабах', 'Саадан', 3), ('Фабио', 'Капелло', 12), 
('Диего', 'Марадона', 3), ('Дунга', NULL, 12), ('Милован', 'Раевац', 3), ('Йоахим', 'Лёв', 12), ('Отто', 'Рехагель', 12),
('Рейнальдо', 'Руэда', 3), ('Мортен', 'Ольсен', 12), ('Висенте', 'дель Боске', 3), ('Марчелло', 'Липпи', 12), ('Поль', 'Ле Гуэн', 12)

INSERT INTO Positions (Name) VALUES ('Вратарь'), ('Защитник'), ('Полузащитник'), ('Нападающий')

INSERT INTO MatchTypes (Name) VALUES ('Групповой матч'), ('1/8'), ('1/4'), ('1/2'), ('Третье место'), ('Финал')

INSERT Players (PositionFK, FirstName, LastName) VALUES (1,'Moeneeb','Josephs'),(1,'Itumeleng','Khune'),(1,'Shu-Aib','Walters'),
(2,'Siboniso','Gaxa'),(2,'Tsepo','Masilela'),(2,'Aaron','Mokoena'),(2,'Anele','Ngcongca'),(2,'Matthew','Booth'),(2,'Lucas','Thwala'),
(2,'Bongani','Khumalo'),(2,'Siyabonga','Sangweni'),(3,'MacBeth','Sibaya'),(3,'Lance','Davids'),(3,'Siphiwe','Tshabalala'),
(3,'Steven','Pienaar'),(3,'Teko','Modise'),(3,'Reneilwe','Letsholonyane'),(3,'Kagisho','Dikgacoi'),(3,'Surprise','Moriri'),
(3,'Thanduyise','Khuboni'),(4,'Katlego','Mphela'),(4,'Bernard','Parker'),(4,'Siyabonga','Nomvethe'),(1,'?scar','P?rez'),
(1,'Guillermo','Ochoa'),(1,'Luis','Ernesto'),(2,'Francisco','Rodr?guez'),(2,'Carlos','Salcido'),(2,'Rafael','M?rquez (c)'),
(2,'Ricardo','Osorio'),(2,'Paul','Aguilar'),(2,'H?ctor','Moreno'),(2,'Efra?n','Ju?rez'),(2,'Jonny','Magall?n'),(2,'Jorge','Torres'),
(3,'Gerardo','Torrado'),(3,'Pablo','Barrera'),(3,'Israel','Castro'),(3,'Andr?s','Guardado'),(3,'Alberto','Medina'),(4,'Guillermo','Franco'),
(4,'Cuauht?moc','Blanco'),(4,'Carlos','Vela'),(4,'Javier','Hern?ndez'),(4,'Giovani','Santos'),(4,'Adolfo','Bautista'),
(1,'Fernando','Muslera'),(1,'Juan','Castillo'),(1,'Mart?n','Silva'),(2,'Diego','Lugano (c)'),(2,'Diego','God?n'),(2,'Jorge','Fucile'),
(2,'Mauricio','Victorino'),(2,'Maxi','Pereira'),(2,'Andr?s','Scotti'),(2,'Mart?n','C?ceres'),(3,'Walter','Gargano'),
(3,'Sebasti?n','Eguren'),(3,'?lvaro','Pereira'),(3,'Nicol?s','Lodeiro'),(3,'Diego','P?rez'),(3,'Egidio','R?os'),(3,'Ignacio','Gonz?lez'),
(3,'?lvaro','Fern?ndez'),(4,'Edinson','Cavani'),(4,'Luis','Su?rez'),(4,'Diego','Forl?n'),(4,'Sebasti?n','Abreu'),(4,'Sebasti?n','Fern?ndez'),
(1,'Hugo','Lloris'),(1,'Steve','Mandanda'),(1,'C?dric','Carrasso'),(2,'Bacary','Sagna'),(2,'?ric','Abidal'),(2,'Anthony','R?veill?re'),
(2,'William','Gallas'),(2,'Marc','Planus'),(2,'Patrice','Evra (c)'),(2,'S?bastien','Squillaci'),(2,'Ga?l','Clichy'),(3,'Franck','Rib?ry'),
(3,'Yoann','Gourcuff'),(3,'J?r?my','Toulalan'),(3,'Florent','Malouda'),(3,'Alou','Diarra'),(3,'Abou','Diaby'),(3,'Mathieu','Valbuena'),
(4,'Djibril','Ciss?'),(4,'Sidney','Govou'),(4,'Andr?-Pierre','Gignac'),(4,'Thierry','Henry'),(4,'Nicolas','Anelka'),(1,'Diego','Pozo'),
(1,'Mariano','And?jar'),(1,'Sergio','Romero'),(2,'Mart?n','Demichelis'),(2,'Clemente','Rodr?guez'),(2,'Nicol?s','Burdisso'),(2,'Gabriel','Heinze'),
(2,'Ariel','Garc?'),(2,'Walter','Samuel'),(2,'Nicol?s','OtamENDi'),(3,'Mario','Bolatti'),(3,'?ngel','Marea'),(3,'Juan','Sebastian'),
(3,'Javier','Mascherano (c)'),(3,'Jon?s','Guti?rrez'),(3,'Maxi','Rodr?guez'),(3,'Javier','Pastore'),(4,'Gonzalo','Higua?n'),(4,'Lionel','Messi'),
(4,'Carlos','T?vez'),(4,'Sergio','Ag?ero'),(4,'Mart?n','Palermo'),(4,'Diego','Milito'),(1,'Vincent','Enyeama'),(1,'Austin','Ejide'),(1,'Dele','Aiyenugba'),
(2,'Joseph','Yobo (c)'),(2,'Taye','Taiwo'),(2,'Rabiu','Afolabi'),(2,'Danny','Shittu'),(2,'Chidi','Odiah'),(2,'Uwa','Echi?jil?'),(2,'Dele','Adeleye'),
(3,'Ayila','Yussuf'),(3,'Sani','Kaita'),(3,'Lukman','Haruna'),(3,'Dickson','Etuhu'),(4,'Nwankwo','Kanu'),(4,'John','Utaka'),(4,'Yakubu','Aiyegbeni'),
(4,'Obafemi','Martins'),(4,'Brown','Ideye[4]'),(4,'Peter','Odemwingie'),(4,'Kalu','Uche'),(4,'Victor','Obinna'),(4,'Chinedu','Obasi'),
(1,'Lee','Woon-Jae'),(1,'Jung','Sung-Ryong'),(1,'Kim','Young-Kwang'),(2,'Oh','Beom-Seok'),(2,'Kim','Hyung-Il'),(2,'Lee','Young-Pyo'),(2,'Lee','Jung-Soo'),
(2,'Kim','Dong-Jin'),(2,'Cha','Du-Ri'),(2,'Kang','Min-Soo'),(3,'Cho','Yong-Hyung'),(3,'Kim','Nam-Il'),(3,'Kim','Bo-Kyung'),(3,'Park','Ji-Sung (c)'),
(3,'Kim','Jae-Sung'),(3,'Ki','Sung-Yong'),(3,'Lee','Chung-Yong'),(4,'Kim','Jung-Woo'),(4,'Ahn','Jung-Hwan'),(4,'Park','Chu-Young'),(4,'Lee','Seung-Yeoul'),
(4,'Yeom','Ki-Hun'),(4,'Lee','Dong-Gook'),(1,'Kostas','Chalkias'),(1,'Alexandros','Tzorvas'),(1,'Michalis','Sifakis'),(2,'Giourkas','Seitaridis'),
(2,'Christos','Patsatzoglou'),(2,'Vangelis','Moras'),(2,'Avraam','Papadopoulos'),(2,'Loukas','Vyntra'),(2,'Vasilis','Torosidis'),(2,'Sotirios','Kyrgiakos'),
(2,'Sokratis','Papastathopoulos'),(2,'Stelios','Malezas'),(3,'Nikos','Spiropoulos'),(3,'Alexandros','Tziolis'),(3,'Giorgos','Karagounis (c)'),(3,'Sotiris','Ninis'),
(3,'Kostas','Katsouranis'),(3,'Sakis','Prittas'),(4,'Georgios','Samaras'),(4,'Angelos','Charisteas'),(4,'Dimitris','Salpingidis'),(4,'Theofanis','Gekas'),
(4,'Pantelis','Kapetanos'),(1,'David','James'),(1,'Robert','Green'),(1,'Joe','Hart'),(2,'Glen','Johnson'),(2,'Ashley','Cole'),(2,'Michael','Dawson[5]'),
(2,'John','Terry'),(2,'Stephen','Warnock'),(2,'Matthew','Upson'),(2,'Jamie','Carragher'),(2,'Ledley','King'),(3,'Steven','Gerrard (c)'),(3,'Aaron','Lennon'),
(3,'Frank','Lampard'),(3,'Joe','Cole'),(3,'Gareth','Barry'),(3,'James','Milner'),(3,'Shaun','Wright-Phillips'),(3,'Michael','Carrick'),(4,'Peter','Crouch'),
(4,'Wayne','Rooney'),(4,'Jermain','Defoe'),(4,'Emile','Heskey'),(1,'Tim','Howard'),(1,'Brad','Guzan'),(1,'Marcus','Hahnemann'),(2,'Jonathan','Spector'),
(2,'Carlos','Bocanegra (c)'),(2,'Oguchi','Onyewu'),(2,'Steve','Cherundolo'),(2,'Jonathan','Bornstein'),(2,'Jay','DeMerit'),(2,'Clarence','Goodson'),
(3,'Michael','Bradley'),(3,'DaMarcus','Beasley'),(3,'Clint','Dempsey'),(3,'Landon','Donovan'),(3,'Stuart','Holden'),(3,'Ricardo','Clark'),
(3,'Francisco','Torres'),(3,'Maurice','Edu'),(3,'Benny','Feilhaber'),(4,'Herculez','Gomez'),(4,'Edson','Buddle'),(4,'Jozy','Altidore'),
(4,'Robbie','Findley'),(1,'Loun?s','Gaouaoui'),(1,'Faouzi','Chaouchi'),(1,'Ra?s','MBohli'),(2,'Madjid','Bougherra'),(2,'Nadir','Belhadj'),
(2,'Antar','Yahia (c)'),(2,'Rafik','Halliche'),(2,'Habib','Bella?d'),(2,'Abdelkader','La?faoui'),(2,'Carl','Medjani'),(2,'Djamel','Mesbah'),
(3,'Yazid','Mansouri'),(3,'Ryad','Boudebouz'),(3,'Medhi','Lacen'),(3,'Karim','Ziani'),(3,'Adl?ne','Guedioura'),(3,'Hassan','Yebda'),(3,'Foued','Kadir'),
(3,'Djamel','Abdoun'),(4,'Abdelkader','Ghezzal'),(4,'Rafik','Sa?fi'),(4,'Rafik','Djebbour'),(4,'Karim','Matmour'),(1,'Samir','Handanovi?'),(1,'Jasmin','Handanovi?'),
(1,'Aleksander','?eliga'),(2,'Mi?o','Bre?ko'),(2,'Elvedin','D?ini?'),(2,'Marko','?uler'),(2,'Bo?tjan','Cesar'),(2,'Branko','Ili?'),(2,'Bojan','Joki?'),
(2,'Suad','Filekovi?'),(2,'Matej','Mavri?'),(3,'Robert','Koren (c)'),(3,'Rene','Krhin'),(3,'Andra?','Kirm'),(3,'Aleksandar','Radosavljevi?'),(3,'Andrej','Komac'),
(3,'Dalibor','Stevanovi?'),(4,'Nejc','Pe?nik'),(4,'Zlatan','Ljubijanki?'),(4,'Valter','Birsa'),(4,'Milivoje','Novakovi?'),(4,'Zlatko','Dedi?'),(4,'Tim','Matav?'),
(1,'Manuel','Neuer'),(1,'Tim','Wiese'),(1,'Hans-J?rg','Butt'),(2,'Marcell','Jansen'),(2,'Arne','Friedrich'),(2,'Dennis','Aogo'),(2,'Serdar','Tasci'),
(2,'Holger','Badstuber'),(2,'Philipp','Lahm (c)'),(2,'Per','Mertesacker'),(2,'J?r?me','Boateng'),(3,'Sami','Khedira'),(3,'Bastian','Schweinsteiger'),
(3,'Mesut','?zil'),(3,'Lukas','Podolski'),(3,'Thomas','M?ller'),(3,'Piotr','Trochowski'),(3,'Toni','Kroos'),(3,'Marko','Marin'),(4,'Stefan','Kie?ling'),
(4,'Miroslav','Klose'),(4,'Cacau',NULL),(4,'Mario','G?mez'),(1,'Mark','Schwarzer'),(1,'Adam','Federici'),(1,'Eugene','Galekovi?[6]'),(2,'Lucas','Neill (c)'),
(2,'Craig','Moore'),(2,'Michael','Beauchamp'),(2,'Luke','Wilkshire'),(2,'Scott','Chipperfield'),(2,'Mark','Milligan'),(2,'David','Carney'),(3,'Tim','Cahill'),
(3,'Jason','Culina'),(3,'Brett','Emerton'),(3,'Vince','Grella'),(3,'Mile','Jedinak'),(3,'Carl','Valeri'),(3,'Richard','Garcia'),(3,'Dario','Vido?i?'),
(3,'Mark','Bresciano'),(4,'Joshua','Kennedy'),(4,'Harry','Kewell'),(4,'Brett','Holman'),(4,'Nikita','Rukavytsya'),(1,'Vladimir','Stojkovi?'),(1,'Bojan','Isailovi?'),
(1,'An?elko','?uri?i?'),(2,'Antonio','Rukavina'),(2,'Aleksandar','Kolarov'),(2,'Nemanja','Vidi?'),(2,'Branislav','Ivanovi?'),(2,'Aleksandar','Lukovi?'),
(2,'Ivan','Obradovi?'),(2,'Neven','Suboti?'),(3,'Gojko','Ka?ar'),(3,'Zoran','To?i?'),(3,'Dejan','Stankovi? (c)'),(3,'Nenad','Milija?'),(3,'Milan','Jovanovi?'),
(3,'Milo?','Krasi?'),(3,'Milo?','Ninkovi?'),(3,'Radosav','Petrovi?'),(3,'Zdravko','Kuzmanovi?'),(4,'Danko','Lazovi?'),(4,'Marko','Panteli?'),(4,'Nikola','?igi?'),
(4,'Dragan','Mr?a'),(1,'Daniel','Adjei'),(1,'Stephen','Ahorlu'),(1,'Richard','Kingson'),(2,'Hans','Sarpei'),(2,'John','Paintsil'),(2,'John','Mensah (c)'),
(2,'Samuel','Inkoom'),(2,'Jonathan','Mensah'),(2,'Isaac','Vorsah'),(2,'Abdul','Rahim'),(2,'Lee','Addy'),(3,'Anthony','Annan'),(3,'Derek','Boateng'),
(3,'Stephen','Appiah'),(3,'Sulley','Muntari'),(3,'Andr?','Ayew'),(3,'Quincy','Owusu-Abeyie'),(3,'Kwadwo','Asamoah'),(3,'Kevin-Prince','Boateng'),
(4,'Asamoah','Gyan'),(4,'Prince','Tagoe'),(4,'Matthew','Amoah'),(4,'Dominic','Adiyiah'),(1,'Maarten','Stekelenburg'),(1,'Michel','Vorm'),(1,'Sander','Boschker'),
(2,'Gregory','Wiel'),(2,'John','Heitinga'),(2,'Joris','Mathijsen'),(2,'Giovanni','Bronckhorst'),(2,'Khalid','Boulahrouz'),
(2,'Andr?','Ooijer'),(2,'Edson','Braafheid'),(3,'Mark','Bommel'),(3,'Nigel','Jong'),(3,'Wesley','Sneijder'),(3,'Demy','Zeeuw'),
(3,'Stijn','Schaars'),(3,'Ibrahim','Afellay'),(3,'Rafael','Vaart'),(4,'Dirk','Kuyt'),(4,'Robin','Persie'),(4,'Arjen','Robben'),
(4,'Eljero','Elia'),(4,'Ryan','Babel'),(4,'Klaas-Jan','Huntelaar'),(1,'Thomas','S?rensen'),(1,'Stephan','Andersen'),(1,'Jesper','Christiansen'),
(2,'Simon','Kj?r'),(2,'Daniel','Agger'),(2,'William','Kvist'),(2,'Lars','Jacobsen'),(2,'Per','Kr?ldrup'),(2,'Simon','Poulsen'),(2,'Patrick','Mtiliga'),
(3,'Christian','Poulsen'),(3,'Daniel','Jensen'),(3,'Jesper','Gr?nkj?r'),(3,'Martin','J?rgensen'),(3,'Thomas','Kahlenberg'),(3,'Jakob','Poulsen'),
(3,'Mikkel','Beckmann'),(3,'Dennis','Rommedahl'),(3,'Thomas','Enevoldsen'),(3,'Christian','Eriksen'),(4,'Jon','Tomasson (c)'),(4,'Nicklas','BENDtner'),
(4,'S?ren','Larsen'),(1,'Seigo','Narazaki'),(1,'Eiji','Kawashima'),(1,'Yoshikatsu','Kawaguchi (c)'),(2,'Y?ichi','Komano'),(2,'Marcus','Tanaka'),
(2,'Yuto','Nagatomo'),(2,'Atsuto','Uchida'),(2,'Daiki','Iwamasa'),(2,'Yasuyuki','Konno'),(2,'Yuji','Nakazawa'),(3,'Yuki','Abe'),(3,'Yasuhito','END?'),
(3,'Shunsuke','Nakamura'),(3,'Kengo','Nakamura'),(3,'Makoto','Hasebe (vc)'),(3,'Keisuke','Honda'),(3,'Junichi','Inamoto'),(4,'Daisuke','Matsui'),
(4,'Shinji','Okazaki'),(4,'Keiji','Tamada'),(4,'Kisho','Yano'),(4,'Yoshito','?kubo'),(4,'Takayuki','Morimoto'),(1,'Carlos','Kameni'),(1,'Souleymanou','Hamidou'),
(1,'Guy','Assemb?'),(2,'Beno?t','Assou-Ekotto'),(2,'Nicolas','NKoulou'),(2,'Rigobert','Song'),(2,'S?bastien','Bassong'),(2,'Geremi',NULL),(2,'Ga?tan','Bong'),
(2,'Aur?lien','Chedjou'),(2,'St?phane','Mbia'),(3,'Alex','Song'),(3,'Landry','NGu?mo'),(3,'Achille','Emana'),(3,'Jean','Makoun'),(3,'Eyong','Enoh'),
(3,'Georges','Mandjeck'),(3,'Jo?l','Matip'),(4,'Samuel','Etoo (c)'),(4,'Eric','ChoupoMoting'),(4,'Pierre','Web?'),(4,'Mohammadou','Idrissou'),
(4,'Vincent','Aboubakar'),(1,'Gianluigi','Buffon'),(1,'Federico','Marchetti'),(1,'Morgan','Sanctis'),(2,'Christian','Maggio'),(2,'Domenico','Criscito'),
(2,'Giorgio','Chiellini'),(2,'Fabio','Cannavaro (c)'),(2,'Salvatore','Bocchetti'),(2,'Gianluca','Zambrotta'),(2,'Leonardo','Bonucci'),
(3,'Daniele','Rossi'),(3,'Simone','Pepe'),(3,'Gennaro','Gattuso'),(3,'Claudio','Marchisio'),(3,'Mauro','Camoranesi'),(3,'Angelo','Palombo'),
(3,'Andrea','Pirlo'),(3,'Riccardo','Montolivo'),(4,'Vincenzo','Iaquinta'),(4,'Antonio','Natale'),(4,'Alberto','Gilardino'),(4,'Fabio','Quagliarella'),
(4,'Giampaolo','Pazzini'),(1,'Justo','Villar (c)'),(1,'Diego','Barreto'),(1,'Aldo','Bobadilla'),(2,'Dar?o','Ver?n'),(2,'Claudio','Morel'),(2,'Denis','Caniza'),
(2,'Julio','C?ceres'),(2,'Carlos','Bonet'),(2,'Paulo','Silva'),(2,'Aureliano','Torres'),(2,'Antol?n','Alcaraz'),(3,'?dgar','Barreto'),
(3,'Jonathan','Santana'),(3,'Enrique','Vera'),(3,'V?ctor','C?ceres'),(3,'Cristian','Riveros'),(3,'N?stor','Ortigoza'),(4,'?scar','Cardozo'),(4,'Roque','Cruz'),
(4,'?dgar','Ben?tez'),(4,'Nelson','Valdez'),(4,'Lucas','Barrios'),(4,'Rodolfo','Gamarra'),(1,'Mark','Paston'),(1,'Glen','Moss'),(1,'James','Bannatyne'),(2,'Ben','Sigmund'),
(2,'Tony','Lochhead'),(2,'Winston','Reid'),(2,'Ivan','Vicelich'),(2,'Ryan','Nelsen (c)'),(2,'Andrew','Boyens'),(2,'Tommy','Smith'),(3,'Simon','Elliott'),(3,'Tim','Brown'),
(3,'Leo','Bertos'),(3,'Andy','Barron'),(3,'Michael','McGlinchey'),(3,'Aaron','Clapham'),(3,'David','Mulligan'),(3,'Jeremy','Christie'),(3,'Jeremy','Brockie'),(4,'Shane','Smeltz'),
(4,'Chris','Killen'),(4,'Rory','Fallon'),(4,'Chris','Wood'),(1,'J?n','Mucha'),(1,'Du?an','Perni?'),(1,'Du?an','Kuciak'),(2,'Peter','Pekar?k'),(2,'Martin','?krtel'),
(2,'Marek','?ech'),(2,'Radoslav','Zabavn?k'),(2,'J?n','?urica'),(2,'Kornel','Sal?ta'),(2,'Martin','Petr??'),(3,'Zdeno','?trba'),(3,'Vladim?r','Weiss'),(3,'J?n','Koz?k'),
(3,'Stanislav','?est?k'),(3,'Marek','Sapara'),(3,'Miroslav','Stoch'),(3,'Marek','Ham??k (c)'),(3,'Juraj','Kucka'),(3,'Kamil','Kop?nek'),(4,'R?bert','Vittek'),
(4,'Filip','Holo?ko'),(4,'Martin','Jakubko'),(4,'Erik','JENDri?ek'),(1,'J?lio','C?sar'),(1,'Gomes',NULL),(1,'Doni',NULL),(2,'Maicon',NULL),(2,'L?cio ',NULL),(2,'Juan',NULL),
(2,'Michel','Bastos'),(2,'Daniel','Alves'),(2,'Luis?o',NULL),(2,'Thiago','Silva'),(2,'Gilberto',NULL),(3,'Felipe','Melo'),(3,'Elano',NULL),(3,'Gilberto','Silva'),(3,'Kak?',NULL),
(3,'Josu?',NULL),(3,'Ramires',NULL),(3,'J?lio','Baptista'),(3,'Kl?berson',NULL),(4,'Lu?s','Fabiano'),(4,'Robinho',NULL),(4,'Nilmar',NULL),(4,'Grafite',NULL),(1,'Ri','Myong-Guk'),(1,'Kim','Myong-Gil'),
(1,'Kim','Myong-Won[8]'),(2,'Cha','Jong-Hyok'),(2,'Ri','Jun-Il'),(2,'Ri','Kwang-Chon'),(2,'Ji','Yun-Nam'),(2,'Pak','Chol-Jin'),(2,'Pak','Nam-Chol'),(2,'Nam','Song-Chol'),
(2,'Ri','Kwang-Hyok'),(3,'Pak','Nam-Chol'),(3,'Kim','Kum-Il'),(3,'Mun','In-Guk'),(3,'Kim','Yong-Jun'),(3,'An','Yong-Hak'),(3,'Ri','Chol-Myong'),(3,'Kim','Kyong-Il'),
(3,'Pak','Sung-Hyok'),(4,'An','Chol-Hyok'),(4,'Jong','Tae-Se'),(4,'Hong','Yong-Jo (c)'),(4,'Choe','Kum-Chol'),(1,'Boubacar','Barry'),(1,'Aristide','Zogbo'),(1,'Daniel','Yeboah'),
(2,'Benjamin','Angoua'),(2,'Arthur','Boka'),(2,'Kolo','Tour?'),(2,'Steve','Gohouri'),(2,'Siaka','Ti?n?'),(2,'Guy','Demel'),(2,'Emmanuel','Ebou?'),(2,'Sol','Bamba'),
(3,'Didier','Zokora'),(3,'Cheick','Tiot?'),(3,'Jean-Jacques','Gosso'),(3,'Romaric',NULL),(3,'Emmanuel','Kon?'),(3,'Kader','Ke?ta'),(3,'Yaya','Tour?'),(4,'Seydou','Doumbia'),
(4,'Salomon','Kalou'),(4,'Gervinho',NULL),(4,'Didier','Drogba (c)'),(4,'Aruna','Dindane'),(1,'Eduardo',NULL),(1,'Beto',NULL),(1,'Daniel','Fernandes'),(2,'Bruno','Alves'),
(2,'Paulo','Ferreira'),(2,'Rolando',NULL),(2,'Duda',NULL),(2,'Ricardo','Carvalho'),(2,'Miguel',NULL),(2,'Pepe',NULL),(2,'Ricardo','Costa'),(2,'F?bio','Coentr?o'),(3,'Pedro','MENDes'),
(3,'Danny',NULL),(3,'Sim?o',NULL),(3,'Miguel','Veloso'),(3,'Raul','Meireles'),(3,'Ruben','Amorim[9]'),(3,'Tiago',NULL),(3,'Deco',NULL),(4,'Cristiano','Ronaldo (c)'),(4,'Li?dson',NULL),
(4,'Hugo','Almeida'),(1,'Iker','Casillas (c)'),(1,'V?ctor','Vald?s'),(1,'Pepe','Reina'),(2,'Ra?l','Albiol'),(2,'Gerard','Piqu?'),(2,'Carlos','Marchena'),(2,'Carles','Puyol'),
(2,'Joan','Capdevila'),(2,'Sergio','Ramos'),(2,'?lvaro','Arbeloa'),(3,'Andr?s','Iniesta'),(3,'Xavi',NULL),(3,'Cesc','F?bregas'),(3,'Juan','Mata'),(3,'Xabi','Alonso'),
(3,'Sergio','Busquets'),(3,'Javi','Mart?nez'),(3,'David','Silva'),(3,'Jes?s','Navas'),(4,'David','Villa'),(4,'Fernando','Torres'),(4,'Pedro',NULL),(4,'Fernando','Llorente'),
(1,'Diego','Benaglio'),(1,'Marco','W?lfli'),(1,'Johnny','Leoni'),(2,'Stephan','Lichtsteiner'),(2,'Ludovic','Magnin'),(2,'Philippe','SENDeros'),(2,'Steve','Bergen'),
(2,'St?phane','Grichting'),(2,'Reto','Ziegler'),(2,'Mario','Eggimann'),(3,'Benjamin','Huggel'),(3,'Tranquillo','Barnetta'),(3,'G?khan','Inler'),(3,'Valon','Behrami'),
(3,'Marco','Padalino'),(3,'Hakan','Yakin'),(3,'Gelson','Fernandes'),(3,'Pirmin','Schwegler'),(3,'Xherdan','Shaqiri'),(4,'Alexander','Frei (c)'),(4,'Blaise','Nkufo'),
(4,'Albert','Bunjaku'),(4,'Eren','Derdiyok'),(1,'Ricardo','Canales'),(1,'Noel','Valladares'),(1,'Donis','Escober'),(2,'Osman','Ch?vez'),(2,'Maynor','Figueroa'),
(2,'Johnny','Palacios'),(2,'V?ctor','Bern?rdez'),(2,'Oscar','Garc?a'),(2,'Mauricio','Sabill?n'),(2,'Emilio','Izaguirre'),(2,'Sergio','MENDoza'),(3,'HENDry','Thomas'),
(3,'Ram?n','N??ez'),(3,'Wilson','Palacios'),(3,'Edgar','?lvarez'),(3,'Danilo','Turcios'),(3,'Amado','Guevara (c)'),(4,'Carlos','Pav?n'),(4,'Jerry','Palacios[10]'),
(4,'David','Suazo'),(4,'Georgie','Welcome'),(4,'Roger','Espinoza'),(4,'Walter','Mart?nez'),(1,'Claudio','Bravo (c)'),(1,'Miguel','Pinto'),(1,'Luis','Mar?n'),
(2,'Ismael','Fuentes'),(2,'Waldo','Ponce'),(2,'Pablo','Contreras'),(2,'Arturo','Vidal'),(2,'Gary','Medel'),(2,'Gonzalo','Jara'),(3,'Mauricio','Isla'),(3,'Carlos','Carmona'),
(3,'Jorge','Valdivia'),(3,'Marco','Estrada'),(3,'Mat?as','Fern?ndez'),(3,'Gonzalo','Fierro'),(3,'Rodrigo','Millar'),(3,'Rodrigo','Tello'),(4,'Alexis','S?nchez'),
(4,'Humberto','Suazo'),(4,'Mark','Gonz?lez'),(4,'Jean','Beausejour'),(4,'Fabi?n','Orellana'),(4,'Esteban','Paredes')

-- ////////// --
--            --
-- PROCEDURES --
--            --
-- ////////// --

-- /////////////////////// --
-- FILL PLAYER'S COUNTRYFK --
-- /////////////////////// --

-- DROP PROCEDURE IF EXISTS FillTeams

CREATE PROC FillTeams
AS
BEGIN
	-- Clear previous data
	UPDATE Players SET CountryFK = NULL WHERE CountryFK IS NOT NULL

	DECLARE @CurrentTeamID INT
	SET @CurrentTeamID = 1

	WHILE @CurrentTeamID < (SELECT COUNT(*) + 1 FROM Countries)
	BEGIN
		-- Goalkeeper
		UPDATE Players SET CountryFK = @CurrentTeamID
		WHERE Players.Id = 
		(
			SELECT TOP (1) Id
			FROM Players
			WHERE Players.PositionFK = 1 AND Players.CountryFK IS NULL
			ORDER BY NEWID()
		)
			
		-- Two defenders
		WHILE ((SELECT COUNT(*) FROM Players WHERE Players.PositionFK =  2 AND Players.CountryFK = @CurrentTeamID) < 2)
		BEGIN
			UPDATE Players SET CountryFK = @CurrentTeamID
			WHERE Players.Id = 
			(
				SELECT TOP(1) Id
				FROM Players
				WHERE Players.PositionFK = 2 AND Players.CountryFK IS NULL
				ORDER BY NEWID()
			)
		END
			
		-- Five halfdefenders
		WHILE ((SELECT COUNT(*) FROM Players WHERE Players.PositionFK =  3 AND Players.CountryFK = @CurrentTeamID) < 5)
		BEGIN
			UPDATE Players Set CountryFK = @CurrentTeamID
			WHERE Players.Id = 
			(
				SELECT TOP(1) Id
				FROM Players
				WHERE Players.PositionFK = 3 AND Players.CountryFK IS NULL
				ORDER BY NEWID()
			)
		END
	
		-- Three forwarders
		WHILE ((SELECT COUNT(*) FROM Players WHERE Players.PositionFK =  4 AND Players.CountryFK = @CurrentTeamID) < 3)
		BEGIN
			UPDATE Players SET CountryFK = @CurrentTeamID
			WHERE Players.Id = 
			(
				SELECT TOP(1) Id
				FROM Players
				WHERE Players.PositionFK = 4 AND Players.CountryFK IS NULL
				ORDER BY NEWID()
			)
		END

		SET @CurrentTeamID = @CurrentTeamID + 1
	END
END

-- EXEC FillTeams

-- /////////// --
-- GROUP STAGE --
-- /////////// --

-- DROP PROCEDURE IF EXISTS GroupStage

CREATE PROC GroupStage
AS
BEGIN
	-- Dates
	DECLARE @cupStartDate smalldatetime = '10-06-11 18:00'

	-- Clear all previous matches data
	DELETE FROM FavoritePlayers
	DELETE FROM GroupStageResults
	DELETE FROM Matches WHERE MatchTypeFK = 1

	DBCC CHECKIDENT ('[GroupStageResults]', RESEED, 0)

	DECLARE @CurrentGroup int
	SET @CurrentGroup = 1

	-- In Group Matches Order List
	DECLARE @InGroupMatches TABLE
	(
		Id int PRIMARY KEY IDENTITY(1, 1),
		Team1 int,
		Team2 int
	)
	INSERT INTO @InGroupMatches (Team1, Team2) VALUES (1, 2), (1, 3), (1, 4), (2, 3), (2, 4), (3, 4)

	WHILE (@CurrentGroup < 9)
	BEGIN
		WHILE ((SELECT COUNT(*) FROM GroupStageResults WHERE [Group] = @CurrentGroup) < 4)
		BEGIN
			IF ((SELECT COUNT(*) FROM GroupStageResults) = 0)
				INSERT INTO GroupStageResults (CountryFK, [Group]) 
				VALUES 
				(
					(SELECT TOP(1) Id FROM Countries ORDER BY NEWID()), @CurrentGroup
				)
			ELSE
				INSERT INTO GroupStageResults (CountryFK, [Group]) 
				VALUES 
				(
					(SELECT TOP(1) Id FROM Countries WHERE Id NOT IN (SELECT CountryFK FROM GroupStageResults) ORDER BY NEWID()), @CurrentGroup
				)
		END

		DECLARE @CurrentInGroupMatch INT = 1

		DECLARE @currentGroupDate smalldatetime = (SELECT DATEADD(day, 1, @cupStartDate))

		WHILE (@CurrentInGroupMatch < 7)
		BEGIN
			IF (@CurrentInGroupMatch % 2 = 1)
			BEGIN
				SET @currentGroupDate = (SELECT DATEADD(hour, 3, @currentGroupDate))
			END
			ELSE
			BEGIN
				SET @currentGroupDate = (SELECT DATEADD(hour, -3, @currentGroupDate))
			END

			-- Team 1 Goals
			DECLARE @RandomTeam1Goals INT = ABS(CHECKSUM(NEWID()) % 5)

			-- Team 2 Goals
			DECLARE @RandomTeam2Goals INT = ABS(CHECKSUM(NEWID()) % 5)

			-- Get Team1FK and Team2FK From InGroupMatchesList
			DECLARE @Team1FK INT = ((@CurrentGroup - 1) * 4 + (SELECT Team1 FROM @InGroupMatches WHERE Id = @CurrentInGroupMatch))
			DECLARE @Team2FK INT = ((@CurrentGroup - 1) * 4 + (SELECT Team2 FROM @InGroupMatches WHERE Id = @CurrentInGroupMatch))

			SET @currentGroupDate = (SELECT DATEADD(day, 1, @currentGroupDate))

			-- Choosing random stadium to hold a match
			DECLARE @StadiumFK INT = (SELECT TOP(1) Id FROM Stadiums ORDER BY NEWID())

			-- Generating viewers present on a match depending on the volume of stadium
			DECLARE @Viewers INT = ABS(CHECKSUM(NEWID()) % (SELECT Capacity FROM Stadiums WHERE Id = @StadiumFK)) + (((SELECT Capacity FROM Stadiums WHERE Id = @StadiumFK) / 100) * 75)

			INSERT INTO Matches (Score1, Score2, Team1FK, Team2FK, MatchTypeFK, StadiumFK, Viewers, [DateTime]) 
			VALUES 
			(
				@RandomTeam1Goals,
				@RandomTeam2Goals,
				@Team1FK,
				@Team2FK,
				1,
				@StadiumFK,
				@Viewers,
				@currentGroupDate
			)

			-- Update GroupStageResults Table by updating team score

			UPDATE GroupStageResults SET Score = (SELECT Score FROM GroupStageResults WHERE CountryFK = @Team1FK) + @RandomTeam1Goals WHERE CountryFK = @Team1FK
			UPDATE GroupStageResults SET Score = (SELECT Score FROM GroupStageResults WHERE CountryFK = @Team2FK) + @RandomTeam2Goals WHERE CountryFK = @Team2FK

			-- Add Team 1 Goals to favorite players

			DECLARE @CurrentGoal INT = 0

			WHILE (@CurrentGoal < @RandomTeam1Goals)
			BEGIN
				INSERT INTO FavoritePlayers (MatchFK, PlayerFK, Minutes) 
				VALUES
				(
					(SELECT IDENT_CURRENT('Matches')),
					(SELECT TOP(1) Id FROM Players WHERE CountryFK = @Team1FK AND PositionFK != 1 ORDER BY NEWID()),
					ABS(CHECKSUM(NEWID()) % 90) + 1
				)
			
				SET @CurrentGoal = @CurrentGoal + 1
			END

			-- Add Team 2 Goals to favorite players

			SET @CurrentGoal = 0

			WHILE (@CurrentGoal < @RandomTeam2Goals)
			BEGIN
				INSERT INTO FavoritePlayers (MatchFK, PlayerFK, Minutes) 
				VALUES
				(
					(SELECT IDENT_CURRENT('Matches')),
					(SELECT TOP(1) Id FROM Players WHERE CountryFK = @Team2FK AND PositionFK != 1 ORDER BY NEWID()),
					ABS(CHECKSUM(NEWID()) % 90) + 1
				)
			
				SET @CurrentGoal = @CurrentGoal + 1
			END

			SET @CurrentInGroupMatch = @CurrentInGroupMatch + 1
		END

		DELETE FROM GroupStageResults WHERE CountryFK IN (SELECT TOP(2) CountryFK FROM GroupStageResults WHERE [Group] = @CurrentGroup ORDER BY Score)

		SET @CurrentGroup = @CurrentGroup + 1
	END
END

-- EXEC GroupStage

-- ///////// --
-- 1/8 STAGE --
-- ///////// --

-- DROP PROCEDURE IF EXISTS Final1_8

CREATE PROC Final1_8
AS
BEGIN
	-- Dates
	DECLARE @cupStartDate smalldatetime = '17-06-10 18:00'

	-- Clear previous data
	DELETE FROM FavoritePlayers WHERE Id IN (SELECT FP.Id FROM FavoritePlayers FP, Matches M WHERE FP.MatchFK = M.Id AND M.MatchTypeFK = 2)
	DELETE FROM Final1_8Results
	DELETE FROM Matches WHERE MatchTypeFK = 2

	DECLARE @CurrentGroup int
	SET @CurrentGroup = 1

	DECLARE @currentGroupDate smalldatetime = (SELECT DATEADD(day, 1, @cupStartDate))

	WHILE (@CurrentGroup < 9)
	BEGIN
		IF (@CurrentGroup % 2 = 1)
		BEGIN
			SET @currentGroupDate = (SELECT DATEADD(day, 1, @currentGroupDate))
			SET @currentGroupDate = (SELECT DATEADD(hour, 3, @currentGroupDate))
		END
		ELSE
		BEGIN
			SET @currentGroupDate = (SELECT DATEADD(hour, -3, @currentGroupDate))
		END

		-- Should Team 2 Win the game?
		DECLARE @Team2Won INT = ABS(CHECKSUM(NEWID()) % 2)

		-- Team 1 Goals
		DECLARE @RandomTeam1Goals INT

		-- Team 2 Goals
		DECLARE @RandomTeam2Goals INT
		IF (@Team2Won = 1)
		BEGIN
			SET @RandomTeam1Goals = ABS(CHECKSUM(NEWID()) % 4)
			SET @RandomTeam2Goals = ABS(CHECKSUM(NEWID()) % 2) + @RandomTeam1Goals + 1
		END
		ELSE
		BEGIN
			SET @RandomTeam1Goals = ABS(CHECKSUM(NEWID()) % 4) + 1
			SET @RandomTeam2Goals = ABS(CHECKSUM(NEWID()) % @RandomTeam1Goals)
		END

		-- Get Team1FK and Team2FK From GroupStageResults
		DECLARE @Team1FK INT = (SELECT TOP(1) CountryFK FROM GroupStageResults WHERE [Group] = @CurrentGroup ORDER BY Score)
		DECLARE @Team2FK INT = (SELECT CountryFK FROM GroupStageResults WHERE [Group] = @CurrentGroup ORDER BY Score OFFSET 1 ROW FETCH FIRST 1 ROW ONLY)

		-- Choosing random stadium to hold a match
		DECLARE @StadiumFK INT = (SELECT TOP(1) Id FROM Stadiums ORDER BY NEWID())

		-- Generating viewers present on a match depending on the volume of stadium
		DECLARE @Viewers INT = ABS(CHECKSUM(NEWID()) % (SELECT Capacity FROM Stadiums WHERE Id = @StadiumFK)) + (((SELECT Capacity FROM Stadiums WHERE Id = @StadiumFK) / 100) * 75)

		INSERT INTO Matches (Score1, Score2, Team1FK, Team2FK, MatchTypeFK, StadiumFK, Viewers, DateTime) 
		VALUES 
		(
			@RandomTeam1Goals,
			@RandomTeam2Goals,
			@Team1FK,
			@Team2FK,
			2,
			@StadiumFK,
			@Viewers,
			@currentGroupDate
		)

		IF (@Team2Won = 1)
			INSERT INTO Final1_8Results (CountryFK, Score) VALUES (@Team2FK, @RandomTeam2Goals)
		ELSE
			INSERT INTO Final1_8Results (CountryFK, Score) VALUES (@Team1FK, @RandomTeam1Goals)

		-- Add Team 1 Goals to favorite players

		DECLARE @CurrentGoal INT = 0

		WHILE (@CurrentGoal < @RandomTeam1Goals)
		BEGIN
			INSERT INTO FavoritePlayers (MatchFK, PlayerFK, Minutes) 
			VALUES
			(
				(SELECT IDENT_CURRENT('Matches')),
				(SELECT TOP(1) Id FROM Players WHERE CountryFK = @Team1FK AND PositionFK != 1 ORDER BY NEWID()),
				ABS(CHECKSUM(NEWID()) % 90) + 1
			)
			
			SET @CurrentGoal = @CurrentGoal + 1
		END

		-- Add Team 2 Goals to favorite players

		SET @CurrentGoal = 0

		WHILE (@CurrentGoal < @RandomTeam2Goals)
		BEGIN
			INSERT INTO FavoritePlayers (MatchFK, PlayerFK, Minutes) 
			VALUES
			(
				(SELECT IDENT_CURRENT('Matches')),
				(SELECT TOP(1) Id FROM Players WHERE CountryFK = @Team2FK AND PositionFK != 1 ORDER BY NEWID()),
				ABS(CHECKSUM(NEWID()) % 90) + 1
			)
			
			SET @CurrentGoal = @CurrentGoal + 1
		END

		SET @CurrentGroup = @CurrentGroup + 1
	END
END

-- EXEC Final1_8

-- ///////// --
-- 1/4 STAGE --
-- ///////// --

-- DROP PROCEDURE IF EXISTS Final1_4

CREATE PROC Final1_4
AS
BEGIN
	-- Dates
	DECLARE @cupStartDate smalldatetime = '21-06-10 18:00'

	-- Clear previous data
	DELETE FROM FavoritePlayers WHERE Id IN (SELECT FP.Id FROM FavoritePlayers FP, Matches M WHERE FP.MatchFK = M.Id AND M.MatchTypeFK = 3)
	DELETE FROM Final1_4Results
	DELETE FROM Matches WHERE MatchTypeFK = 3

	DECLARE @CurrentGroup int
	SET @CurrentGroup = 1

	DECLARE @currentGroupDate smalldatetime = (SELECT DATEADD(day, 1, @cupStartDate))

	WHILE (@CurrentGroup < 5)
	BEGIN
		IF (@CurrentGroup % 2 = 1)
		BEGIN
			SET @currentGroupDate = (SELECT DATEADD(day, 1, @currentGroupDate))
			SET @currentGroupDate = (SELECT DATEADD(hour, 3, @currentGroupDate))
		END
		ELSE
		BEGIN
			SET @currentGroupDate = (SELECT DATEADD(hour, -3, @currentGroupDate))
		END

		-- Should Team 2 Win the game?
		DECLARE @Team2Won INT = ABS(CHECKSUM(NEWID()) % 2)

		-- Team 1 Goals
		DECLARE @RandomTeam1Goals INT

		-- Team 2 Goals
		DECLARE @RandomTeam2Goals INT
		IF (@Team2Won = 1)
		BEGIN
			SET @RandomTeam1Goals = ABS(CHECKSUM(NEWID()) % 4)
			SET @RandomTeam2Goals = ABS(CHECKSUM(NEWID()) % 2) + @RandomTeam1Goals + 1
		END
		ELSE
		BEGIN
			SET @RandomTeam1Goals = ABS(CHECKSUM(NEWID()) % 4) + 1
			SET @RandomTeam2Goals = ABS(CHECKSUM(NEWID()) % @RandomTeam1Goals)
		END

		-- Get Team1FK and Team2FK From Final1_8Results
		DECLARE @Team1FK INT = (SELECT CountryFK FROM Final1_8Results ORDER BY Score OFFSET ((@CurrentGroup - 1) * 2) ROW FETCH FIRST 1 ROW ONLY)
		DECLARE @Team2FK INT = (SELECT CountryFK FROM Final1_8Results ORDER BY Score OFFSET ((@CurrentGroup - 1) * 2) + 1 ROW FETCH FIRST 1 ROW ONLY)

		-- Choosing random stadium to hold a match
		DECLARE @StadiumFK INT = (SELECT TOP(1) Id FROM Stadiums ORDER BY NEWID())

		-- Generating viewers present on a match depending on the volume of stadium
		DECLARE @Viewers INT = ABS(CHECKSUM(NEWID()) % (SELECT Capacity FROM Stadiums WHERE Id = @StadiumFK)) + (((SELECT Capacity FROM Stadiums WHERE Id = @StadiumFK) / 100) * 75)

		INSERT INTO Matches (Score1, Score2, Team1FK, Team2FK, MatchTypeFK, StadiumFK, Viewers, DateTime) 
		VALUES 
		(
			@RandomTeam1Goals,
			@RandomTeam2Goals,
			@Team1FK,
			@Team2FK,
			3,
			@StadiumFK,
			@Viewers,
			@currentGroupDate
		)

		IF (@Team2Won = 1)
			INSERT INTO Final1_4Results (CountryFK, Score) VALUES (@Team2FK, @RandomTeam2Goals)
		ELSE
			INSERT INTO Final1_4Results (CountryFK, Score) VALUES (@Team1FK, @RandomTeam1Goals)

		-- Add Team 1 Goals to favorite players

		DECLARE @CurrentGoal INT = 0

		WHILE (@CurrentGoal < @RandomTeam1Goals)
		BEGIN
			INSERT INTO FavoritePlayers (MatchFK, PlayerFK, Minutes) 
			VALUES
			(
				(SELECT IDENT_CURRENT('Matches')),
				(SELECT TOP(1) Id FROM Players WHERE CountryFK = @Team1FK AND PositionFK != 1 ORDER BY NEWID()),
				ABS(CHECKSUM(NEWID()) % 90) + 1
			)
			
			SET @CurrentGoal = @CurrentGoal + 1
		END

		-- Add Team 2 Goals to favorite players

		SET @CurrentGoal = 0

		WHILE (@CurrentGoal < @RandomTeam2Goals)
		BEGIN
			INSERT INTO FavoritePlayers (MatchFK, PlayerFK, Minutes) 
			VALUES
			(
				(SELECT IDENT_CURRENT('Matches')),
				(SELECT TOP(1) Id FROM Players WHERE CountryFK = @Team2FK AND PositionFK != 1 ORDER BY NEWID()),
				ABS(CHECKSUM(NEWID()) % 90) + 1
			)
			
			SET @CurrentGoal = @CurrentGoal + 1
		END

		SET @CurrentGroup = @CurrentGroup + 1
	END
END

-- EXEC Final1_4

-- ///////// --
-- 1/2 STAGE --
-- ///////// --

-- DROP PROCEDURE IF EXISTS Final1_2

CREATE PROC Final1_2
AS
BEGIN
	-- Dates
	DECLARE @cupStartDate smalldatetime = '24-06-10 18:00'

	-- Clear previous data
	DELETE FROM FavoritePlayers WHERE Id IN (SELECT FP.Id FROM FavoritePlayers FP, Matches M WHERE FP.MatchFK = M.Id AND M.MatchTypeFK = 4)
	DELETE FROM Final1_2Results
	DELETE FROM Matches WHERE MatchTypeFK = 4

	DECLARE @CurrentGroup int
	SET @CurrentGroup = 1

	DECLARE @currentGroupDate smalldatetime = (SELECT DATEADD(day, 1, @cupStartDate))

	WHILE (@CurrentGroup < 3)
	BEGIN
		IF (@CurrentGroup % 2 = 1)
		BEGIN
			SET @currentGroupDate = (SELECT DATEADD(hour, 3, @currentGroupDate))
		END
		ELSE
		BEGIN
			SET @currentGroupDate = (SELECT DATEADD(hour, -3, @currentGroupDate))
		END

		-- Should Team 2 Win the game?
		DECLARE @Team2Won INT = ABS(CHECKSUM(NEWID()) % 2)

		-- Team 1 Goals
		DECLARE @RandomTeam1Goals INT

		-- Team 2 Goals
		DECLARE @RandomTeam2Goals INT
		IF (@Team2Won = 1)
		BEGIN
			SET @RandomTeam1Goals = ABS(CHECKSUM(NEWID()) % 4)
			SET @RandomTeam2Goals = ABS(CHECKSUM(NEWID()) % 2) + @RandomTeam1Goals + 1
		END
		ELSE
		BEGIN
			SET @RandomTeam1Goals = ABS(CHECKSUM(NEWID()) % 4) + 1
			SET @RandomTeam2Goals = ABS(CHECKSUM(NEWID()) % @RandomTeam1Goals)
		END

		-- Get Team1FK and Team2FK From Final1_4Results
		DECLARE @Team1FK INT = (SELECT CountryFK FROM Final1_4Results ORDER BY Score OFFSET ((@CurrentGroup - 1) * 2) ROW FETCH FIRST 1 ROW ONLY)
		DECLARE @Team2FK INT = (SELECT CountryFK FROM Final1_4Results ORDER BY Score OFFSET ((@CurrentGroup - 1) * 2) + 1 ROW FETCH FIRST 1 ROW ONLY)

		-- Choosing random stadium to hold a match
		DECLARE @StadiumFK INT = (SELECT TOP(1) Id FROM Stadiums ORDER BY NEWID())

		-- Generating viewers present on a match depending on the volume of stadium
		DECLARE @Viewers INT = ABS(CHECKSUM(NEWID()) % (SELECT Capacity FROM Stadiums WHERE Id = @StadiumFK)) + (((SELECT Capacity FROM Stadiums WHERE Id = @StadiumFK) / 100) * 75)

		INSERT INTO Matches (Score1, Score2, Team1FK, Team2FK, MatchTypeFK, StadiumFK, Viewers, DateTime) 
		VALUES 
		(
			@RandomTeam1Goals,
			@RandomTeam2Goals,
			@Team1FK,
			@Team2FK,
			4,
			@StadiumFK,
			@Viewers,
			@currentGroupDate
		)

		IF (@Team2Won = 1)
			INSERT INTO Final1_2Results (CountryFK, Score) VALUES (@Team2FK, @RandomTeam2Goals)
		ELSE
			INSERT INTO Final1_2Results (CountryFK, Score) VALUES (@Team1FK, @RandomTeam1Goals)

		-- Add Team 1 Goals to favorite players

		DECLARE @CurrentGoal INT = 0

		WHILE (@CurrentGoal < @RandomTeam1Goals)
		BEGIN
			INSERT INTO FavoritePlayers (MatchFK, PlayerFK, Minutes) 
			VALUES
			(
				(SELECT IDENT_CURRENT('Matches')),
				(SELECT TOP(1) Id FROM Players WHERE CountryFK = @Team1FK AND PositionFK != 1 ORDER BY NEWID()),
				ABS(CHECKSUM(NEWID()) % 90) + 1
			)
			
			SET @CurrentGoal = @CurrentGoal + 1
		END

		-- Add Team 2 Goals to favorite players

		SET @CurrentGoal = 0

		WHILE (@CurrentGoal < @RandomTeam2Goals)
		BEGIN
			INSERT INTO FavoritePlayers (MatchFK, PlayerFK, Minutes) 
			VALUES
			(
				(SELECT IDENT_CURRENT('Matches')),
				(SELECT TOP(1) Id FROM Players WHERE CountryFK = @Team2FK AND PositionFK != 1 ORDER BY NEWID()),
				ABS(CHECKSUM(NEWID()) % 90) + 1
			)
			
			SET @CurrentGoal = @CurrentGoal + 1
		END

		SET @CurrentGroup = @CurrentGroup + 1
	END
END

-- EXEC Final1_2

-- /////////// --
-- FINAL STAGE --
-- /////////// --

-- DROP PROC IF EXISTS FinalStage

CREATE PROC FinalStage
AS
BEGIN
	-- Dates
	DECLARE @cupStartDate smalldatetime = '25-06-10 18:00'

	-- Clear previous data
	DELETE FROM FavoritePlayers WHERE Id IN (SELECT FP.Id FROM FavoritePlayers FP, Matches M WHERE FP.MatchFK = M.Id AND M.MatchTypeFK = 5)
	DELETE FROM FavoritePlayers WHERE Id IN (SELECT FP.Id FROM FavoritePlayers FP, Matches M WHERE FP.MatchFK = M.Id AND M.MatchTypeFK = 6)
	DELETE FROM FinalCupResults
	DELETE FROM Matches WHERE MatchTypeFK IN (5, 6)

	-- IIIrd place

	-- Should Team 2 Win the game?
	DECLARE @Team2Won INT = ABS(CHECKSUM(NEWID()) % 2)

	-- Team 1 Goals
	DECLARE @RandomTeam1Goals INT

	-- Team 2 Goals
	DECLARE @RandomTeam2Goals INT

	IF (@Team2Won = 1)
	BEGIN
		SET @RandomTeam1Goals = ABS(CHECKSUM(NEWID()) % 4)
		SET @RandomTeam2Goals = ABS(CHECKSUM(NEWID()) % 2) + @RandomTeam1Goals + 1
	END
	ELSE
	BEGIN
		SET @RandomTeam1Goals = ABS(CHECKSUM(NEWID()) % 4) + 1
		SET @RandomTeam2Goals = ABS(CHECKSUM(NEWID()) % @RandomTeam1Goals)
	END

	DECLARE @currentGroupDate smalldatetime = (SELECT DATEADD(day, 1, @cupStartDate))

	-- Get Team1FK and Team2FK From Final1_2Results
	DECLARE @Team1FK INT = (SELECT TOP(1) CountryFK FROM Final1_4Results WHERE CountryFK NOT IN (SELECT CountryFK FROM Final1_2Results) ORDER BY Score)
	DECLARE @Team2FK INT = (SELECT TOP(1) CountryFK FROM Final1_4Results WHERE CountryFK NOT IN (SELECT CountryFK FROM Final1_2Results) AND CountryFK != @Team1FK ORDER BY Score)

	-- Choosing random stadium to hold a match
	DECLARE @StadiumFK INT = (SELECT TOP(1) Id FROM Stadiums ORDER BY NEWID())

	-- Generating viewers present on a match depending on the volume of stadium
	DECLARE @Viewers INT = ABS(CHECKSUM(NEWID()) % (SELECT Capacity FROM Stadiums WHERE Id = @StadiumFK)) + (((SELECT Capacity FROM Stadiums WHERE Id = @StadiumFK) / 100) * 75)

	INSERT INTO Matches (Score1, Score2, Team1FK, Team2FK, MatchTypeFK, StadiumFK, Viewers, DateTime) 
	VALUES 
	(
		@RandomTeam1Goals,
		@RandomTeam2Goals,
		@Team1FK,
		@Team2FK,
		5,
		@StadiumFK,
		@Viewers,
		@currentGroupDate
	)

	IF (@Team2Won = 1)
	BEGIN
		INSERT INTO FinalCupResults (CountryFK, Place) VALUES (@Team2FK, 3)
	END
	ELSE
	BEGIN
		INSERT INTO FinalCupResults (CountryFK, Place) VALUES (@Team1FK, 3)
	END

	-- Add Team 1 Goals to favorite players

	DECLARE @CurrentGoal INT = 0

	WHILE (@CurrentGoal < @RandomTeam1Goals)
	BEGIN
		INSERT INTO FavoritePlayers (MatchFK, PlayerFK, Minutes) 
		VALUES
		(
			(SELECT IDENT_CURRENT('Matches')),
			(SELECT TOP(1) Id FROM Players WHERE CountryFK = @Team1FK AND PositionFK != 1 ORDER BY NEWID()),
			ABS(CHECKSUM(NEWID()) % 90) + 1
		)
			
		SET @CurrentGoal = @CurrentGoal + 1
	END

	-- Add Team 2 Goals to favorite players

	SET @CurrentGoal = 0

	WHILE (@CurrentGoal < @RandomTeam2Goals)
	BEGIN
		INSERT INTO FavoritePlayers (MatchFK, PlayerFK, Minutes) 
		VALUES
		(
			(SELECT IDENT_CURRENT('Matches')),
			(SELECT TOP(1) Id FROM Players WHERE CountryFK = @Team2FK AND PositionFK != 1 ORDER BY NEWID()),
			ABS(CHECKSUM(NEWID()) % 90) + 1
		)
			
		SET @CurrentGoal = @CurrentGoal + 1
	END

	-- Ist and IInd places

	-- Should Team 2 Win the game?
	SET @Team2Won = ABS(CHECKSUM(NEWID()) % 2)

	IF (@Team2Won = 1)
	BEGIN
		SET @RandomTeam1Goals = ABS(CHECKSUM(NEWID()) % 4)
		SET @RandomTeam2Goals = ABS(CHECKSUM(NEWID()) % 2) + @RandomTeam1Goals + 1
	END
	ELSE
	BEGIN
		SET @RandomTeam1Goals = ABS(CHECKSUM(NEWID()) % 4) + 1
		SET @RandomTeam2Goals = ABS(CHECKSUM(NEWID()) % @RandomTeam1Goals)
	END

	SET @currentGroupDate = (SELECT DATEADD(day, 1, @currentGroupDate))

	-- Get Team1FK and Team2FK From Final1_2Results
	SET @Team1FK = (SELECT TOP(1) CountryFK FROM Final1_2Results ORDER BY Score)
	SET @Team2FK = (SELECT CountryFK FROM Final1_2Results ORDER BY Score OFFSET 1 ROW FETCH FIRST 1 ROW ONLY)

	-- Choosing random stadium to hold a match
	SET @StadiumFK = (SELECT TOP(1) Id FROM Stadiums ORDER BY NEWID())

	-- Generating viewers present on a match depending on the volume of stadium
	SET @Viewers = ABS(CHECKSUM(NEWID()) % (SELECT Capacity FROM Stadiums WHERE Id = @StadiumFK)) + (((SELECT Capacity FROM Stadiums WHERE Id = @StadiumFK) / 100) * 75)

	INSERT INTO Matches (Score1, Score2, Team1FK, Team2FK, MatchTypeFK, StadiumFK, Viewers, DateTime) 
	VALUES 
	(
		@RandomTeam1Goals,
		@RandomTeam2Goals,
		@Team1FK,
		@Team2FK,
		6,
		@StadiumFK,
		@Viewers,
		@currentGroupDate
	)

	IF (@Team2Won = 1)
	BEGIN
		INSERT INTO FinalCupResults (CountryFK, Place) VALUES (@Team1FK, 2)
		INSERT INTO FinalCupResults (CountryFK, Place) VALUES (@Team2FK, 1)
	END
	ELSE
	BEGIN
		INSERT INTO FinalCupResults (CountryFK, Place) VALUES (@Team2FK, 2)
		INSERT INTO FinalCupResults (CountryFK, Place) VALUES (@Team1FK, 1)
	END

	-- Add Team 1 Goals to favorite players

	SET @CurrentGoal = 0

	WHILE (@CurrentGoal < @RandomTeam1Goals)
	BEGIN
		INSERT INTO FavoritePlayers (MatchFK, PlayerFK, Minutes) 
		VALUES
		(
			(SELECT IDENT_CURRENT('Matches')),
			(SELECT TOP(1) Id FROM Players WHERE CountryFK = @Team1FK AND PositionFK != 1 ORDER BY NEWID()),
			ABS(CHECKSUM(NEWID()) % 90) + 1
		)
			
		SET @CurrentGoal = @CurrentGoal + 1
	END

	-- Add Team 2 Goals to favorite players

	SET @CurrentGoal = 0

	WHILE (@CurrentGoal < @RandomTeam2Goals)
	BEGIN
		INSERT INTO FavoritePlayers (MatchFK, PlayerFK, Minutes) 
		VALUES
		(
			(SELECT IDENT_CURRENT('Matches')),
			(SELECT TOP(1) Id FROM Players WHERE CountryFK = @Team2FK AND PositionFK != 1 ORDER BY NEWID()),
			ABS(CHECKSUM(NEWID()) % 90) + 1
		)
			
		SET @CurrentGoal = @CurrentGoal + 1
	END
END

-- EXEC FinalStage

-- /////// --
--         --
-- REPLAYS --
--         --
-- /////// --

-- /// --
-- ALL --
-- /// --

-- DROP PROC IF EXISTS Replay

CREATE PROC Replay
AS 
BEGIN
	EXEC FillTeams
	EXEC GroupStage
	EXEC Final1_8
	EXEC Final1_4
	EXEC Final1_2
	EXEC FinalStage
END

-- EXEC Replay

-- /////////// --
-- GROUP STAGE --
-- /////////// --

-- DROP PROC IF EXISTS ReplayGroup

CREATE PROC ReplayGroupStage
AS 
BEGIN
	EXEC GroupStage
	EXEC Final1_8
	EXEC Final1_4
	EXEC Final1_2
	EXEC FinalStage
END

-- EXEC ReplayGroupStage

-- ///////// --
-- 1/8 FINAL --
-- ///////// --

-- DROP PROC IF EXISTS Replay1_8

CREATE PROC Replay1_8
AS 
BEGIN
	EXEC Final1_8
	EXEC Final1_4
	EXEC Final1_2
	EXEC FinalStage
END

-- EXEC Replay1_8

-- ///////// --
-- 1/4 FINAL --
-- ///////// --

-- DROP PROC IF EXISTS Replay1_4

CREATE PROC Replay1_4
AS 
BEGIN
	EXEC Final1_4
	EXEC Final1_2
	EXEC FinalStage
END

-- EXEC Replay1_4

-- ///////// --
-- 1/2 FINAL --
-- ///////// --

-- DROP PROC IF EXISTS Replay1_2

CREATE PROC Replay1_2
AS 
BEGIN
	EXEC Final1_2
	EXEC FinalStage
END

-- EXEC Replay1_2

-- ///// --
-- FINAL --
-- ///// --

-- DROP PROC IF EXISTS ReplayFinal

CREATE PROC ReplayFinal
AS 
BEGIN
	EXEC FinalStage
END

-- EXEC ReplayFinal

-- /////// --
--         --
-- QUERIES --
--         --
-- /////// --

-- Общее количество голов, забитых на протяжении чемпионата

SELECT SUM(Score1) + SUM(Score2) AS Goals FROM Matches

-- Среднее количество голов в каждом матче

SELECT ((SUM(Score1) + SUM(Score2)) / (SELECT COUNT(*) FROM Matches)) AS AverageGoals FROM Matches

-- Наибольшее и наименьшее количество мячей, забитых командами (2 команды)

SELECT TOP 1 *
FROM (
	SELECT CountryFK, SUM(Score) AS Score 
	FROM (
		SELECT SUM(Score1) AS Score, Team1FK AS CountryFK FROM Matches GROUP BY Team1FK
		UNION ALL
		SELECT SUM(Score2), Team2FK FROM Matches GROUP BY Team2FK
	) as ScoreWCountry
	GROUP BY CountryFK
) as ScoreWCountry
WHERE Score IN (
	SELECT MAX(Score) AS [Max]
	FROM (
		SELECT CountryFK, SUM(Score) AS Score 
		FROM (
			SELECT SUM(Score1) AS Score, Team1FK AS CountryFK FROM Matches GROUP BY Team1FK
			UNION ALL
			SELECT SUM(Score2), Team2FK FROM Matches GROUP BY Team2FK
		) as ScoreWCountry
		GROUP BY CountryFK
	) as ScoreWCountry
)
UNION
SELECT TOP 1 *
FROM (
	SELECT CountryFK, SUM(Score) AS Score 
	FROM (
		SELECT SUM(Score1) AS Score, Team1FK AS CountryFK FROM Matches GROUP BY Team1FK
		UNION ALL
		SELECT SUM(Score2), Team2FK FROM Matches GROUP BY Team2FK
	) as ScoreWCountry
	GROUP BY CountryFK
) as ScoreWCountry
WHERE Score IN (
	SELECT MIN(Score) AS [Max]
	FROM (
		SELECT CountryFK, SUM(Score) AS Score 
		FROM (
			SELECT SUM(Score1) AS Score, Team1FK AS CountryFK FROM Matches GROUP BY Team1FK
			UNION ALL
			SELECT SUM(Score2), Team2FK FROM Matches GROUP BY Team2FK
		) as ScoreWCountry
		GROUP BY CountryFK
	) as ScoreWCountry
)

-- Наибольшее и наименьшее количество мячей, пропущенных командами (2 команды)

SELECT TOP 1 *
FROM (
	SELECT CountryFK, SUM(Score) AS Score 
	FROM (
		SELECT SUM(Score2) AS Score, Team1FK AS CountryFK FROM Matches GROUP BY Team1FK
		UNION ALL
		SELECT SUM(Score1), Team2FK FROM Matches GROUP BY Team2FK
	) as ScoreWCountry
	GROUP BY CountryFK
) as ScoreWCountry
WHERE Score IN (
	SELECT MAX(Score) AS [Max]
	FROM (
		SELECT CountryFK, SUM(Score) AS Score 
		FROM (
			SELECT SUM(Score2) AS Score, Team1FK AS CountryFK FROM Matches GROUP BY Team1FK
			UNION ALL
			SELECT SUM(Score1), Team2FK FROM Matches GROUP BY Team2FK
		) as ScoreWCountry
		GROUP BY CountryFK
	) as ScoreWCountry
)
UNION
SELECT TOP 1 *
FROM (
	SELECT CountryFK, SUM(Score) AS Score 
	FROM (
		SELECT SUM(Score2) AS Score, Team1FK AS CountryFK FROM Matches GROUP BY Team1FK
		UNION ALL
		SELECT SUM(Score1), Team2FK FROM Matches GROUP BY Team2FK
	) as ScoreWCountry
	GROUP BY CountryFK
) as ScoreWCountry
WHERE Score IN (
	SELECT MIN(Score) AS [Max]
	FROM (
		SELECT CountryFK, SUM(Score) AS Score 
		FROM (
			SELECT SUM(Score2) AS Score, Team1FK AS CountryFK FROM Matches GROUP BY Team1FK
			UNION ALL
			SELECT SUM(Score1), Team2FK FROM Matches GROUP BY Team2FK
		) as ScoreWCountry
		GROUP BY CountryFK
	) as ScoreWCountry
)

-- Суммарная посещаемость всех матчей

SELECT SUM(Viewers) AS Viewers FROM Matches

-- Средняя посещаемость одного матча

SELECT ((SELECT SUM(Viewers) FROM Matches) / (SELECT COUNT(*) FROM Matches)) AS AverageViewers

-- Наибольшее и наименьшее число побед (2 отличившиеся команды)

SELECT TOP 1 CountryFK, Wins
FROM (
	SELECT CountryFK, SUM(Wins) AS Wins FROM (SELECT CountryFK, COUNT(*) AS Wins
		FROM (
			SELECT Team1FK AS CountryFK FROM Matches WHERE Score1 > Score2
			UNION ALL
			SELECT Team2FK AS CountryFK FROM Matches WHERE Score2 > Score1
		) as Countries
		GROUP BY CountryFK
		UNION
		SELECT Id, 0 FROM Countries) CW
	GROUP BY CountryFK
) as CountryWWins
WHERE Wins = (
	SELECT MAX(Wins) AS Wins
	FROM (
		SELECT CountryFK, SUM(Wins) AS Wins FROM (SELECT CountryFK, COUNT(*) AS Wins
			FROM (
				SELECT Team1FK AS CountryFK FROM Matches WHERE Score1 > Score2
				UNION ALL
				SELECT Team2FK AS CountryFK FROM Matches WHERE Score2 > Score1
			) as Countries
			GROUP BY CountryFK
			UNION
			SELECT Id, 0 FROM Countries) CW
		GROUP BY CountryFK
	) as CountryWWins
)
UNION ALL
SELECT TOP 1 CountryFK, Wins
FROM (
	SELECT CountryFK, SUM(Wins) AS Wins FROM (SELECT CountryFK, COUNT(*) AS Wins
		FROM (
			SELECT Team1FK AS CountryFK FROM Matches WHERE Score1 > Score2
			UNION ALL
			SELECT Team2FK AS CountryFK FROM Matches WHERE Score2 > Score1
		) as Countries
		GROUP BY CountryFK
		UNION
		SELECT Id, 0 FROM Countries) CW
	GROUP BY CountryFK
) as CountryWWins
WHERE Wins = (
	SELECT MIN(Wins) AS Wins
	FROM (
		SELECT CountryFK, SUM(Wins) AS Wins FROM (SELECT CountryFK, COUNT(*) AS Wins
			FROM (
				SELECT Team1FK AS CountryFK FROM Matches WHERE Score1 > Score2
				UNION ALL
				SELECT Team2FK AS CountryFK FROM Matches WHERE Score2 > Score1
			) as Countries
			GROUP BY CountryFK
			UNION
			SELECT Id, 0 FROM Countries) CW
		GROUP BY CountryFK
	) as CountryWWins
)

-- Наибольшее и наименьшее количество поражений (2 команды)

SELECT TOP 1 CountryFK, Loses
FROM (
	SELECT CountryFK, SUM(Loses) AS Loses FROM (SELECT CountryFK, COUNT(*) AS Loses
		FROM (
			SELECT Team1FK AS CountryFK FROM Matches WHERE Score1 < Score2
			UNION ALL
			SELECT Team2FK AS CountryFK FROM Matches WHERE Score2 < Score1
		) as Countries
		GROUP BY CountryFK
		UNION
		SELECT Id, 0 FROM Countries) CW
	GROUP BY CountryFK
) as CountryWWins
WHERE Loses = (
	SELECT MAX(Loses) AS Wins
	FROM (
		SELECT CountryFK, SUM(Loses) AS Loses FROM (SELECT CountryFK, COUNT(*) AS Loses
			FROM (
				SELECT Team1FK AS CountryFK FROM Matches WHERE Score1 < Score2
				UNION ALL
				SELECT Team2FK AS CountryFK FROM Matches WHERE Score2 < Score1
			) as Countries
			GROUP BY CountryFK
			UNION
			SELECT Id, 0 FROM Countries) CW
		GROUP BY CountryFK
	) as CountryWWins
)
UNION ALL
SELECT TOP 1 CountryFK, Loses
FROM (
	SELECT CountryFK, SUM(Loses) AS Loses FROM (SELECT CountryFK, COUNT(*) AS Loses
		FROM (
			SELECT Team1FK AS CountryFK FROM Matches WHERE Score1 < Score2
			UNION ALL
			SELECT Team2FK AS CountryFK FROM Matches WHERE Score2 < Score1
		) as Countries
		GROUP BY CountryFK
		UNION
		SELECT Id, 0 FROM Countries) CW
	GROUP BY CountryFK
) as CountryWWins
WHERE Loses = (
	SELECT MIN(Loses) AS Loses
	FROM (
		SELECT CountryFK, SUM(Loses) AS Loses FROM (SELECT CountryFK, COUNT(*) AS Loses
			FROM (
				SELECT Team1FK AS CountryFK FROM Matches WHERE Score1 < Score2
				UNION ALL
				SELECT Team2FK AS CountryFK FROM Matches WHERE Score2 < Score1
			) as Countries
			GROUP BY CountryFK
			UNION
			SELECT Id, 0 FROM Countries) CW
		GROUP BY CountryFK
	) as CountryWWins
)

-- Лучшие бомбардиры (игроки, забившие наибольшее количество голов)

SELECT P.FirstName + ' ' + P.LastName AS Name, C.Name AS Country, Goals
FROM (
	SELECT PlayerFK, COUNT(*) AS Goals
	FROM FavoritePlayers
	GROUP BY PlayerFK
) PG, Players P, Countries C
WHERE 
	PG.PlayerFK = P.Id
	AND
	P.CountryFK = C.Id
	AND
	Goals = (
		SELECT MAX(Goals) AS [Max]
		FROM (
			SELECT PlayerFK, COUNT(*) AS Goals
			FROM FavoritePlayers
			GROUP BY PlayerFK
		) as PlayersGoals
	)

-- Список команд, занявших призовые места

SELECT * FROM FinalCupResults ORDER BY Place

-- /////////////////////////////////////////////////// --
-- /////////////////////////////////////////////////// --
-- /////////////////////////////////////////////////// --
-- /////////////////////////////////////////////////// --
-- /////////////////////////////////////////////////// --
-- /////////////////////////////////////////////////// --
-- /////////////////////////////////////////////////// --
-- /////////////////////////////////////////////////// --
-- /////////////////////////////////////////////////// --
-- /////////////////////////////////////////////////// --

-- Procedures

EXEC FillTeams
EXEC GroupStage
EXEC Final1_8
EXEC Final1_4
EXEC Final1_2
EXEC FinalStage

-- Replays

EXEC Replay
EXEC ReplayGroupStage
EXEC Replay1_8
EXEC Replay1_4
EXEC Replay1_2
EXEC ReplayFinal

-- CHECK VALUES

SELECT * FROM Players WHERE CountryFK IS NOT NULL
SELECT * FROM Matches
-- Одинаковое кол-во голов только на групповой стадии
SELECT * FROM Matches WHERE Score1 = Score2
SELECT * FROM FavoritePlayers
SELECT * FROM GroupStageResults
SELECT * FROM Final1_8Results
SELECT * FROM Final1_4Results
SELECT * FROM Final1_2Results
SELECT * FROM FinalCupResults
