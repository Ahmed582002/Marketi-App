abstract class BrandsState {}

class BrandsInitial extends BrandsState {}

class BrandsLoaded extends BrandsState {
  final List brands;

  BrandsLoaded(this.brands);
}
