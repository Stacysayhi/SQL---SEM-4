---	THUC HANH CAU LENH JOIN
--CAU A: Viết vấn tin hiển thị tên nhân viên, mã số phòng ban và tên phòng ban cho tất cả các nhân viên.
---- nếu k chỉ ra thì mặc nhiên là inner join ( lấy bằng 2 bên )
SELECT e.LAST_NAME , e.DEPARTMENT_ID, d.DEPARTMENT_NAME
FROM EMPLOYEES e
JOIN DEPARTMENTS d
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID --- ĐẶT TÊN BẢNG EMPLOYEES LÀ e , BẢNG DEPARTMENTS LÀ d, câu on nhằm mục đích nối department id từ bảng d sang bảng e
----- e. là thể hiện viết tắt của bảng employees
ORDER BY DEPARTMENT_NAME

--CAU B:Tạo danh sách các công việc duy nhất trong phòng ban có mã số 30, bao gồm cột mã số vị trí của phòng ban trong kết quả.
---distinct để lấy dòng duy nhất, k trùng job_id
SELECT distinct e.JOB_ID,e.DEPARTMENT_ID,d.LOCATION_ID
FROM EMPLOYEES e
JOIN DEPARTMENTS d
-- CÁC LK BẰNG NHAU LÀ LIÊN KẾT GIỮA KHÓA NGOÀI VÀ KHÓA CHÍNH
ON e.DEPARTMENT_ID= d.DEPARTMENT_ID
ORDER BY e.DEPARTMENT_ID

---cau c:Viết vấn tin hiển thị tên nhân viên, mã số phòng ban, mã số vị trí phòng
---ban và tên thành phố của tất cả các nhân viên có thu nhập từ hoa hồng.
select e.LAST_NAME, e.FIRST_NAME,e.COMMISSION_PCT , f.LOCATION_ID , d.DEPARTMENT_ID, f.CITY
from EMPLOYEES e
join DEPARTMENTS d
ON e.DEPARTMENT_ID= d.DEPARTMENT_ID
JOIN LOCATIONS f
ON d.LOCATION_ID=f.LOCATION_ID
WHERE COMMISSION_PCT IS NOT NULL

--- CAU D: Hiển thị tên nhân viên và tên phòng ban cho tất cả các nhân viên có chữ a
---trong tên. Ghi câu lệnh thành tập tin lab4_4.sql.
SELECT e.LAST_NAME,e.FIRST_NAME,d.DEPARTMENT_ID
FROM EMPLOYEES e
JOIN DEPARTMENTS d
ON e.DEPARTMENT_ID=d.DEPARTMENT_ID
WHERE LAST_NAME like '%a%'

--cau e : Viết vấn tin hiển thị tên nhân viên, mã số công việc, mã số phòng ban
--và tên phòng ban cho tất cả các nhân viên làm việc ở Toronto.
select e.LAST_NAME, e.FIRST_NAME,e.COMMISSION_PCT , f.LOCATION_ID , d.DEPARTMENT_ID, f.CITY
from EMPLOYEES e
join DEPARTMENTS d
ON e.DEPARTMENT_ID= d.DEPARTMENT_ID
JOIN LOCATIONS f
ON d.LOCATION_ID=f.LOCATION_ID
WHERE f.CITY= 'TORONTO' 

--CAU G:Hiển thị tên nhân viên và mã số nhân viên, cùng với tên người quản lý và
--mã số người quản lý. Nhãn của các cột là Employee, Emp#, Manager,
--Mgr#. Ghi câu lệnh lại thành lab4_6.sql.
SELECT e.LAST_NAME,e.FIRST_NAME AS EMPL#,e.MANAGER_ID AS MGR#, e.DEPARTMENT_ID
FROM EMPLOYEES e
JOIN EMPLOYEES f
-- CÁC LK BẰNG NHAU LÀ LIÊN KẾT GIỮA KHÓA NGOÀI VÀ KHÓA CHÍNH
ON e.EMPLOYEE_ID= f.MANAGER_ID
WHERE e.MANAGER_ID IS NOT NULL

--CAU I:Tạo vấn tin hiển thị tên nhân viên, mã số phòng ban và tất cả các nhân viên
---làm chung phòng ban với nhân viên đó. Đặt tên nhãn cho các cột (COI LAI CAU NAY)
SELECT e.EMPLOYEE_ID,e.LAST_NAME,m.DEPARTMENT_ID,m.EMPLOYEE_ID,m.LAST_NAME
FROM EMPLOYEES e
JOIN EMPLOYEES m
ON e.DEPARTMENT_ID=m.EMPLOYEE_ID

---CAU J:Tạo vấn tin hiển thị tên nhân viên, ngày vào làm của những nhân viên được
---nhận vào làm sau ngày vào làm của Davies.
SELECT d.LAST_NAME, e.HIRE_DATE AS DAVIES, d.HIRE_DATE
FROM EMPLOYEES e
JOIN EMPLOYEES d
ON e.HIRE_DATE < d.HIRE_DATE
WHERE e.LAST_NAME LIKE 'DAVIES'

--CAU K: Hiển thị tên và ngày vào làm của những nhân viên được nhận vào làm trước
---quản lý của họ, cùng với tên của người quản lý và ngày vào làm. Nhãn của
--các cột là Employee, Emp Hired, Manager, Mgr Hired.

SELECT e.LAST_NAME AS EMPLOYEE, e.HIRE_DATE AS [EMP HIRED], d.MANAGER_ID AS MANAGER , d.HIRE_DATE [ MRG HIRED]
FROM EMPLOYEES e
JOIN EMPLOYEES d
ON e.EMPLOYEE_ID = d.MANAGER_ID
WHERE e.HIRE_DATE < d.HIRE_DATE
AND e.MANAGER_ID IS NOT NULL

--THUC HANH CAU LENH GROUP BY
--NHOM CAC SO LIEU VOI NHAU 
--cac ham thong ke: min,max,sum,avg
--cau a: Hiển thị tiền lương cao nhất, thấp nhất, tổng lương và lương trung bình
----của các nhân viên. Đặt tên cột lần lượt là Maximum, Minimum, Sum và
---Average. Làm tròn kết quả không có số lẽ. Ghi câu lệnh lại thành tập tin
--lab5_6.sql

SELECT MAX(SALARY) [MAX SL] ,MIN(SALARY) [MIN SL], sum(SALARY)[SUM LA], AVG(SALARY) [ AVG SL]
FROM EMPLOYEES


--CAU B 
--những tên cột nào có trong hàm group by mới đc để trong hàm select
---k có mặt trong group by thì phải nằm trong nhóm các nhóm khác
SELECT JOB_ID, MAX(SALARY) [MAX SL ] ,MIN(SALARY) [MIN SL], sum(SALARY)[SUM LA], AVG(SALARY) [ AVG SL]
FROM EMPLOYEES
GROUP BY JOB_ID

---CAU C Viết vấn tin để hiển thị tổng số nhân viên của mỗi nhóm công việc.
SELECT JOB_ID, COUNT(*) [TOTAL EMP]
FROM EMPLOYEES
GROUP BY JOB_ID

--CAU D Hiển thị tổng số nhân viên quản lý.
SELECT MANAGER_ID, COUNT(*) [TOTAL MAG]
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL
GROUP BY MANAGER_ID

---CAU E: Viết vấn tin hiển thị chênh lệch giữa lương cao nhất và thấp nhất. Đặt tên cột
--là DIFFERENCE. SELECT max(salary)-min(salary) as Differece FROM
--employees
SELECT max(salary)-min(salary) as Differece FROM EMPLOYEES
FROM EMPLOYEES

---CAU F:Hiển thị mã số nhà quản lý và tiền lương thấp nhất của nhân viên trong nhóm
--nhà quản lý đó. Chỉ hiển thị tiền lương thấp nhất trên 6000 dolar, sắp xếp thứ
--tự giảm dần theo tiền lương thấp nhất.
SELECT MANAGER_ID, MIN(SALARY)
FROM EMPLOYEES
GROUP BY MANAGER_ID
HAVING MIN(SALARY) >=6000
ORDER BY MIN(SALARY) DESC 














