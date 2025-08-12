--DimProducto
SELECT ProductId as IdProducto, 
ProductSKU as SKUProducto,
ProductName as Nombre,
CASE ProductCategory
WHEN 'Co-Axial' THEN ProductCategory
WHEN 'Collective pitch' THEN 'Paso Colectivo'
WHEN 'Fixed pitch' THEN 'Paso Fijo'
WHEN 'Glider' THEN 'Planeador'
WHEN 'Trainer' THEN 'Entrenador'
WHEN 'Warbird' THEN 'Avion de Guerra'
ELSE ProductCategory END AS Categoria,
CASE ItemGroup 
WHEN 'Airplane' THEN 'Avion'
WHEN 'Helicopter' THEN 'Helicoptero'
ELSE ItemGroup END AS Grupo,
CONVERT(VARCHAR(25), CASE KitType
WHEN 'RTF' THEN 'Listo Para Volar'
WHEN 'KIT' THEN 'Kit Ensamblaje'
ELSE KitType END) AS Tipo,
Channels as Canales,
CASE Demographic
WHEN 'Novice' THEN 'Novato'
WHEN 'Beginner' THEN 'Principiante'
WHEN 'Intermediate' THEN 'Intermedio'
WHEN 'Advanced' THEN 'Avanzado'
WHEN 'Professional' THEN 'Profesional'
ELSE Demographic END AS Demografia,
RetailPrice AS PrecioVenta
FROM Product;

--DimEstadoCliente
SELECT sa.CustomerStateID AS IdEstado, 
s.StateCode as CodigoEstado,
s.StateName as NombreEstado,
CASE s.TimeZone 
WHEN 'AKST' THEN 'Alaska'
WHEN 'CST' THEN 'Hora Central'
WHEN 'EST' THEN 'Hora del Este'
WHEN 'HST' THEN 'Hora Hawai'
WHEN 'MST' THEN 'Hora Montanas'
WHEN 'PST' THEN 'Hora Pacifico'
ELSE s.TimeZone END
as ZonaHoraria,
r.RegionID as IdRegion,
CASE r.RegionName 
WHEN 'Midwest' THEN 'Medio Oeste'
WHEN 'New England' THEN 'Nueva Inglaterra'
WHEN 'Northeast' THEN 'Noreste'
WHEN 'Pacific Northwest' THEN 'Pacifico Noroeste'
WHEN 'Southern' THEN 'Sur'
WHEN 'Southwest' THEN 'Suroeste'
ELSE r.RegionName END
AS NombreRegion
FROM Sales sa
INNER JOIN State s ON sa.CustomerStateID = s.StateID
INNER JOIN Region r ON s.RegionID = r.RegionID;

--DimChunk
SELECT DISTINCT ISNULL(PromotionCode,'Sin Promocion') AS CodigoPromocion FROM SALES;

--FactVentas
SELECT OrderDate as FechaOrden,
ISNULL(ShipDate,'9999-01-01') as FechaEnvio,
ProductID,
CustomerStateID as EstadoCliente,
ISNULL(PromotionCode,'Sin Promocion') as Chunk,
Quantity as Cantidad,
UnitPrice as PrecioUnitario,
DiscountAmount as MontoDescuento,
(UnitPrice*Quantity)-DiscountAmount as MontoVenta
FROM Sales;