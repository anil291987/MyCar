/// The selected accent-color theme for the UI. Independent of any real
/// manufacturer — this app is brand-agnostic, so these are named for their
/// color/mood, not a car company.
enum AppBrand {
  steel,
  crimson,
  champagne;

  String get displayName => switch (this) {
        AppBrand.steel => 'Steel Blue',
        AppBrand.crimson => 'Crimson Red',
        AppBrand.champagne => 'Champagne Gold',
      };
}
