enum BottomNavigationEnum {
  home('Home', 0),
  search('Search', 1),
  cart('Cart', 2),
  favorites('Favorites', 3),
  settings('Settings', 4);

  final String label;
  final int mIndex;

  const BottomNavigationEnum(this.label, this.mIndex);
}
