--1. Cho biết danh sách các nhân viên gồm mã nhân viên, họ và tên nhân viên (được
--ghép từ 3 trường honv, tenlot, tennv) và tên phòng ban mà các nhân viên đó làm
--việc.
select TENPHG,HONV+ TENLOT+ TENNV as HOVATEN
from NHANVIEN join PHONGBAN on NHANVIEN.PHONG= PHONGBAN.MAPHG
--2. Cho biết tên các đề án mà nhân viên Đinh Bá Tiến tham gia.
select TENDA,HONV+TENLOT+TENNV as HOVATEN
from NHANVIEN join PHANCONG on NHANVIEN.MANV= PHANCONG.MA_NVIEN
			join CONGVIEC on PHANCONG.STT = CONGVIEC.STT and PHANCONG.MADA=CONGVIEC.SODA
			join DEAN on CONGVIEC.SODA=DEAN.MADA
WHERE HONV=N'Đinh' and TENLOT=N'Bá' and TENNV=N'Tiến'
--3. Tìm tên những nhân viên, tên người thân, ngày sinh và tuổi của thân nhân với
--điều kiện tuổi của thân nhân <=15. Săp xếp giảm dần theo tuổi.
select HONV+TENLOT+TENNV as HOVATEN,TENTN,NGAYSINH, DATEDIFF(YEAR,NGAYSINH,GETDATE()) as TUOITN
from NHANVIEN Join THANNHAN on NHANVIEN.MANV = THANNHAN.MA_NVIEN
WHERE DATEDIFF(YEAR,NGAYSINH,GETDATE()) <= 15
order by TUOITN DESC 
--4. Với mỗi đề án ở Hà Nội, cho biết tên đề án, tên phòng ban, họ tên và ngày nhận
--chức của trưởng phòng của phòng ban chủ trì đề án đó.
select * from PHONGBAN
select * from DEAN
select DDIEM_DA,TENDA,TENPHG,NG_NHANCHUC,HONV+TENLOT+TENNV as HOVATEN, TRUONGPHG
from PHONGBAN join DEAN on PHONGBAN.MAPHG=DEAN.PHONG
			join NHANVIEN on PHONGBAN.MAPHG= NHANVIEN.PHONG
where DDIEM_DA = N'Hà Nội'
--5. Cho biết mã đề án, tên đề án, tên công viêc, tên nhân viên được phân công cho
--các đề án do phòng 'Nghiên cứu' phụ trách. Sắp xếp tăng dần theo mã đề án, tên
--công việc.
select * from PHONGBAN
select * from DEAN
select * from CONGVIEC
select * from PHANCONG
select * from NHANVIEN
select DEAN.MADA,TENDA,TEN_CONG_VIEC,HONV+TENLOT+TENNV as HOVATEN
from PHONGBAN join DEAN on PHONGBAN.MAPHG=DEAN.PHONG
			join CONGVIEC on DEAN.MADA=CONGVIEC.SODA
			join PHANCONG on PHANCONG.STT = CONGVIEC.STT and PHANCONG.MADA=CONGVIEC.SODA
			join NHANVIEN on PHANCONG.MA_NVIEN=NHANVIEN.MANV
where TENPHG =N'Nghiên Cứu'
order by DEAN.MADA ASC, TEN_CONG_VIEC ASC 
--6. Cho biết danh sách các nhân viên chưa có thông tin thân nhân. (HD: dùng phép
--kết left join hoặc right join)
select HONV+TENLOT+TENNV as HOVATEN, MA_NVIEN
from NHANVIEN left join THANNHAN on NHANVIEN.MANV = THANNHAN.MA_NVIEN
where MA_NVIEN is NULL
--7. Cho biết danh sách các nhân viên chưa được phân công đề án làm việc
Select HONV+TENLOT+TENNV as HOVATEN,CONGVIEC.SODA 
from NHANVIEN join PHANCONG on NHANVIEN.MANV=PHANCONG.MA_NVIEN
			left join CONGVIEC on  PHANCONG.STT = CONGVIEC.STT and PHANCONG.MADA=CONGVIEC.SODA
where CONGVIEC.SODA Is NULL
--8. Cho biết danh sách các đề án có địa điểm đề án trùng với địa điểm của phòng
--ban phụ trách đề án đó. Thông tin hiển thị gồm: tên đề án, địa điểm đề án, tên
--phòng phụ trách đề án, địa điểm phòng, họ tên trưởng phòng.
--9. Cho biết danh sách các đề án ở cùng một địa điểm và do cùng một phòng ban
--chủ trì (Lưu ý: Nếu thông tin hiển thị bị trùng lắp thì sv tìm cách xử lý để bỏ bớt
--các dòng dữ liệu trùng lắp với nhau)
select D1.DDIEM_DA, D1.MADA,D1.TENDA
from DEAN as D1, DEAN as D2
where D1.DDIEM_DA=D2.DDIEM_DA And D1.MADA<>D2.MADA

--10. Cho biết danh sách các nhân viên thuộc cùng 1 phòng ban được phân công
--vào cùng 1 đề án và làm cùng 1 công việc. Thông tin hiển thị gồm: Manv, họ tên
--NV, tên phòng ban, mã đề án, tên công việc.
select * from NHANVIEN
select * from PHANCONG
select * from CONGVIEC
select * from DEAN
select * from PHONGBAN
select MA_NVIEN, HONV+TENLOT+TENNV as HOVATENNV, TEN_CONG_VIEC,TENPHG,DEAN.MADA
from NHANVIEN join PHANCONG on NHANVIEN.MANV = PHANCONG.MA_NVIEN
			join CONGVIEC on PHANCONG.MADA = CONGVIEC.SODA
			join DEAN on CONGVIEC.SODA = DEAN.MADA
			join PHONGBAN on DEAN.PHONG=PHONGBAN.MAPHG
--11. Với mỗi nhân viên, cho biết họ tên nhân viên và họ tên người quản lý trực tiếp
--của nhân viên đó.
select * from NHANVIEN
select  NV1.MANV, NV1.HONV+NV1.TENLOT+NV1.TENNV as HOVATEN, NV2.MA_NQL,NV2.HONV+NV2.TENLOT+NV2.TENNV as HOVATEN
from NHANVIEN as NV1 , NHANVIEN as NV2
where NV1.MANV=NV2.MA_NQL
--12. Tên những nhân viên phòng số 5 có tham gia vào đề án "Sản phẩm X" và nhân
--viên này do "Nguyễn Thanh Tùng" quản lý trực tiếp.
SELECT NV1.HONV+ NV1.TENLOT+NV1.TENNV as HOTENNV, NV2.HONV+ NV2.TENLOT+NV2.TENNV as HOTENQL
FROM NHANVIEN as NV1 join NHANVIEN as NV2 on NV1.MA_NQL=NV2.MANV
					join PHANCONG on NV1.MA_NQL=PHANCONG.MA_NVIEN
					join CONGVIEC on PHANCONG.STT=CONGVIEC.STT and PHANCONG.MADA = CONGVIEC.SODA
					join DEAN on DEAN.MADA=CONGVIEC.SODA
--13. Với mỗi nhân viên, cho biết họ tên của nhân viên đó, họ tên người trưởng
--phòng và họ tên người quản lý trực tiếp của nhân viên đó.
SELECT NV.HONV+ NV.TENLOT+NV.TENNV as HOTENNV, NQL.HONV+ NQL.TENLOT+NQL.TENNV as HOTENNQL ,TP.HONV + TP.TENLOT+ TP.TENNV as HOTENTP
FROM NHANVIEN as NV join PHONGBAN on PHONG=MAPHG
					join NHANVIEN as NQL on NV.MA_NQL=NQL.MANV
					join NHANVIEN as TP ON TP.MANV=PHONGBAN.TRUONGPHG
