namespace sap.oach.boardgameshop;

using { Currency, managed } from '@sap/cds/common';

entity BoardGames : managed { 
    key ID : Integer;
    title : localized String(111);
    year : Integer;
    player : String(6);
    genre : Genre;
    descr : String(1111);
    designer : Association to Designers;
    artist : Association to Artists;
    publisher : String(111);//Create table Publisher
    stock : Integer;
    price : Decimal(9,2);
    currency : Currency;
}

entity Designers : managed {
    key ID : Integer;
    name : String(111);
    boardGames : Association to many BoardGames on boardGames.designer = $self;
}

entity Artists : managed {
    key ID     : Integer;
    name       : String(111);
    boardGames : Association to many BoardGames on boardGames.artist = $self;
}

entity Orders : managed {
    key ID  : UUID;
    OrderNo : String @title:'Order Number'; //> readable key    
    Items   : Composition of many OrderItems on Items.parent = $self;
}

entity OrderItems {
    key ID   : UUID;
    parent   : Association to Orders;
    boardGame : Association to BoardGames;
    amount   : Integer;
}

type Genre : String enum {
    Family; Thematic; Eurogames; Abstracts; Wargame
}