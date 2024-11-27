------------------Day 5 DT--------------------

--26-UPDATE tablo_adı SET sütunadı=yeni değer 
--WHERE koşul 
-- koşulu sağlayan kayıtlar güncellenir

------
--employees4 adli bir tablo olusturalim

CREATE TABLE employees4 (
id INT UNIQUE, 
isim VARCHAR(50), 
sehir VARCHAR(50), 
maas INT, 
isyeri VARCHAR(20)
);

INSERT INTO employees4 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO employees4 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO employees4 VALUES(345678901, null, 'Ankara', 3000, 'Vakko');
INSERT INTO employees4 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO employees4 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO employees4 VALUES(678901234, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO employees4 VALUES(789012345, 'Fatma Yasa', null, 2500, 'Vakko');
INSERT INTO employees4 VALUES(890123456, null, 'Bursa', 2500, 'Vakko');
INSERT INTO employees4 VALUES(901234567, 'Ali Han', null, 2500, 'Vakko');

SELECT * FROM employees4;

/*Senaryo 1: employees4 adli bir tablo olusturunuz. id’si 123456789 olan çalışanın isyeri ismini 'Trendyol' olarak güncelleyiniz.*/
/*Scenario 1: Create a table named employees4. update the workplace name of the employee whose id is 123456789 to ‘Trendyol'.*/

UPDATE employees4
SET isyeri = 'Trendyol'
WHERE id=123456789;

----
/*Senaryo 2: id’si 567890123 olan çalışanın ismini 'Veli Yıldırım' ve sehrini 'Bursa' olarak güncelleyiniz.*/
/*Scenario 2: Update the name of the employee whose id is 567890123 as 'Veli Yıldırım' and the city as ‘Bursa'.*/

UPDATE employees4
SET isim = 'Veli Yildirim', sehir = 'Bursa'
WHERE id = 567890123;

SELECT * FROM employees4;

/*Senaryo 3: brands tablosundaki marka_id değeri 102’ye eşit veya büyük olanların marka_id’sini 2 ile çarparak değiştirin.*/
/*Scenario 3: change the marka_id of brands in the brands table with a marka_id greater than or equal to 102 by multiplying by 2.*/

SELECT * FROM brands

UPDATE brands
SET marka_id = marka_id * 2
WHERE marka_id >= 102;

/*Senaryo 4: brands tablosundaki tüm markaların calisan_sayisi değerlerini marka_id ile toplayarak güncelleyiniz.*/
/*Scenario 4: Update the calisan_sayisi values of all brands in the brands table by adding them with marka_id.*/

UPDATE brands
SET calisan_sayisi = marka_id + calisan_sayisi

/*Senaryo 5: employees4 tablosundan Ali Seker’in isyerini, 567890123 id’li çalışanın isyeri ismi ile güncelleyiniz.*/
/*Scenario 5: Update the workplace of Ali Seker from table employees4 with the workplace name of the employee with id 567890123.*/

SELECT * FROM employees4;

UPDATE employees4
SET isyeri = (SELECT isyeri FROM employees4 WHERE id = 567890123)
WHERE isim = 'Ali Seker';

/*Senaryo 6: employees4 tablosunda maasi 1500 olanların isyerini, markalar tablosunda marka_id=100 olan markanın ismi ile değiştiriniz.*/

/*Scenario 6: Replace the workplace of those with salary 1500 in the employees4 table with the name of the brand with marka_id=100 in the brands table.*/

UPDATE employees4
SET isyeri = (SELECT marka_isim FROM brands WHERE marka_id = 100)
WHERE maas = 1500;

--employees4 tablosundaki isyeri 'Vakko' olanların sehir bilgisinin sonuna ' Şubesi' ekleyiniz.
--Add ' Şubesi’ at the end of the city information of those whose workplace is 'Vakko' in the employees4 table.

--|| operatörü, SQL'de dizeleri birleştirmek (concatenate) için kullanılır. Java'daki + operatörü ile benzer işlevi görür.

UPDATE employees4
SET sehir = sehir || ' Subesi'
WHERE isyeri = 'Vakko';

SELECT * FROM employees4;

--alternatif, null'i algilamasi icin

UPDATE employees4
SET sehir = CONCAT(sehir, ' Subesi')
WHERE isyeri = 'Vakko'

--27-IS NULL condition 
 
--Ornek 1: employees4 tablosunda isim sütunu null olanları listeleyiniz.
--Example 1: List those whose name column is null in the employees4 table.

SELECT * FROM employees4
WHERE isim IS NULL

--Ornek 2: employees4 tablosunda isim sütunu null olmayanları listeleyiniz.
--Example 2: List those whose name column is not null in the employees4 table.

SELECT * FROM employees4
WHERE isim IS NOT NULL

--Ornek 3: employees4 tablosunda isim sütunu null olanların isim değerini 'isimsiz' olarak güncelleyiniz.
--Example 3: Update the name value of those whose name column is null in the employees4 table to ‘isimsiz'.

UPDATE employees4
SET isim = 'isimsiz'
WHERE isim IS NULL

-------------------
--28-ORDER BY: Kayıtları belirli bir field’e göre azalan/artan şekilde sıralamamızı sağlar.
--VARSAYILAN olarak ASC(natural-artan-doğal) olarak sıralar

/*ORDER BY komutu yalnızca SELECT sorgularıyla birlikte kullanılır çünkü amacı, bir sorgunun sonuç setini belirli kriterlere göre sıralamaktır.  INSERT, UPDATE ve DELETE komutlarıyla kullanılamaz. Bu komutlar, veritabanında veri eklemek, güncellemek veya silmek için kullanılır ve sonuç seti döndürmezler.*/

DROP TABLE person;

CREATE TABLE person
(
	ssn char(9),
	isim varchar(50),
	soyisim varchar(50),  
	adres varchar(50)
);

INSERT INTO person VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO person VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO person VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO person VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO person VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO person VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');
INSERT INTO person VALUES(256789018, 'Samet','Bulut', 'Izmir'); 
INSERT INTO person VALUES(256789013, 'Veli','Cem', 'Bursa'); 
INSERT INTO person VALUES(256789010, 'Samet','Bulut', 'Ankara'); 

SELECT * FROM person;

/*Senaryo 1: person tablosundaki tüm kayıtları adrese göre (artan sirada) sıralayarak listeleyiniz.*/
/*Scenario 1: List all records in the person table sorted by address (in ascending order).*/

SELECT *
FROM person
ORDER BY adres

SELECT *
FROM person
ORDER BY adres ASC --ASC natural siralama yapar (A_Z)

SELECT *
FROM person
ORDER BY adres, isim, soyisim;

/*Senaryo 2: person tablosundaki tüm kayıtları soyisime göre (azalan) sıralayarak listeleyiniz.*/
/*Scenario 2: List all records in the person table sorted by surname (descending).*/

SELECT *
FROM person
ORDER BY soyisim DESC

/*Senaryo 3: person tablosundaki tüm kayıtları isme göre azalan, soyisme göre artan sekilde sıralayarak listeleyiniz.*/
/*Scenario 3: List all records in the person table in descending order by first name and ascending order by surname.*/

SELECT *
FROM person
ORDER BY isim DESC, soyisim ASC

/*Senaryo 4: person tablosunda isim ve soyisim değerlerini, soyisim kelime uzunluklarına göre sıralayarak listeleyiniz.*/
/*Scenario 4: List the name and surname values in the person table, sorted by surname word lengths.*/

SELECT isim, soyisim
FROM person
ORDER BY LENGTH(soyisim)

SELECT isim, soyisim, LENGTH(soyisim) AS karakter_sayisi
FROM person
ORDER BY LENGTH(soyisim)

SELECT isim, soyisim, LENGTH(soyisim) AS karakter_sayisi
FROM person
ORDER BY karakter_sayisi --ORDER BY takma ismi tanir

/*Senaryo 5: person tablosunda, tüm isim ve soyisim değerlerini aralarında bir boşluk ile aynı sutunda çağırarak, her bir isim ve soyisim değerinin toplam uzunluğuna göre sıralayınız.*/

/*Scenario 5: In the person table, call all first and last name values in the same column with a space between them and sort by the total length of each first and last name value.*/

SELECT CONCAT(isim,' ', soyisim) AS isim_soyisim
FROM person
ORDER BY LENGTH(isim) + LENGTH(soyisim);

SELECT CONCAT(isim,' ', soyisim) AS isim_soyisim,LENGTH(CONCAT(isim, soyisim)) karakter_sayisi
FROM person
ORDER BY LENGTH(CONCAT(isim, soyisim));

/*Senaryo 6: employees4 tablosunda maaşı ortalama maaştan yüksek olan çalışanların isim,şehir ve maaşlarını maaşa göre artan sekilde sıralayarak listeleyiniz.*/

/*Scenario 6: In table employees4, list the names, cities and salaries of employees whose salaries are higher than the average salary in ascending order by salary.*/

SELECT * FROM employees4;

SELECT AVG(maas) FROM employees4; --2666.6666666666666667

SELECT isim, sehir, maas
FROM employees4
WHERE maas > (SELECT AVG(maas) FROM employees4)
ORDER BY maas;

----------------------
--29-GROUP BY

CREATE TABLE greengrocer
(
	isim varchar(50),
	urun_adi varchar(50),
	urun_miktar int
);

INSERT INTO greengrocer VALUES( 'Ali', 'Elma', 5);
INSERT INTO greengrocer VALUES( 'Ayse', 'Armut', 3);
INSERT INTO greengrocer VALUES( 'Veli', 'Elma', 2);  
INSERT INTO greengrocer VALUES( 'Hasan', 'Uzum', 4);  
INSERT INTO greengrocer VALUES( 'Ali', 'Armut', 2);  
INSERT INTO greengrocer VALUES( 'Ayse', 'Elma', 3);  
INSERT INTO greengrocer VALUES( 'Veli', 'Uzum', 5);  
INSERT INTO greengrocer VALUES( 'Ali', 'Armut', 2);  
INSERT INTO greengrocer VALUES( 'Veli', 'Elma', 3);  
INSERT INTO greengrocer VALUES( 'Ayse', 'Uzum', 2);

SELECT * FROM greengrocer;

/*Senaryo 1: greengrocer tablosundaki tüm isimleri ve her bir isim için, toplam ürün miktarını görüntüleyiniz.*/
/*Scenario 1: Display all names in the greengrocer table and, for each name, the total quantity of products.*/

SELECT isim, SUM(urun_miktar) toplam_kg
FROM greengrocer
GROUP BY isim;

/*Senaryo 2: greengrocer tablosundaki tüm isimleri ve her bir isim için toplam ürün miktarını görüntüleyiniz.
Toplam ürün miktarına göre azalan olarak sıralayınız.*/

/*Scenario 2: Display all names in the greengrocer table and the total product quantity for each name.
Sort in descending order by total product quantity.*/

SELECT isim, SUM(urun_miktar) toplam_kg
FROM greengrocer
GROUP BY isim
ORDER BY SUM(urun_miktar) DESC;

/*Senaryo 3: Her bir ismin aldığı, her bir ürünün toplam miktarını, isme göre sıralı görüntüleyiniz.*/
/*Scenario 3: Display the total amount of each product purchased by each name, ordered by name.*/

SELECT isim, urun_adi, SUM(urun_miktar) toplam_kg
FROM greengrocer
GROUP BY isim, urun_adi
ORDER BY isim

/*Senaryo 4: ürün adina göre, her bir ürünü alan toplam kişi sayısını gösteriniz.*/
/*Scenario 4: by product name, show the total number of people who bought each product.*/

SELECT urun_adi, COUNT(DISTINCT(isim)) kisi_sayisi
FROM greengrocer
GROUP BY urun_adi

/*Senaryo 5: Isme göre, alınan toplam ürün miktarı ve ürün çeşit miktarını bulunuz*/
/*Scenario 5: According to the name, find the total quantity of products received and the quantity of product types*/

SELECT isim, SUM(urun_miktar) toplam_kg, COUNT(DISTINCT urun_adi) cesit_sayisi
FROM greengrocer
GROUP BY isim

--ÖDEV: Alinan ürün miktarina gore musteri sayisinı görüntüleyiniz.
--musteri sayisina göre artan sirada sıralayınız.

--30-HAVING ifadesi
--where kayitlari filtreler, having ise sonuclari

--where kayitlari filtreler, having sonuclari filtreler
--group by olmadan having kullanilmasi anlamsiz.

CREATE TABLE personel  (
	id int,
	isim varchar(50),
	sehir varchar(50), 
	maas int,  
	sirket varchar(20)
);

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda'); 
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota'); 
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford'); 
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personel VALUES(678901245, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

SELECT * FROM personel;

/*Senaryo 1: Her bir şirketin MIN maas bilgisini, bu bilgi eğer 4000 den fazla ise görüntüleyiniz.*/
/*Scenario 1: Display the MIN salary information for each company, if this information is more than 4000 */

SELECT sirket, MIN(maas) min_maas
FROM personel
GROUP BY sirket
HAVING MIN(maas) > 4000

/*Senaryo 2: Maaşı 4000 den fazla olan çalışanlarin sirketlerini bulduktan sonra, bu sinirin ustunde olan MIN maas bilgisini her sirket icin görüntüleyiniz.*/

/*Scenario 2: After finding the companies of employees with salaries over 4000, display the MIN salary information for each company above this limit.*/

SELECT sirket, MIN(maas) min_maas
FROM personel
WHERE maas > 4000
GROUP BY sirket

/*Senaryo 3: Her bir ismin ...