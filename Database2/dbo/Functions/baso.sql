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