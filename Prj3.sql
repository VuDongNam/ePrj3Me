CREATE DATABASE ePrj3
GO
USE ePrj3

CREATE TABLE Roler(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Roler VARCHAR(100) NOT NULL -- Tên phân loại người dùng (SuperAdmin; Admin; Staff; User)
)
CREATE TABLE Account(
	Id INT PRIMARY KEY IDENTITY(1,1), 
	UserName VARCHAR(100) NOT NULL, --Tên đăng nhập
	FullName VARCHAR(150) NOT NULL, --Tên họ đầy đủ
	Email VARCHAR(100) NOT NULL,
	Pass VARCHAR(100) NOT NULL,
	Phone VARCHAR(20), 
	StartDate DATE NOT NULL,
	OnOff VARCHAR(50) NOT NULL, --Trạng thái tài khoản Active | Locked (0|1)
	RoleId INT -- Thuộc nhóm Roler nào
	FOREIGN KEY (RoleId) REFERENCES Roler(Id)
)


CREATE TABLE CategoryType(
	Id INT PRIMARY KEY IDENTITY(1,1),  -- (1 Machine; 2 Drug)
	CateTypeName VARCHAR(50) NOT NULL -- Tên Ngành hàng (Machine; Drug)
)
CREATE TABLE Category(
	Id INT PRIMARY KEY IDENTITY(1,1),
	CateName VARCHAR(150) NOT NULL, -- Tên Nhóm hàng
	CateTypeId INT NOT NULL
	FOREIGN KEY (CateTypeId) REFERENCES CategoryType(Id)
)
CREATE TABLE Product(
	Id INT PRIMARY KEY IDENTITY(1,1),
	PrCode VARCHAR(150) NOT NULL, -- Code SP
	PrName VARCHAR(250) NOT NULL, -- Tên SP
	PrUnit VARCHAR(50) NOT NULL, -- Đơn vị tính
	PrCost DECIMAL NOT NULL, -- Giá nhập
	PrPrice DECIMAL NOT NULL, -- Giá bán
	PrDescription VARCHAR(500),	--Mô tả
	PrImage VARCHAR(250), -- Hình ảnh
	PrOriginal VARCHAR(50) NOT NULL, --Xuất xứ
	CateId INT NOT NULL --Thuộc nhóm Category
	FOREIGN KEY (CateId) REFERENCES Category(Id)
)


CREATE TABLE Storage(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Code VARCHAR(150) NOT NULL, -- Số hiệu lô hàng
	Contents VARCHAR(350) NOT NULL, -- Nội dung chính của lô hàng
	Import_date DATE NOT NULL,  -- Ngày nhập hàng
	UserId INT NOT NULL
	FOREIGN KEY (UserId) REFERENCES Account(Id)
)
CREATE TABLE StorageDetail( 
	Id INT PRIMARY KEY IDENTITY(1,1),
	SlotId INT NOT NULL, -- Thuộc lô hàng
	ProductId INT NOT NULL, -- ID của Product
	QuantityIn INT NOT NULL, --Số lượng nhập 
	QuantityOut INT NOT NULL, --Số lượng xuất
	ActionDate DATE NOT NULL, -- Ngày nhập | xuất
	MadeDate DATE NOT NULL, --Ngày sản xuất
	PrGuarantee DATE NOT NULL	--Ngày hết hạn (SD| bảo hành)
	FOREIGN KEY (SlotId) REFERENCES Storage(Id),
	FOREIGN KEY (ProductId) REFERENCES Product(Id)
)

CREATE TABLE OrderState(
	Id INT PRIMARY KEY IDENTITY(1,1),
	OrStName VARCHAR(150) NOT NULL -- Tên trạng thái Order SP (Chưa thanh toán| Đã thanh toán | Đã giao nhận thành công)
)
CREATE TABLE [Order](
	Id INT PRIMARY KEY IDENTITY(1,1),
	CustomId INT NOT NULL -- Mã KH
	FOREIGN KEY (CustomId) REFERENCES Account(Id)
)
CREATE TABLE OrderDetail(
	Id INT PRIMARY KEY IDENTITY(1,1),
	OrderId INT NOT NULL,-- ID đơn hàng
	ProductId INT NOT NULL,	-- ID SP
	Quantity INT NOT NULL, -- Số lượng
	ChooseDate DATETIME NOT NULL, -- Ngày đưa vào giỏ hàng
	OrderDate DATETIME NOT NULL, -- Ngày quyết định mua hàng
	OrderPrice DECIMAL NOT NULL, -- Giá bán tại thời điểm khách quyết định mua
	OrderState INT NOT NULL -- Trạng thái (Chưa thanh toán| Đã thanh toán | Đã giao nhận thành công)
	FOREIGN KEY (OrderId) REFERENCES [Order](Id),
	FOREIGN KEY (ProductId) REFERENCES Product(Id),
	FOREIGN KEY (OrderState) REFERENCES OrderState(Id)
)


CREATE TABLE Education(
	Id INT PRIMARY KEY IDENTITY(1,1), 
	Title VARCHAR(250) NOT NULL, -- Chủ đề khóa học
	Content VARCHAR(550), --Nội dung chính của khóa học
	TeacherId INT, -- Người hướng dẫn, giảng dạy
	StartTime DATETIME NOT NULL,
	EndTime DATETIME NOT NULL 
	FOREIGN KEY (TeacherId) REFERENCES Account(Id)
)
CREATE TABLE EduDetail(
	Id INT PRIMARY KEY IDENTITY(1,1),
	StudentId INT NOT NULL, 
	EduId INT NOT NULL
	FOREIGN KEY (StudentId) REFERENCES Account(Id),
	FOREIGN KEY (EduId) REFERENCES Education(Id)
)

CREATE TABLE Feedback(	
	Id INT PRIMARY KEY IDENTITY(1,1),
	ProductId INT NOT NULL,-- Mã sản phẩm có feedback
	FbUser INT NOT NULL,-- Mã khách hàng feedback
	FbTime DATETIME NOT NULL, -- Ngày tạo feedback
	FbInfo VARCHAR(550) NOT NULL, -- Nội dung feedback
	FbRuler INT NOT NULL,-- mức độ hài lòng về SP|DV
	ReplyUser INT NOT NULL, -- Người trả lời feedback
	ReplyTime DATETIME NOT NULL, -- Ngày trả lời feedback
	Reply VARCHAR(550) NOT NULL -- Nội dung trả lời feedback
	FOREIGN KEY (ProductId) REFERENCES Product(Id),
	FOREIGN KEY (FbUser) REFERENCES Account(Id),
	FOREIGN KEY (ReplyUser) REFERENCES Account(Id)
)

-- drop database Prj3