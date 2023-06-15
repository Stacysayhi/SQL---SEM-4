--cau a
---Ngày hiện hành dùng hàm getdate hoặc sysdatetime
select sysdatetime() "current date"

select GETDATE() "current date"

--cau b:Hiển thị mã số nhân viên, tên, tiền lương và cột tiền lương đã được tăng 15% không có số lẽ, nhãn cột là New Salary. Ghi câu lệnh SQL thành tập tin lab3_2.sql.
--dbo : Lược đồ mặc nhiên
USE HR
select EMPLOYEE_ID , FIRST_NAME,SALARY,round(SALARY*0,15,0) as "new salary"
from dbo.EMPLOYEES

--cau c Chạy lại vấn tin trong lab3_2.sql, thay đổi vấn tin trong lab3_2.sql, thêm cột mới lương tăng thêm (lương mới – lương củ), đặt tiêu đề là Increase. Ghi câu lệnh SQL thành tập tin lab3_4.sql. Chạy lại vấn tin.
select EMPLOYEE_ID , FIRST_NAME,SALARY,round(SALARY*0,15,0) as "new salary", (SALARY -  round(SALARY*0,15,0) ) as "increase"
from dbo.EMPLOYEES

--cau d: Viết vấn tin hiển thị tên các nhân viên có ký tự đầu là chữ hoa và các ký tự
--khác là chữ thường, chiều dài tên nhân viên cho các nhân viên có tên bắt
--đầu với J, A hay M. Đặt mỗi cột một nhãn thích hợp. Sắp xếp kết quả theo
---tên nhân viên.
---SAU % LÀ KÍ TỰ ĐẠI DIỆN, KÍ TỰ NÀO CŨNG ĐC
select UPPER(LEFT(LAST_NAME,1)) + LOWER(RIGHT(LAST_NAME,LEN(LAST_NAME)-1))
from DBO.EMPLOYEES
WHERE UPPER(LEFT(LAST_NAME,1)) IN ('J','A','M')


select UPPER(LEFT(LAST_NAME,1)) + LOWER(RIGHT(LAST_NAME,LEN(LAST_NAME)-1))
from DBO.EMPLOYEES
WHERE LAST_NAME LIKE 'J%' OR LAST_NAME LIKE 'A%' OR LAST_NAME LIKE 'M%'  

----CAU E Hiển thị tên nhân viên và tính số tháng làm việc của nhân viên, đặt tên
--cột là MONTHS_WORKED.Sắp xếp kết quả theo số tháng làm việc. Làm
--tròn số tháng làm việc.
SELECT LAST_NAME, DATEDIFF(MONTH,HIRE_DATE,GETDATE()) AS MONTH_WORKED
FROM DBO.EMPLOYEES
ORDER BY 2 

--CAU F:Viết vấn tin tạo nội dung sau cho mỗi nhân viên : <employee last name>
--earns <salary> monthly but wants <3 times salary>. Đặt tên cột là Dream
--Salaries.
--NVARCHAR: KÍ TỰ CÓ ĐỘ THAY ĐỔI 
SELECT LAST_NAME + ' EARNS ' + RTRIM(CONVERT(CHAR(10),CONVERT(INT,SALARY))) + ' USD MONTHYLY BUT WANTS '+ RTRIM(CONVERT(CHAR(10),CONVERT(INT,3*SALARY))) DREAM_SALARIES
FROM DBO.EMPLOYEES

---CAU G:Tạo vấn tin hiển thị tên nhân viên và tiền lương của các nhân viên, Định
--dạng tiền lương dài 15 ký tự, lắp đầy bên trái bằng dấu $. Đặt tên nhãn là
--Salary.
SELECT LAST_NAME, REPLICATE('$',15-LEN(CONVERT(CHAR,CONVERT(INT,SALARY))))
+CONVERT(CHAR,CONVERT(INT,SALARY))
FROM EMPLOYEES

--CAU H: Hiển thị tên nhân viên, ngày vào làm, ngày nâng lương (ngày thứ hai đầu tiên
--sau 6 tháng làm việc. Đặt tên cột REVIEW và định dạng cột ngày theo mẫu
---“Monday, the Thirty-First of July, 2000.”
--- THÊM 6 THÁNG SAU NGÀY ĐI LÀM ĐẦU TIÊN
SELECT LAST_NAME, HIRE_DATE, DATEADD(MONTH,6,HIRE_DATE) DAY_AFTER_6_MONTHS,
     DATEPART(dw,DATEADD(MONTH,6,HIRE_DATE)) thu_tu_ngay_trong_tuan,
	 CASE DATEPART(dw,DATEADD(MONTH,6,HIRE_DATE)) --THỨ TỰ NGÀY TRONG TUẦN SAU NGÀY SAU 6 THÁNG LÀM VIỆC
		WHEN 1 THEN DATEADD(DAY,1,DATEADD(MONTH,6,HIRE_DATE))
		WHEN 2 THEN DATEADD(MONTH,6,HIRE_DATE)
		ELSE DATEADD(DAY, 9-DATEPART(dw,DATEADD(MONTH,6,HIRE_DATE)),DATEADD(MONTH,6,HIRE_DATE))
	END REVIEW
FROM EMPLOYEES

SELECT FORMAT(GETDATE(),'dddd, MMMM ,yyyy') AS DATE

---cau i: Hiển thị tên nhân viên, ngày vào làm và ngày trong tuần của ngày vào làm.
--Đặt tên cột là DAY. Sắp xếp kết quả theo ngày trong tuần, bắt đầu bằng
--Monday.
USE HR
SELECT LAST_NAME,HIRE_DATE, FORMAT(HIRE_DATE,'dddd, MMMM ,yyyy') AS DATE 
FROM DBO.EMPLOYEES
order by DATEPART(DW,DATEDIFF(DW,HIRE_DATE,-2)) DESC

	


---CAU J: Tạo vấn tin hiển thị tên nhân viên, tổng số hoa hồng. Nếu nhân viên không
--có thu nhập hoa hồng thì hiển thị nội dung là “No Comission”, đặt tên nhãn là
--COMM.
---chuỗi kí tự để trong ''
--phải đồng nhất kí tự hoặc số 
SELECT LAST_NAME, ISNULL(CONVERT(CHAR,COMMISSION_PCT), 'NO COMISSION') AS COMM
FROM EMPLOYEES

---cau k:Tạo vấn tin hiển thị tên nhân viên và biểu thị tổng số tiền lương hàng năm
--bằng dấu *. Mỗi dấu * đại diện 1000 dolar. Sắp xếp dữ liệu theo thứ tự
--giảm dần của tiền lương. Đặt tên nhãn là
--EMPLOYEES_AND_THEIR_SALARIES.

SELECT LAST_NAME, SUM(SALARY) 
FROM EMPLOYEES


	
		