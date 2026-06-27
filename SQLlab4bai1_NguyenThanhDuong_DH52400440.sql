--1. Cho biết danh sách các nhân viên của công ty.
select *
from NHANVIEN
--2. Cho biết manv, họ tên, mức lương của các nhân viên. (Với thông tin cột họ tên được
--ghép từ 2 cột honv và tennv)
SELECT MANV,HONV+' '+TENNV,MUCLUONG
FROM NHANVIEN
--3. Cho biêt các mức lương hiện có của công ty. (Lưu ý loại bỏ các giá trị trùng nhau)
SELECT DISTINCT MUCLUONG
FROM NHANVIEN
--4. Cho biết danh sách các nhân viên có mức lương từ 5.000.000 đến 7.000.000. Sắp xếp
--giảm dần theo mức lương.
SELECT MUCLUONG
FROM NHANVIEN
WHERE MUCLUONG >= 5000000 AND MUCLUONG <= 7000000
ORDER BY mucluong DESC
--5. Cho biết danh sách các chi nhánh chưa có trưởng phòng, chi nhánh chưa có trưởng phòng
--có nghĩa là giá trị tại cột manvptr của bảng CHINHANH có giá trị = NULL.
SELECT *
FROM CHINHANH
WHERE manvptr IS NULL
--6. Cho biết danh sách các nhân viên có họ Lý và sinh năm 1988.
SELECT honv,tennv,ngaysinh
FROM NHANVIEN
WHERE honv like N'Lý%' and year(ngaysinh) = 1988
--7. Cho biết danh sách các công trình kết thúc vào năm 2010 của thành phố có mã 02.
select ngaykt,matp
from CONGTRINH
where year(ngaykt) = 2010 and matp = '02'
--8. Cho biết danh sách các nhân viên là phái nữ và làm việc trong chi nhánh có mãcn là C01
--hoặc C03.
select phai,macn,honv,tennv
from NHANVIEN
where phai = N'Nữ' and (macn = 'C01' or macn = 'C03') 
--9. Cho biết manv, họ tên và tuổi của 3 nhân viên làm trong chi nhánh có mã C03. Sắp xếp
--tăng dần theo tuổi.
select top 3 manv,honv,tennv,YEAR(getdate())-YEAR(ngaysinh) as tuoinv
from NHANVIEN
where macn ='C03'
order by tuoinv asc
--10. Cho biết danh sách các nhân viên có mức lương cao nhất trong công ty.
select top 1 with ties mucluong,honv,tennv
from NHANVIEN
order by mucluong Desc
--11. Cho biết danh sách mact, ngày bắt đầu, ngày kết thúc, số tháng thực hiện (= ngayktngaybd) có thời gian kết thúc - thời gian bắt đầu lớn hơn 12 tháng, sắp xếp giảm dần theo
--số tháng.
select mact,ngaybd,ngaykt,DATEDIFF(month,ngaybd,ngaykt) as SoThang
from CONGTRINH
where DATEDIFF(month,ngaybd,ngaykt) > 12
order by SoThang desc

--12. Cho biết danh sách tên những công trình, tên thành phố của các công trình do chi nhánh
--có mã ‘C03’ đã thực hiện.
select tenct,tentp,macn
from CONGTRINH join THANHPHO on CONGTRINH.matp = THANHPHO.matp
where macn='C03'
--13. Cho biết danh sách mã số, họ tên và ngày nhậm chức của người phụ trách của từng chi
--nhánh.
select tencn,manv,honv,tennv,ngaynhamchuc,manvptr
from NHANVIEN join CHINHANH on NHANVIEN.macn = CHINHANH.manvptr
--14. Cho biết danh sách nhân viên của các chi nhánh có mã cn là ‘C01’ hoặc ‘C02’ và có
--mức lương trên 4.500.000. Thông tin hiển thị bao gồm tên cn, tennv, manv, mức lương.
select ChiNhanh.macn,tencn,tennv,manv,mucluong
from NHANVIEN join CHINHANH on NHANVIEN.macn = CHINHANH.macn
where (CHINHANH.macn='C01' or CHINHANH.macn='C02') and mucluong > 4500000
--15. Cho biết danh sách mã số, họ tên nhân viên, mã công trình và tên công trình mà trong
--đó nhân viên tham gia công trình với thời gian làm việc hơn 25 giờ/tuần.
select* from NHANVIEN 
select* from CONGTRINH 
select NHANVIEN.manv,honv,tennv,CONGTRINH.mact,tenct,PHANCONG.sogiotuan
from nhanvien join CONGTRINH on NHANVIEN.macn=CONGTRINH.macn
			join PHANCONG on  NHANVIEN.manv=PHANCONG.manv
where PHANCONG.sogiotuan > 25 
--16. Cho biết danh sách các nhân viên được phân công làm việc tại các công trình ở các
--thành phố ‘Hà Nội’, ‘Đà Nẵng’ và ‘Tp.HCM’, thông tin hiển thị bao gồm: tên công trình,
--tên nhân viên, tên thành phố, ngày bd, ngày kt.
select tenct,tennv,tentp,ngaybd,ngaykt
from NHANVIEN join PHANCONG on NHANVIEN.manv=PHANCONG.manv
			join CONGTRINH on PHANCONG.mact=CONGTRINH.mact
			join THANHPHO on CONGTRINH.matp=THANHPHO.matp
where tentp in(N'Hà Nội',N'Đà Nẵng',N'Tp HCM')
--17. Cho biết danh sách tên công trình, tên chi nhánh quản lý công trình cùng với họ tên
--trưởng chi nhánh đối với những công trình đang được thực hiện ở thành phố có mã số là
--‘01’.
select * from CONGTRINH
select * from CHINHANH
select* from NHANVIEN 
select* from THANHPHO
select tenct,tencn,honv,tennv,manv,manvptr,thanhpho.matp
from CONGTRINH join CHINHANH on CONGTRINH.macn = CHINHANH.macn
			join NHANVIEN on CHINHANH.manvptr=NHANVIEN.manv
			join THANHPHO on CONGTRINH.matp=THANHPHO.matp
Where ThanhPho.matp= '01'
--18. Cho biết danh sách tên chi nhánh đang quản lý những công trình được thực hiện ở Hà
--Nội và bắt đầu sau năm 2007.
select * from CHINHANH
select* from THANHPHO
select * from CONGTRINH
select tencn, tenct,tentp,ngaybd
from CONGTRINH join THANHPHO on CONGTRINH.matp=THANHPHO.matp
			join CHINHANH on CONGTRINH.macn=CHINHANH.macn
Where YEAR(ngaybd)>2007 and tentp=N'Hà Nội'