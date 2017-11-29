
--Syntax Error: Incorrect syntax near SELECT.
---- Chuyển số thành chữ ( đọc Tiền )
--CREATE FUNCTION ChuyenSoThanhChu ( @so BIGINT )
--RETURNS NVARCHAR(200)
--AS
--    BEGIN
--	
--        DECLARE @kq NVARCHAR(200)
--        DECLARE @ngan INT
--        DECLARE @trieu INT
--        DECLARE @ty INT
--        DECLARE @donvi INT
--        IF @so = 0
--            SET @kq = CONCAT(@kq, N' Không ')
--        ELSE
--            BEGIN
--                SET @donvi = @so % 1000
--                SET @so /= 1000
--                SET @ngan = @so % 1000
--                SET @so /= 1000
--                SET @trieu = @so % 1000
--                SET @ty = @so / 1000
--                IF @ty > 0
--                    SET @kq = CONCAT(@kq, dbo.baso(@ty), N' Tỷ ')
--                IF @trieu > 0
--                    SET @kq = CONCAT(@kq, dbo.baso(@trieu), N' Triệu ')
--                IF @ngan > 0
--                    SET @kq = CONCAT(@kq, dbo.baso(@ngan), N' Nghìn ')
--                IF @donvi > 0
--                    SET @kq = CONCAT(@kq, dbo.baso(@donvi))
--            END
--			
--        RETURN(dbo.ChuanHoaChuoi(@kq))
--    END 
--
--
--SELECT  dbo.ChuanHoaChuoi(N' Một Tỷ Một  Trăm  Mười  Một Triệu Hai  Mươi Nghìn Một  Trăm  Lẻ  Lăm ')
--SELECT dbo.ChuyenSoThanhChu(131528794541)



GO
