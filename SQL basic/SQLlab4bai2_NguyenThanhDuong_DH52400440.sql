--1. Cho biết mã chuyến bay, ngày đi, cùng với tên, địa chỉ, điện thoại của tất cả các hành
--khách đi trên chuyến bay đó. Sắp xếp theo thứ tự tăng dần của mã chuyến bay và theo ngày
--đi giảm dần.
select * from CHUYENBAY
select * from LICHBAY
select * from DATCHO
select * from KHACHHANG
select CHUYENBAY.MACB,LICHBAY.NGAYDI,TEN,DCHI,DTHOAI
from CHUYENBAY join LICHBAY on CHUYENBAY.MACB = LICHBAY.MACB
				join DATCHO on LICHBAY.NGAYDI= DATCHO.NGAYDI
				join KHACHHANG on DATCHO.MAKH=KHACHHANG.MAKH
order by Chuyenbay.MACB ASC , LICHBAY.NGAYDI DESC
--2. Cho biết mã chuyến bay, ngày đi, cùng với tên, địa chỉ, điện thoại của tất cả những nhân
--viên được phân công trong chuyến bay đó. Sắp xếp theo thứ tự tăng dần của mã chuyến
--bay và theo ngày đi giảm dần.
select CHUYENBAY.MACB,LICHBAY.NGAYDI,TEN,DCHI,DTHOAI
from CHUYENBAY join LICHBAY on CHUYENBAY.MACB = LICHBAY.MACB
				join PHANCONG on LICHBAY.NGAYDI= PHANCONG.NGAYDI
				join NHANVIEN on PHANCONG.MANV = NHANVIEN.MANV
order by Chuyenbay.MACB ASC , LICHBAY.NGAYDI DESC

--3. Cho biết các chuyến bay (mã số chuyến bay, ngày đi và tên của phi công) trong đó phi
--công có mã 1001 được phân công lái.
select * from CHUYENBAY
select * from LICHBAY
select * from NHANVIEN
select  CHUYENBAY.MACB,LICHBAY.NGAYDI,TEN,NHANVIEN.MANV
from CHUYENBAY join LICHBAY on CHUYENBAY.MACB = LICHBAY.MACB
				join PHANCONG on LICHBAY.NGAYDI= PHANCONG.NGAYDI
				join NHANVIEN on PHANCONG.MANV = NHANVIEN.MANV
Where NHANVIEN.MANV='1001'
--4. Cho biết thông tin (mã chuyến bay, sân bay đi, giờ đi, giờ đến, ngày đi) của những
--chuyến bay hạ cánh xuống DEN. Các chuyến bay được liệt kê theo ngày đi giảm dần và
--sân bay xuất phát (SBDI) tăng dần.
select * from CHUYENBAY
select * from LICHBAY
select CHUYENBAY.MACB,GIODI,GIODEN,NGAYDI,SBDEN
from CHUYENBAY join LICHBAY on CHUYENBAY.MACB = LICHBAY.MACB
Where SBDEN = 'DEN' 
ORDER BY NGAYDI DESC , SBDI ASC
--5. Với mỗi phi công, cho biết hãng sản xuất và mã loại máy bay mà phi công này có khả
--năng bay được. Xuất ra tên phi công, hãng sản xuất và mã loại máy bay.
select * from LOAIMB
select * from MAYBAY
select * from NHANVIEN
select * from KHANANG
select TEN,HANGSX,LOAIMB.MALOAI
from LOAIMB join MAYBAY on LOAIMB.MALOAI = MAYBAY.MALOAI
			join KHANANG on LOAIMB.MALOAI=KHANANG.MALOAI
			join NHANVIEN on KHANANG.MANV= NHANVIEN.MANV
--6. Cho biết mã phi công, tên phi công đã lái máy bay trong chuyến bay mã số 100 vào ngày
--01/11/2000.
select * from LOAIMB
select * from MAYBAY
select * from NHANVIEN
select * from KHANANG
select * from LICHBAY
select nhanvien.MANV,TEN,maybay.MALOAI,LICHBAY.MACB,LICHBAY.NGAYDI
from LICHBAY join MAYBAY on LICHBAY.SOHIEU = MAYBAY.SOHIEU
			join LOAIMB on MAYBAY.MALOAI=LOAIMB.MALOAI
			join KHANANG on LOAIMB.MALOAI=KHANANG.MALOAI
			join NHANVIEN on KHANANG.MANV = NHANVIEN.MANV
WHERE LICHBAY.MACB = '100' And LICHBAY.NGAYDI='2000/11/01'
--7. Cho biết mã chuyến bay, ngày đi, mã số và tên của những phi công được phân công vào
--chuyến bay hạ cánh xuống sân bay ORD.
select CHUYENBAY.MACB,LICHBAY.NGAYDI,NHANVIEN.MANV,TEN,SBDEN
from CHUYENBAY join LICHBAY on CHUYENBAY.MACB = LICHBAY.MACB
				join PHANCONG on LICHBAY.NGAYDI = PHANCONG.NGAYDI
				join NHANVIEN on PHANCONG.MANV=NHANVIEN.MANV
Where SBDEN = 'ORD' 
--8. Cho biết mã chuyến bay, mã nhân viên, tên nhân viên được phân công vào chuyến bay
--xuất phát ngày 10/31/2000 tại sân bay MIA vào lúc 20:30
select * from CHUYENBAY
select * from PHANCONG
select * from NHANVIEN
select * from LICHBAY
select CHUYENBAY.MACB,LICHBAY.NGAYDI,NHANVIEN.MANV,TEN,SBDI,GIODI
from CHUYENBAY join LICHBAY on CHUYENBAY.MACB = LICHBAY.MACB
				join PHANCONG on LICHBAY.NGAYDI = PHANCONG.NGAYDI
				join NHANVIEN on PHANCONG.MANV=NHANVIEN.MANV
Where SBDI = 'MIA' AND LICHBAY.NGAYDI='2000/10/31' AND GIODI='20:30:00'
--9. Cho biết thông tin về chuyến bay (mã chuyến bay, số hiệu, mã loại, hãng sản xuất) mà
--phi công "Quang" đã lái.
select TEN,HANGSX,LOAIMB.MALOAI,CHUYENBAY.MACB,MAYBAY.SOHIEU
from CHUYENBAY join LICHBAY on CHUYENBAY.MACB = LICHBAY.MACB
				join MAYBAY on LICHBAY.MALOAI = MAYBAY.MALOAI
				JOIN LOAIMB on MAYBAY.MALOAI=LOAIMB.MALOAI
				join KHANANG on LOAIMB.MALOAI=KHANANG.MALOAI
				join NHANVIEN on KHANANG.MANV = NHANVIEN.MANV
WHERE TEN like N'Quang'
--10. Cho biết tên khách hàng đã đi chuyến bay trên máy bay của hãng "Boeing".
SELECT TEN,HANGSX
FROM KHACHHANG JOIN DATCHO ON KHACHHANG.MAKH=DATCHO.MAKH
				JOIN LICHBAY ON DATCHO.NGAYDI=LICHBAY.NGAYDI
				JOIN MAYBAY ON LICHBAY.SOHIEU=MAYBAY.SOHIEU
				JOIN LOAIMB ON MAYBAY.MALOAI=LOAIMB.MALOAI
WHERE HANGSX='Boeing'
