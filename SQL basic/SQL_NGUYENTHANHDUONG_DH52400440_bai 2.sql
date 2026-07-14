--1. Danh sách mã số, họ tên sinh viên và tên những môn học mà những sinh viên
--có đăng ký học và có kết quả thi.
select *from sinhvien
select *from dangky
select *from monhoc
select *from ketqua
select sinhvien.masv, hosv + tensv as HOVATENSV, dangky.masv,tenmh,diem
from sinhvien join dangky on sinhvien.masv= dangky.masv
			join monhoc on dangky.mamh=monhoc.mamh
			join ketqua on monhoc.mamh=ketqua.mamh 

--2. Danh sách tên của tất cả các môn học và tên giảng viên phụ trách lý thuyết
--tương ứng, nếu có.
select * from monhoc
select * from giangday
select * from giangvien
select tenmh,hoten as HOTENGV ,phutrach
from monhoc join giangday on monhoc.mamh =giangday.mamh
			join giangvien on giangday.magv=giangvien.magv
where phutrach = N'LT'
--3. Cho biết mã số và họ tên giảng viên không có thân nhân nào.
select * from giangvien
select * from thannhan
select giangvien.magv , hoten,moiquanhe
from giangvien left join thannhan on giangvien.magv = thannhan.magv
where moiquanhe is NULL
--4. Danh sách những sinh viên và tên những môn học đã đăng ký học nhưng không
--có kết quả thi của môn học.
select *from sinhvien
select *from dangky
select *from monhoc
select *from ketqua
select sinhvien.masv, hosv + tensv as HOVATENSV, dangky.masv,tenmh,diem
from sinhvien join dangky on sinhvien.masv= dangky.masv
			join monhoc on dangky.mamh=monhoc.mamh
			left join ketqua on monhoc.mamh=ketqua.mamh 
where ketqua.diem is NULL
--5. Danh sách tên của những môn học đã được phân công giảng dạy trong học kỳ
--1 năm ‘2014-2015’ nhưng không có sinh viên đăng ký.
select * from giangday
select *from monhoc
select *from dangky
select *from sinhvien
select tenmh,dangky.hocky
from giangday join monhoc on giangday.mamh = monhoc.mamh
			join dangky on monhoc.mamh=dangky.mamh
			left join sinhvien on dangky.masv=sinhvien.masv
where dangky.namhoc = '2014-2015' and dangky.mamh is NULL

--6. Tạo danh sách có mã số và họ tên giảng viên dạy lý thuyết môn học tên là ‘Cơ
--sở dữ liệu’ trong học kỳ 2, 2014-2015.
select * from monhoc
select * from giangday
select * from giangvien
select giangvien.magv,hoten as HOTENGV ,phutrach,tenmh,hocky,namhoc
from monhoc join giangday on monhoc.mamh =giangday.mamh
			join giangvien on giangday.magv=giangvien.magv
where phutrach = N'LT' and tenmh = N'Cơ sở dữ liệu' and hocky = '2'and namhoc='2014-2015'

--7. Tạo danh sách có mã số, họ tên các giảng viên và mã môn học mà giảng viên
--được hoặc không được phân công giảng dạy lý thuyết trong năm 2014-2015.
select * from monhoc
select * from giangday
select * from giangvien
select giangvien.magv,hoten as HOTENGV ,phutrach,giangday.mamh,tenmh,hocky,namhoc
from monhoc join giangday on monhoc.mamh =giangday.mamh
			join giangvien on giangday.magv=giangvien.magv
where  (phutrach =N'LT' or phutrach is NULL) and  namhoc='2014-2015'
