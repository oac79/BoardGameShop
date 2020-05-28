namespace sap.oach.boardgameshop;

using { Currency, managed, cuid } from '@sap/cds/common';

entity BoardGames : managed { 
    key ID : Integer;
    title : localized String(111);
    year : Integer;
    player : String(6);
    genre : localized Genre;
    descr : localized String(1111);
    designer : Association to Designers;
    artist : Association to Artists;
    publisher : Association to Publishers;
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

entity Publishers : managed {
    key ID     : Integer;
    name       : String(111);
    boardGames : Association to many BoardGames on boardGames.publisher = $self;  
}

entity Orders : cuid, managed {
    OrderNo  : String @title:'Order Number'; //> readable key    
    Items    : Composition of many OrderItems on Items.order = $self;
    total    : Decimal(9, 2) @readonly;
    currency : Currency;
}

entity OrderItems : cuid {
    key order : Association to Orders;
    boardGame : Association to BoardGames;
    amount    : Integer;
}

type Genre : String enum {
    Family; Thematic; Eurogames; Abstracts; Wargame
}