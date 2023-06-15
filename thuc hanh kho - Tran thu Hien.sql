ALTER VIEW PHIEUNHAP
AS
SELECT A.TGXL,A.SP,A.NGAY,A.MKN,A.MDV ,A.SQ,A.SHD,A.NGAYHD,B.STT,B.ML AS MSTHUOC ,B.DG,B.TT,B.SL
FROM NHAP1 A
JOIN NHAP2 B
ON A.TGXL= B.TGXL AND A.SP = B.SP


CREATE VIEW NHAPTRA
AS
SELECT A.TGXL,A.SP,A.NGAY,A.MKN,A.MKX,B.STT,B.ML,B.DG,B.TT
FROM NHAPTRA1 A
JOIN NHAPTRA2 B
ON A.TGXL= B.TGXL AND A.SP = B.SP


ALTER VIEW THONGKEXUAT
AS
SELECT A.TGXL,A.SP,A.NGAY,A.MKN,A.MKX,A.LYDO,B.STT,B.ML,B.DG,B.TT,B.SL
FROM THONGKEXUAT1 A
JOIN THONGKEXUAT2 B
ON A.TGXL= B.TGXL AND A.SP = B.SP


CREATE VIEW XUATCHUYEN
AS
SELECT A.TGXL,A.SP,A.NGAY,A.MKN,A.MKX,B.STT,B.ML,B.DG,B.TT
FROM XUATCHUYEN1 A
JOIN XUATCHUYEN2 B
ON A.TGXL= B.TGXL AND A.SP = B.SP

CREATE VIEW XUATHU
AS
SELECT A.TGXL,A.SP,A.NGAY,A.MKX,A.LYDO,B.STT,B.ML,B.DG,B.TT
FROM XUATHU1 A
JOIN XUATHU2 B
ON A.TGXL= B.TGXL AND A.SP = B.SP


ALTER VIEW XUATKHOA
AS
SELECT A.TGXL,A.SP,A.NGAY,A.MKX,A.MKN,A.LYDO,B.STT,B.ML,B.DG,B.TT,B.SL
FROM XUATKHOA1 A
JOIN XUATKHOA2 B
ON A.TGXL= B.TGXL AND A.SP = B.SP


---3.6: Hiển thị thuốc trong danh mục mà trong tên thuốc có chữ “RON”
SELECT *
FROM DMTHUOC
WHERE TL LIKE '%RON%'


--3.7: Hiển thị tổng số thuốc đã được xuất trong tháng 01 năm 2016.
SELECT SUM(A.SL) AS TONGSOTHUOC ,A.TGXL,B.MCL,B.TL
FROM THONGKEXUAT A
JOIN DMTHUOC B
ON A.ML = B.ML
WHERE A.TGXL = '012016'
GROUP BY A.TGXL,B.MCL,B.TL

--3.8: Đếm số lượng các phiếu xuất thống kê khoa trong từng tháng của năm 2017.
SELECT COUNT(*) AS SOLUONGPHIEUXUATKHOA, LEFT(TGXL,2) AS THANG 
FROM XUATKHOA
WHERE RIGHT(TGXL,4) = '2017'
GROUP BY LEFT(TGXL,2) 

--3.9: Xem phiếu nhập số “KC100/1” tháng 01 năm 2016, bao gồm các nội dung
--sau: Số phiếu, Ngày nhập, Tên kho nhập, Mã số thuốc, Tên thuốc, Số lượng, Đơn giá,
--Thành tiền
SELECT A.SP,A.NGAY,A.MKN,B.MCL,A.SL,A.DG,A.TT
FROM PHIEUNHAP A
JOIN DMTHUOC B
ON A.MSTHUOC = B.ML
WHERE A.SP= 'KC100/1'

--10: Xem phiếu xuất thống kê khoa số “01HNT” tháng 03 năm 2016, bao gồm
--các nội dung sau: Số phiếu, Ngày xuất, Tên kho xuất, Khoa phòng nhận, Mã số thuốc, Tên
--thuốc, Số lượng xuất.
SELECT A.SP,A.NGAY,A.MKX,A.MKN,B.MCL,B.TL,A.SL
FROM THONGKEXUAT  A
JOIN DMTHUOC B
ON A.ML = B.ML
WHERE A.SP = '01HNT' AND A.TGXL = '032016'
GROUP BY A.SP,A.NGAY,A.MKX,A.MKN,B.MCL,B.TL,A.SL

--.11: Hiển thị các phiếu nhập trả từ ngày 03/2016 đến 04/2017. Sắp xếp kết quả
--theo ngày nhập trả
SELECT *
FROM NHAPTRA
WHERE RIGHT(TGXL,4) + LEFT(TGXL,2) BETWEEN '201603' AND '201704'
ORDER BY NGAY


--.12: Hiển thị đơn giá cao nhất, đơn giá trung bình của từng mặt hàng thuốc đã
--nhập trong năm 2016. Kết quả được làm tròn
SELECT MAX(A.DG) AS DONGIACAONHAT, ROUND(AVG(A.DG),0) AS DONGIATB, B.ML
FROM PHIEUNHAP A
JOIN DMTHUOC B
ON A.MSTHUOC=B.ML
WHERE RIGHT(A.TGXL,4)='2016'
GROUP BY B.ML

--13: Tổng hợp số tiền thuốc đã nhập trong tháng 05 năm 2016 theo từng kho
--thuốc, sắp xếp kết quả theo thứ tự giảm dần của tổng số tiền thuốc.Kết quả bao gồm các cột sau:
--Mã kho, Tên kho thuốc, Tổng số tiền thuốc.
SELECT A.MKN, B.MK,SUM(A.TT) AS TONGSOTIENTHUOC,B.TK
FROM PHIEUNHAP A
JOIN DMK B
ON A.MKN = B.MK
WHERE LEFT(A.TGXL,2) = '05' AND RIGHT(A.TGXL,4)='2016'
GROUP BY A.MKN, B.MK,B.TK
ORDER BY 3 DESC


---cau 14:Tổng hợp số lượng xuất khoa các mặt hàng thuốc có chữ “RON” trong tên
--thuốc theo từng tháng trong năm 2016. Các cột hiển thị bao gồm:
--Tháng, Mã số thuốc, Tên thuốc, Số lượng xuất.
--Hiển thị kết quả theo thứ tự giảm dần
SELECT A.ML,B.TL, SUM(A.SL) AS TONGSOLUONGXUAT
FROM XUATKHOA A
JOIN DMTHUOC B
ON A.ML = B.ML
WHERE B.TL LIKE '%RON%' AND RIGHT(A.TGXL,4) = '2016'
GROUP BY  A.ML,B.TL
ORDER BY 1,3 DESC


--3.15: Tổng hợp số lượng xuất mặt hàng thuốc tên Nước cất pha tiêm 5ml (mã số
--07NC0016) cho từng khoa điều trị trong quý 2 năm 2016. Các cột hiển thị bao gồm:
--Mã khoa phòng, Tên khoa phòng, Số lượng xuất.
SELECT A.MKN,B.TK,A.SL,A.ML,C.TL,SUM(A.SL) AS TONGSO
FROM THONGKEXUAT A
JOIN DMK B
ON A.MKX = B.MK
JOIN DMTHUOC C
ON A.ML=C.ML
WHERE A.ML = '07NC0016' AND RIGHT(A.TGXL,4) ='2016' AND LEFT(A.TGXL,2) BETWEEN '042016' AND '062016'
GROUP BY A.MKN, B.TK,A.NGAY,A.ML,C.TL,A.SL

--16: Hiển thị các mặt hàng thuốc có tổng thành tiền nhập trong năm 2016 nhỏ hơn
--tổng thành tiền nhập của mặt hàng thuốc có mã số “03ME0007”.
SELECT SUM(A.TT) AS TONGSO , B.MCL,B.ML,B.TL
FROM PHIEUNHAP A
JOIN DMTHUOC B
ON A.MSTHUOC = B.ML
WHERE RIGHT(A.TGXL,4) = '2016' 
GROUP BY B.MCL,B.ML,B.TL
HAVING SUM(A.TT) < ( SELECT SUM(TT)
				FROM PHIEUNHAP
				WHERE MSTHUOC = '03ME0007' )



--.17: Lập danh sách các mặt hàng thuốc được mua trong 3 hoặc 5 hoá đơn khác
--nhau, trong tháng 2 năm 2016
SELECT COUNT(SP) AS TONGSOPHIEU, ML
FROM THONGKEXUAT
WHERE RIGHT(TGXL,4)='2016' AND LEFT(TGXL,2)='02'
GROUP BY ML
HAVING COUNT(SP) = 3 OR COUNT(SP)= 5

SELECT COUNT(SHD) AS TONGSOHOADON, MSTHUOC
FROM PHIEUNHAP
WHERE RIGHT(TGXL,4)='2016' AND LEFT(TGXL,2)='02'
GROUP BY MSTHUOC
HAVING COUNT(SHD) = 3 OR COUNT(SHD)= 5

--18: Tìm các phiếu nhập có ngày nhập hàng cùng ngày với phiếu nhập số
--“KC110/06” trong tháng 06 năm 2016
SELECT MSTHUOC,SP,NGAY
FROM PHIEUNHAP
WHERE NGAY = (SELECT DISTINCT NGAY
				FROM PHIEUNHAP
				WHERE RIGHT(TGXL,4)='2016' AND LEFT(TGXL,2)='06'
				GROUP BY NGAY,SP,MSTHUOC
				HAVING SP = 'KC110/06')

--.19: Hiển thị mã số và tên các mặt hàng thuốc có đơn giá trên 8000 đồng đã nhập
--trong tháng 06 năm 2016 và được nhập lại trong tháng 07 năm 2016
SELECT  DISTINCT MSTHUOC
FROM PHIEUNHAP
WHERE RIGHT(TGXL,4)='2016' AND LEFT(TGXL,2)='07' AND MSTHUOC IN
(SELECT MSTHUOC
FROM PHIEUNHAP
WHERE RIGHT(TGXL,4)='2016' AND LEFT(TGXL,2)='06')
AND DG > 8000

SELECT DISTINCT MSTHUOC
FROM PHIEUNHAP
WHERE RIGHT(TGXL,4)='2016' AND LEFT(TGXL,2)='07' 
AND DG > 8000
INTERSECT 
SELECT MSTHUOC
FROM PHIEUNHAP
WHERE RIGHT(TGXL,4)='2016' AND LEFT(TGXL,2)='06'
AND DG > 8000

---3.20: Hiển thị mã số và tên các mặt hàng thuốc có số lượng xuất trên 100 đã được
--xuất trong tháng 06 năm 2016 nhưng không được xuất trong tháng 07 năm 2017.
SELECT ML
FROM THONGKEXUAT
WHERE TGXL='062016' 
AND SL > 100
EXCEPT
SELECT ML
FROM THONGKEXUAT
WHERE TGXL='072017'
AND SL >100

SELECT *
FROM THONGKEXUAT

