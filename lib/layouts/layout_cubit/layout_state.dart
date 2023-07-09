part of 'layout_cubit.dart';

abstract class LayoutState {}

class LayoutInitial extends LayoutState {}

class GetUserDataSuccessState extends LayoutState{

}
class GetUserDataLoadingState extends LayoutState {

}
class ChangeBottomNavIndexState extends LayoutState{

}
class FieldToGetUserDataState extends LayoutState {
   String error;
   FieldToGetUserDataState({
      required this.error
});

}

class GetBannersDataSuccessState extends LayoutState{

}
class GetBannersDataLoadingState extends LayoutState{

}
class FieldGetBannersDataState extends LayoutState{

}


class GetCategoryDataSuccessState extends LayoutState{

}
class FieldGetCategoryDataState extends LayoutState{

}


class GetProductsSuccessState extends LayoutState{

}
class FieldGetProductsState extends LayoutState{

}
class FilterProductsSuccessState extends LayoutState{

}

class GetFavoritesSuccessState extends LayoutState{

}
class FieldGetFavoritesState extends LayoutState{

}
class AddOrRemoveFromFavoritesSuccess extends LayoutState{

}
class FieldAddOrRemoveFromFavorites extends LayoutState{

}
class GetCartsSuccessState extends LayoutState{}
class FieldToGetCartsState extends LayoutState{}

class AddOrRemoveFromCartsSuccess extends LayoutState {

}
class FieldAddOrRemoveFromCarts extends LayoutState {

}