enum LicenseTier { starter, basic, pro }

extension LicenseTierX on LicenseTier {
  String get value => name;
  static LicenseTier fromString(String v) => LicenseTier.values
      .firstWhere((t) => t.name == v, orElse: () => LicenseTier.starter);

  String get displayName => switch (this) {
        LicenseTier.starter => 'Starter (Free)',
        LicenseTier.basic => 'Basic — Rs.299/month',
        LicenseTier.pro => 'Pro — Rs.699/month',
      };

  // ── STORAGE ──────────────────────────────────────────────────
  int get storageLimitBytes => switch (this) {
        LicenseTier.starter => 100 * 1024 * 1024, // 100 MB
        LicenseTier.basic => 500 * 1024 * 1024, // 500 MB
        LicenseTier.pro => 2048 * 1024 * 1024, // 2 GB
      };

  // ── INVOICE QUOTA ────────────────────────────────────────────
  // Tier default - operator can override per business via invoice_limit_override
  int get monthlyInvoiceLimit => switch (this) {
        LicenseTier.starter => 10,
        LicenseTier.basic => 100,
        LicenseTier.pro => 999999, // effectively unlimited
      };

  // ── USER / TEAM MEMBER LIMIT ─────────────────────────────────
  int get maxUsers => switch (this) {
        LicenseTier.starter => 1, // owner only
        LicenseTier.basic => 3,
        LicenseTier.pro => 999, // unlimited
      };

  // ── EMAIL ────────────────────────────────────────────────────
  bool get emailAllowed => this != LicenseTier.starter;
  bool get cronRemindersAllowed => this == LicenseTier.pro;

  // ── REPORTS ──────────────────────────────────────────────────
  bool get basicReportsAllowed => this != LicenseTier.starter;
  bool get fullReportsAllowed => this == LicenseTier.pro;

  // ── RETURNS ──────────────────────────────────────────────────
  bool get returnsAllowed => this != LicenseTier.starter;
  bool get creditNotesAllowed => this == LicenseTier.pro;

  // ── UPGRADE MESSAGE ──────────────────────────────────────────
  // Shown in UpgradeDialog when user taps a gated feature
  String upgradeMessageFor(String feature) => switch (this) {
        LicenseTier.starter =>
          '$feature is a paid feature. Upgrade to Basic or Pro.',
        LicenseTier.basic =>
          '$feature requires the Pro plan. Upgrade to unlock.',
        LicenseTier.pro => '', // Pro has everything
      };
}
