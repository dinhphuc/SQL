-- CHuẩn hóa chuỗi
CREATE FUNCTION ChuanHoaChuoi ( @string NVARCHAR(200) )
RETURNS NVARCHAR(200)
AS
    BEGIN
        DECLARE @kq NVARCHAR(200)
        DECLARE @temp1 NVARCHAR(200)
        DECLARE @temp2 NVARCHAR(200)
		-- cắt sau trước cách
        SET @kq = RTRIM(@string)
		-- viết thường
        SET @kq = LOWER(@kq)
		-- Thay thế 2 dấu cách = 1 dấu
        SET @kq = REPLACE(@kq, '  ', ' ')
		SET @kq=LTRIM(@kq)
		SET @kq=RTRIM(@kq)
		-- Viết hoa chữ đầu
        SET @temp1 = SUBSTRING(@kq, 2, LEN(@kq))
        SET @temp2 = SUBSTRING(@kq, 1, 1)
        SET @temp2 = UPPER(@temp2)
        SET @kq = CONCAT(@temp2, @temp1)
        RETURN(@kq)
    END