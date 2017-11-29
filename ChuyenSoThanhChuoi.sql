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
GO
---- Đọc đơn vị
CREATE FUNCTION DocDonVi ( @donvi INT )
RETURNS NVARCHAR(10)
AS
    BEGIN
        DECLARE @kq NVARCHAR(10)
        SELECT  @kq = CASE @donvi
                        WHEN 1 THEN N'Một'
                        WHEN 2 THEN N'Hai'
                        WHEN 3 THEN N'Ba'
                        WHEN 4 THEN N'Bốn'
                        WHEN 5 THEN N'Năm'
                        WHEN 6 THEN N'Sáu'
                        WHEN 7 THEN N'Bảy'
                        WHEN 8 THEN N'Tám'
                        WHEN 9 THEN N'Chín'
                      END
        RETURN(@kq)
    END
GO
--Đọc khối 3 số
CREATE FUNCTION baso ( @so INT )
RETURNS NVARCHAR(100)
AS
    BEGIN
        DECLARE @kq NVARCHAR(100)
        DECLARE @donvi INT
        DECLARE @chuc INT
        DECLARE @tram INT
        SET @donvi = @so % 10
        SET @so = @so / 10
        SET @chuc = @so % 10
        SET @tram = @so / 10;

		--Hàng Trăm
        IF @tram > 0
            BEGIN
                SET @kq = CONCAT(@kq, dbo.DocDonVi(@tram), N' Trăm ')
            END
		--Hàng Chục
        IF @chuc > 0
            BEGIN
                IF @chuc = 1
                    SET @kq = CONCAT(@kq, N'Mười ')
                ELSE
                    BEGIN
                        SET @kq = CONCAT(@kq, dbo.DocDonVi(@chuc), N' Mươi ')
                    END
            END
		--Hàn đơn vị
        IF @donvi > 0
            BEGIN
                IF ( @chuc = 0
                     AND @tram != 0
                   )
                    SET @kq = CONCAT(@kq, N'Lẻ ')
                   
                IF ( @donvi = 1 )
                    SET @kq = CONCAT(@kq, N'Mốt')  
                ELSE
                    IF ( @donvi = 5
                         AND ( @chuc != 0
                               OR @tram != 0
                             )
                       )
                        SET @kq = CONCAT(@kq, N'Lăm')
                    ELSE
                        IF ( @donvi = 5
                             AND ( @chuc = 0
                                   OR @tram != 0
                                 )
                           )
                            SET @kq = CONCAT(@kq, N'Năm')
                        ELSE
                            SET @kq = CONCAT(@kq, dbo.DocDonVi(@donvi))
                          
            END

        RETURN(@kq)
    END 

GO
-- Chuyển số thành chữ ( đọc Tiền )
CREATE FUNCTION ChuyenSoThanhChu ( @so BIGINT )
RETURNS NVARCHAR(200)
AS
    BEGIN
	
        DECLARE @kq NVARCHAR(200)
        DECLARE @ngan INT
        DECLARE @trieu INT
        DECLARE @ty INT
        DECLARE @donvi INT
        IF @so = 0
            SET @kq = CONCAT(@kq, N' Không ')
        ELSE
            BEGIN
                SET @donvi = @so % 1000
                SET @so /= 1000
                SET @ngan = @so % 1000
                SET @so /= 1000
                SET @trieu = @so % 1000
                SET @ty = @so / 1000
                IF @ty > 0
                    SET @kq = CONCAT(@kq, dbo.baso(@ty), N' Tỷ ')
                IF @trieu > 0
                    SET @kq = CONCAT(@kq, dbo.baso(@trieu), N' Triệu ')
                IF @ngan > 0
                    SET @kq = CONCAT(@kq, dbo.baso(@ngan), N' Nghìn ')
                IF @donvi > 0
                    SET @kq = CONCAT(@kq, dbo.baso(@donvi))
            END
			
        RETURN(dbo.ChuanHoaChuoi(@kq))
    END 


SELECT  dbo.ChuanHoaChuoi(N' Một Tỷ Một  Trăm  Mười  Một Triệu Hai  Mươi Nghìn Một  Trăm  Lẻ  Lăm ')
SELECT dbo.ChuyenSoThanhChu(131528794541)