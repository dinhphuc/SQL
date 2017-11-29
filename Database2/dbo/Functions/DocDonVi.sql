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