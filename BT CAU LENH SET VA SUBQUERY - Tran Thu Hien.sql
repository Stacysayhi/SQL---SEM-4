-----thực hành SUBQUERY
--CAU A: Viết vấn tin hiển thị tên và ngày vào làm của các nhân viên trong phòng ban
--của nhân viên tên Zlotkey, không bao gồm Zlotkey
SELECT LAST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
						FROM EMPLOYEES
						WHERE LAST_NAME = 'Zlotkey')
		AND LAST_NAME <> 'Zlotkey' ---<> NGHĨA LÀ KHÁC 
--CAU B: Tạo vấn tin hiển thị mã số nhân viên và tên nhân viên của các nhân viên
--có thu nhập cao hơn tiền lương trung bình. Sắp xếp kết quả theo thứ tự
---tiền lương giảm dần.
SELECT EMPLOYEE_ID , LAST_NAME,SALARY
FROM EMPLOYEES
WHERE SALARY > ( SELECT AVG(SALARY) FROM EMPLOYEES )
ORDER BY SALARY DESC

----CAU C:Viết vấn tin hiển thị mã số nhân viên và tên nhân viên của các nhân viên làm
--việc cùng phòng với những nhân viên có chữ u trong tên. Ghi câu lệnh SQL
--thành lab6_3.sql. Chạy vấn tin.
SELECT  DEPARTMENT_ID, LAST_NAME, EMPLOYEE_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DISTINCT DEPARTMENT_ID FROM EMPLOYEES WHERE LAST_NAME LIKE '%u%')

---CAU D:Hiển thị tên, mã số phòng ban và mã số công việc của tất cả các nhân viên
--có vị trí phòng ban là 1700.
--Hiển thị tên và tiền lương của những nhân viên do King quản lý.

SELECT LAST_NAME , DEPARTMENT_ID , JOB_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN ( SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE LOCATION_ID=1700)

SELECT d.DEPARTMENT_ID, e.LOCATION_ID, d.LAST_NAME 
FROM EMPLOYEES d
JOIN DEPARTMENTS e
ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
WHERE e.LOCATION_ID=1700

SELECT LAST_NAME ,SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE MANAGER_ID IS NULL )
																AND LAST_NAME <> 'King'

--CAU E: Hiển thị mã số phòng ban, tên nhân viên và mã số công việc của mọi nhân
---viên trong phòng ban tên Executive
SELECT DEPARTMENT_ID , LAST_NAME , JOB_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME LIKE 'Executive')

---CAU F:Thay đổi lab6_3.sql hiển thị mã số nhân viên, tên nhân viên và tiền lương
--của các nhân viên có thu nhập lớn hơn tiền lương trung bình và làm chung
--phòng với bất kỳ nhân viên nào có chữ u trong tên.
SELECT EMPLOYEE_ID , LAST_NAME,SALARY
FROM EMPLOYEES
WHERE SALARY > ( SELECT AVG(SALARY) FROM EMPLOYEES) 
AND DEPARTMENT_ID IN (SELECT DISTINCT DEPARTMENT_ID FROM EMPLOYEES WHERE LAST_NAME LIKE '%u%')

----THUC HANH CAU LENH SET
--CAU A:Phòng nhân sự cần danh sách mã số phòng ban không có công việc
--‘ST_CLERK’. Sử dụng toán tử tập hợp để tạo báo cáo này
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
EXCEPT
SELECT DEPARTMENT_ID
FROM EMPLOYEES
WHERE JOB_ID LIKE 'ST_CLERK'

---CAU B:Phòng nhân sự cần danh sách các quốc gia không đặt phòng ban nào. Hiển thị
--mã số quốc gia và tên quốc gia. Sử dụng toán tử tập hợp để tạo báo cáo này.
SELECT COUNTRY_ID , COUNTRY_NAME
FROM COUNTRIES
EXCEPT
SELECT DISTINCT l.COUNTRY_ID, c.COUNTRY_ID
FROM EMPLOYEES e
JOIN DEPARTMENTS d
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
JOIN LOCATIONS l
ON d.LOCATION_ID= l.LOCATION_ID
JOIN COUNTRIES c
ON c.COUNTRY_ID = l.COUNTRY_ID

---CAU C:Tạo danh sách các công việc cho các phòng ban 10, 50, 20 (kết quả theo
--đúng thứ tự phòng ban như vậy). Hiển thị mã số công việc và mã số phòng
--ban sử dụng toán tử tập hợp.


SELECT DISTINCT JOB_ID , DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 10
UNION ALL
SELECT JOB_ID ,DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50
UNION ALL
SELECT JOB_ID, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 20


---CAU D:Tạo báo cáo danh sách bao gồm mã nhân viên, mã công việc của các nhân
--viên có tên công việc giống như tên công việc khi họ bắt đầu vào làm (nghĩa là,
--họ đã từng thay đổi công việc nhưng bây giờ quay lại làm công việc ban đầu)
SELECT EMPLOYEE_ID, JOB_ID 
FROM JOB_HISTORY
UNION
SELECT EMPLOYEE_ID,JOB_ID
FROM JOB_HISTORY













