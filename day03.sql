/*Senaryo: “worker” ve “address” adlarinda iki tablo oluşturun.

worker tablosu sütunları: 
id CHAR(5), isim VARCHAR(50), maas INT, ise_baslama DATE

address tablosu sütunları:
adres_id CHAR(5), sokak VARCHAR(30), cadde VARCHAR(30), sehir VARCHAR(30)

Tablolari birbirine baglayarak, UNIQUE, NOT NULL uygulamasi yapiniz*/

/*Scenario: Create two tables named "worker" and "address".

worker table columns: 
id CHAR(5), name VARCHAR(50), salary INT, job_start DATE

address table columns:
address_id CHAR(5), street VARCHAR(30), street VARCHAR(30), city VARCHAR(30)

Apply UNIQUE, NOT NULL by linking tables together*/

--NOT: UNIQUE null kabul eder. Birden fazla da kabul eder cunku null bir deger degildir. Karsilastirma yapmaz

CREATE TABLE worker(
	id char(5) PRIMARY KEY, 
	isim varchar(50) UNIQUE,
	maas int NOT NULL,
	ise_baslama date
);

CREATE TABLE address(
	adres_id char(5),
	sokak varchar(30),
	cadde varchar(30),
	sehir varchar(30),
	FOREIGN KEY(adres_id) REFERENCES worker(id) 
);

SELECT * FROM worker;
SELECT * FROM address;

--NOT: UNIQUE null kabul eder. Birden fazla da kabul eder cunku null bir deger degildir. Karsilastirma yapmaz

INSERT INTO worker VALUES('10002', 'Donatello' ,12000, '2018-04-14'); --basarili
INSERT INTO worker VALUES('10003', null, 5000, '2018-04-14'); --basarili
--INSERT INTO worker VALUES('10004', 'Donatello', 5000, '2018-04-14'); --HATA, isim unique cunku
INSERT INTO worker VALUES('10005', 'Michelangelo', 5000, '2018-04-14'); --basarili
--INSERT INTO worker VALUES('10006', 'Leonardo', null, '2019-04-12'); --HATA, maas null olamaz
--INSERT INTO worker VALUES('10007', 'Raphael', '', '2018-04-14'); --HATA, maas int bekliyor
INSERT INTO worker VALUES('', 'April', 2000, '2018-04-14'); --basarili, PK bos string kabul eder ama kullanilmasi onerilmez
--INSERT INTO worker VALUES('', 'Ms.April', 2000, '2018-04-14'); --HATA, PK unique'dir
--INSERT INTO worker VALUES('10002', 'Splinter', 12000, '2018-04-14'); HATA, 10002 daha once kullanildi
--INSERT INTO worker VALUES(null, 'Fred', 12000, '2018-04-14'); HATA, PK null kabul etmez
INSERT INTO worker VALUES('10008', 'Barnie', 10000, '2018-04-14'); --basarili
INSERT INTO worker VALUES('10009', 'Wilma', 11000, '2018-04-14'); --basarili
INSERT INTO worker VALUES('10010', 'Betty' ,12000, '2018-04-14'); --basarili

--child --FK
INSERT INTO address VALUES('10003','Ninja Sok', '40.Cad.', 'IST'); --basarili
INSERT INTO address VALUES('10003','Kaya Sok', '50.Cad.', 'Ankara'); --basarili
INSERT INTO address VALUES('10002','Taş Sok', '30.Cad.', 'Konya'); --basarili
INSERT INTO address VALUES('10012','Taş Sok', '30.Cad.', 'Konya'); --HATA, PK'de 10012 yok
INSERT INTO address VALUES(NULL,'Taş Sok', '23.Cad.', 'Konya'); --basarili
INSERT INTO address VALUES(NULL,'Taş Sok', '23.Cad.', 'Konya'); --basarili

-----------------------------
/*14- WHERE ifadesi, belirli koşulları karşılayan kayıtları seçmek için kullanılır. Bir SELECT, UPDATE ya da DELETE sorgusunda, hangi satırların işleme dahil edileceğini belirtmek için WHERE koşulu eklenir.*/

--worker tablosundan ismi 'Donatello' olanların tüm bilgilerini listeleyelim
--Let's list all the information of those whose name is 'Donatello' from the worker table

SELECT * FROM worker WHERE isim = 'Donatello';

--worker tablosundan maaşı 5000’den fazla olanların tüm bilgilerini listeleyelim
--Let's list all the information of those whose salary is more than 5000 from the worker table

SELECT * FROM worker WHERE maas>5000;

--worker tablosundan maaşı 5000’den fazla olanların isim ve maaşlarını listeleyelim
--Let's list the names and salaries of those whose salary is more than 5000 from the worker table

SELECT isim, maas FROM worker WHERE maas > 5000;

--address tablosundan sehri 'Konya' ve 
--adres_id'si 10002 olan kaydın tüm verilerini getirelim
--select the city 'Konya' from the address table and 
--Let's get all the data of the record with address_id 10002

SELECT * FROM address WHERE sehir = 'Konya' AND adres_id = '10002';

--sehri 'Konya' veya 'Bursa' olan adreslerin cadde ve sehir bilgilerini getirelim.
--Let's get the street and city information for addresses whose city is 'Konya' or ‘Bursa'.

SELECT cadde, sehir FROM address WHERE sehir = 'Konya' OR sehir = 'Bursa';

-----------------
--15-Tablodan kayıt silme-DELETE FROM ... komutu:DML

/*
DELETE FROM
DML (Data Manipulation Language) Komutu: DELETE FROM bir DML komutudur. DML komutları, veritabanındaki verileri yönetir ve değiştirir.

Rollback İle Geri Alınabilir: DELETE işlemi, bir işlem (transaction) içinde yapıldığında ve işlem henüz COMMIT edilmeden ROLLBACK komutu ile geri alınabilir. COMMIT edilmişse, bu işlem kalıcı hale gelir ve veritabanında yapılan değişiklikler geri alınamaz. Ayrica, transaction kullanılmadan yapılan DELETE işlemi kalıcıdır.

Performans: Büyük tablolarda DELETE komutu yavaş çalışabilir, çünkü her bir satırı tek tek siler ve işlem sırasında log kayıtları tutar. Bu nedenle, büyük miktarlarda veriyi silmek için farklı stratejiler veya komutlar kullanmak performansı iyileştirebilir (örneğin, TRUNCATE komutu veya verileri daha küçük parçalara bölerek silmek(LIMIT ile)).*/

------------
/*Senaryo: “students1” adinda bir tablo oluşturun.

students1 tablosu sütunları: 
id INTEGER, isim VARCHAR(50), veli_isim VARCHAR(50), yazili_notu INTEGER

Tablo uzerinde cesitli silme islemleri yapiniz*/

/*Scenario: Create a table named "students1".

students1 table columns: 
id INTEGER, name VARCHAR(50), parent_name VARCHAR(50), written_note INTEGER

Perform various deletion operations on the table*/

CREATE TABLE students1
(
	id int,
	isim VARCHAR(50),
	veli_isim VARCHAR(50),
	yazili_notu int       
);

INSERT INTO students1 VALUES(122, 'Kerem Can', 'Fatma',75),
(123, 'Ali Can', 'Hasan',75),
(124, 'Veli Han', 'Ayse',85),
(125, 'Kemal Tan', 'Hasan',85),
(126, 'Ahmet Ran', 'Ayse',95),
(127, 'Mustafa Bak', 'Can',99),
(128, 'Mustafa Bak', 'Ali', 99),
(129, 'Mehmet Bak', 'Alihan', 89);

SELECT * FROM students1;

--id=123 olan kaydı silelim.
-- Let's delete the record with id=123.

DELETE FROM students1 WHERE id=123;

--ismi Kemal Tan olan kaydı silelim.
-- delete the entry with the name Kemal Tan.

DELETE FROM students1 WHERE isim = 'Kemal Tan';

--ismi Ahmet Ran veya Veli Han olan kayıtları silelim
-- delete records with the name Ahmet Ran or Veli Han

DELETE FROM students1 WHERE isim = 'Ahmet Ran' OR isim = 'Veli Han';

---------------------
--15-a-tablodaki tüm kayıtları silme:DELETE FROM: DML,rollback ile geri alınabilir

SELECT * FROM students;

--students tablosundan tüm kayıtları silelim.
-- delete all records from the students table.

--NOT: DELETE FROM komutu koşulsuz kullanıldığında
--tüm satırları siler ancak tablo kalır.

--satirlari tek tek sildigi icin yavastir. Daha hizlisi var. (TRUNCATE)

DELETE FROM students;

--------------
--16-Tablodaki tüm kayıtları silme:TRUNCATE TABLE:DDL

/*
TRUNCATE TABLE komutunun bazı önemli özellikleri:

Hızlı Temizlik: TRUNCATE TABLE, tablodaki tüm verileri hızla silmek için kullanılır. Bu, özellikle büyük tablolar için DELETE komutundan daha verimlidir çünkü TRUNCATE log kayıtlarını daha az tutar ve tüm satırları tek seferde siler.

Koşulsuz: TRUNCATE TABLE, DELETE komutunun aksine, WHERE koşulu kullanmaz ve tablodaki tüm satırları siler.

İşlem Logları: TRUNCATE TABLE, DELETE komutuna kıyasla daha az işlem logu tutar, bu da veritabanı kaynaklarını daha az tüketmesini sağlar.

Yapıyı Korur: TRUNCATE TABLE tablonun yapısını korur, yani sütunlar ve kısıtlamalar (constraints) silinmez, sadece içerik temizlenir. (Delete’te korur)

İşlem Geri Alınamaz: Çoğu veritabanı sistemlerinde TRUNCATE TABLE komutu işlem bloğu içinde kullanılmadığı sürece geri alınamaz. Ancak, bazı sistemlerde (örneğin, PostgreSQL) TRUNCATE TABLE komutu bir işlem bloğu içinde kullanıldığında ve işlem tamamlanmadan önce ROLLBACK komutu verildiğinde geri alınabilir.*/

CREATE TABLE doctors(
	id SERIAL,
	name VARCHAR(30) NOT NULL,
	salary REAL,
	email VARCHAR(50) UNIQUE	
);

INSERT INTO doctors(name,salary,email) VALUES('Dr. Gregory House',6000,'dr@mail.com'); --basarili
--INSERT INTO doctors(salary,email) VALUES(6000,'doctor@mail.com'); --HATA, name null olamaz
INSERT INTO doctors(name,salary,email) VALUES('',6000,'doc@mail.com');

SELECT * FROM doctors;

--doctors tablosundan tüm kayıtları silelim.
--Delete all records from the doctors table.

TRUNCATE TABLE doctors;

-----------------------
--17-parent-child ilişkisi olan tablolardan kayıt silme
--Delete records from tables with parent-child relationship

SELECT * FROM worker; --parent, referans verir
SELECT * FROM address; --child, referans alir

--------------
--worker tablosundan tüm kayıtları silelim.
-- delete all records from the worker table.

DELETE FROM worker; --HATA
--worker tablosunda address tarafından referans alınan kayıtlar olduğu 
--için silmeye izin yok

DELETE FROM worker WHERE id = '10002'; --HATA
--id=10002 olan kayıt adresler tarafından referans alındığı 
--için silmeye izin yok.Once child’dan iliskiyi koparalim

DELETE FROM address WHERE adres_id = '10002';
--referans alınan kayıt silindi,ilişki koparıldı

DELETE FROM worker WHERE id = '10002'; --simdi basarili

DELETE FROM address; --tum iliski koparildi
DELETE FROM worker; --artık hiçbir kayıt ref alınmadığı için başarılı.

--------------------------
--18-ON DELETE CASCADE

/*Senaryo: “students2” ve “grades2” adlarinda iki tablo oluşturun.

students2 tablosu sütunları: 
id int, isim VARCHAR(50), veli_isim VARCHAR(50), yazili_notu int

grades2 tablosu sütunları:
talebe_id int, ders_adi varchar(30), yazili_notu int

Tablolari birbirine baglayarak, ON DELETE CASCADE uygulamasi yapiniz*/

/*Scenario: Create two tables named "students2" and "grades2".

students2 table columns: 
id int, name VARCHAR(50), parent_name VARCHAR(50), written_note int

grades2 table columns:
student_id int, course_name varchar(30), written_note int

Apply ON DELETE CASCADE by linking the tables together*/

CREATE TABLE students2
(
	id int primary key,  
	isim VARCHAR(50),
	veli_isim VARCHAR(50),
	yazili_notu int
);

CREATE TABLE grades2( 
	talebe_id int,
	ders_adi varchar(30),
	yazili_notu int,
	CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES students2(id) ON DELETE CASCADE 	
);

INSERT INTO students2 VALUES
(122, 'Kerem Can', 'Fatma',75),
(123, 'Ali Can', 'Hasan',75),
(124, 'Veli Han', 'Ayse',85),
(125, 'Kemal Tan', 'Hasan',85),
(126, 'Ahmet Ran', 'Ayse',95),
(127, 'Mustafa Bak', 'Can',99),
(128, 'Mustafa Bak', 'Ali', 99),
(129, 'Mehmet Bak', 'Alihan', 89);

INSERT INTO grades2 VALUES 
 ('123','kimya',75),
 ('124', 'fizik',65),
 ('125', 'tarih',90),
 ('126', 'Matematik',90),
 ('127', 'Matematik',90),
 (null, 'tarih',90);

SELECT * FROM students2; --parent
SELECT * FROM grades2; --child

DELETE from grades2 where talebe_id = 123; --basarili, child'dan dogrudan silebiliriz
DELETE FROM students2 WHERE id=126; --basarili

DELETE FROM students2;

DELETE FROM grades2;

----------------
--19-tabloyu silme

DROP TABLE students2; --HATA, cunku child'i var

DROP TABLE students2 CASCADE; --cascade sadece baglantiyi koparir

DROP TABLE IF EXISTS students18;
--boyle bir tablo yoksa uygulama durmasin varsa silsin demektir(IF EXISTS)

----------------------
--20-IN Condition
--IN: Bir değerin belirli bir değerler listesi içinde olup olmadığını kontrol eder.

/*Senaryo: “customers” adinda bir tablo oluşturun.

customers tablosu sütunları: 
urun_id INTEGER, musteri_isim VARCHAR(50), urun_isim VARCHAR(50)

Tablo uzerinde IN kullanimi yapiniz*/

/*Scenario: Create a table named "customers".

customers table columns: 
product_id INTEGER, customer_name VARCHAR(50), product_name VARCHAR(50)

Use IN on the table */

CREATE TABLE customers (
	urun_id int,  
	musteri_isim varchar(50),
	urun_isim varchar(50)
);

INSERT INTO customers VALUES (10, 'Mark', 'Orange');
INSERT INTO customers VALUES (10, 'Mark', 'Orange');
INSERT INTO customers VALUES (20, 'John', 'Apple');
INSERT INTO customers VA...