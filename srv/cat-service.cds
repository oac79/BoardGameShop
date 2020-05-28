using { sap.oach.boardgameshop as my } from '../db/schema';
service CatalogService @(path:'/browse') {

    @readonly entity BoardGames as SELECT from my.BoardGames {*,
    designer.name as designer
  } excluding { createdBy, modifiedBy };

  @requires_: 'authenticated-user'
  @insertonly entity Orders as projection on my.Orders;
}