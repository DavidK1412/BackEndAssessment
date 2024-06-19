CREATE DATABASE property;

-- Table of Cities
CREATE TABLE City (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Table of Property Categories
CREATE TABLE Category (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Table of Permissions
CREATE TABLE Permissions (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL
);

-- Table of Roles
CREATE TABLE Role (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL
);

CREATE TABLE Role_Permissions (
    role_id INT NOT NULL,
    permission_id INT NOT NULL,
    FOREIGN KEY (role_id) REFERENCES Role(id),
    FOREIGN KEY (permission_id) REFERENCES Permissions(id)
);

CREATE TABLE SecurityUser (
    id UUID PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    hash VARCHAR(255) NOT NULL,
    salt VARCHAR(255) NOT NULL,
    role_id INT NOT NULL,
    FOREIGN KEY (role_id) REFERENCES Role(id)
);

CREATE TABLE User_Permissions (
    user_id UUID NOT NULL,
    permission_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES SecurityUser(id),
    FOREIGN KEY (permission_id) REFERENCES Permissions(id)
);

CREATE TABLE Customer (
    id UUID PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    id_user UUID NOT NULL,
    city UUID NOT NULL,
    FOREIGN KEY (id_user) REFERENCES SecurityUser(id),
    FOREIGN KEY (city) REFERENCES City(id)
);


CREATE TABLE Agent (
    id UUID PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(255) NOT NULL,
    id_user UUID NOT NULL,
    city UUID NOT NULL,
    FOREIGN KEY (id_user) REFERENCES SecurityUser(id),
    FOREIGN KEY (city) REFERENCES City(id)
);

CREATE TABLE Owner (
    id UUID PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city UUID NOT NULL,
    FOREIGN KEY (city) REFERENCES City(id)
);

CREATE TABLE Property (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city UUID NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description VARCHAR(255) NOT NULL,
    category INT NOT NULL,
    owner_id UUID NOT NULL,
    agent_id UUID NOT NULL,
    FOREIGN KEY (category) REFERENCES Category(id),
    FOREIGN KEY (owner_id) REFERENCES Owner(id),
    FOREIGN KEY (city) REFERENCES City(id),
    FOREIGN KEY (agent_id) REFERENCES Agent(id)
);

CREATE TABLE Property_Photos (
    id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    photo VARCHAR(255) NOT NULL,
    FOREIGN KEY (property_id) REFERENCES Property(id)
);


CREATE TABLE Transaction (
    id UUID PRIMARY KEY,
    customer_id UUID NOT NULL,
    property_id UUID NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(id),
    FOREIGN KEY (property_id) REFERENCES Property(id)
);