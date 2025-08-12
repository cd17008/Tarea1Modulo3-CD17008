CREATE DATABASE DW_Ventas;
GO

USE DW_Ventas;
GO

CREATE TABLE DimTiempo (
    TiempoKey INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATE NOT NULL,
    Anio INT NOT NULL,
    Mes INT NOT NULL,
    Dia INT NOT NULL,
);

CREATE TABLE DimProducto (
    ProductoKey INT IDENTITY(1,1) PRIMARY KEY,
    IdProducto INT NOT NULL,
    SKUProducto NVARCHAR(50),
    Nombre NVARCHAR(50),
    Categoria NVARCHAR(50),
    Grupo NVARCHAR(50),
    TipoKit NCHAR(3),
    Canales TINYINT,
    Demografia NVARCHAR(50),
    PrecioVenta MONEY
);

CREATE TABLE DimEstadoCliente (
    EstadoClienteKey INT IDENTITY(1,1) PRIMARY KEY,
    IdEstado INT,
    CodigoEstado NVARCHAR(2),
    NombreEstado NVARCHAR(50),
    ZonaHoraria NVARCHAR(10),
    IdRegion INT,
    NombreRegion NVARCHAR(50)
);

CREATE TABLE DimBasura (
    BasuraKey INT IDENTITY(1,1) PRIMARY KEY,
    CodigoPromocion NVARCHAR(20)
);

CREATE TABLE FactVentas (
    FactVentaID INT IDENTITY(1,1) PRIMARY KEY,
    FechaEnvioKey INT NOT NULL,
    FechaOrdenKey INT NOT NULL,
    ProductoKey INT NOT NULL,
    EstadoClienteKey INT NOT NULL,
    BasuraKey INT NOT NULL,
    CantidadVendida INT NOT NULL,
    PrecioUnitario DECIMAL(9,2) NOT NULL,
    MontoDescuento DECIMAL(9,2) NOT NULL,
    MontoVenta DECIMAL(9,2) NOT NULL,

    FOREIGN KEY (FechaEnvioKey) REFERENCES DimTiempo(TiempoKey),
    FOREIGN KEY (FechaOrdenKey) REFERENCES DimTiempo(TiempoKey),
    FOREIGN KEY (ProductoKey) REFERENCES DimProducto(ProductoKey),
    FOREIGN KEY (EstadoClienteKey) REFERENCES DimEstadoCliente(EstadoClienteKey),
    FOREIGN KEY (BasuraKey) REFERENCES DimBasura(BasuraKey)
);
