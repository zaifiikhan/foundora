import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:foundora/core/models/item_report.dart';

/// Temporary local persistence for reports.
///
/// Once you connect Firebase in Dreamflow, this service can be upgraded to use
/// Cloud Firestore while keeping the same API for the UI.
class FirestoreService {
  static final FirestoreService instance = FirestoreService._();
  FirestoreService._();

  static const _reportsKey = 'foundora.reports.v1';

  final StreamController<List<ItemReport>> _reportsController = StreamController.broadcast();
  bool _bootstrapped = false;

  Future<void> _ensureBootstrapped() async {
    if (_bootstrapped) return;
    _bootstrapped = true;
    final reports = await getReports();
    _reportsController.add(reports);
  }

  Stream<List<ItemReport>> watchReports() {
    // ignore: discarded_futures
    _ensureBootstrapped();
    return _reportsController.stream;
  }

  Future<void> createReport(ItemReport report) async {
    await _ensureBootstrapped();
    try {
      final prefs = await SharedPreferences.getInstance();
      final existing = await getReports();
      final next = [report, ...existing];
      await prefs.setString(_reportsKey, jsonEncode(next.map((e) => e.toJson()).toList()));
      _reportsController.add(next);
    } catch (e) {
      debugPrint('Failed to create report: $e');
      rethrow;
    }
  }

  Future<List<ItemReport>> getReports() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_reportsKey);
      if (raw == null || raw.isEmpty) return _seedSampleReports();

      final decoded = jsonDecode(raw);
      if (decoded is! List) return _seedSampleReports();

      final parsed = <ItemReport>[];
      for (final e in decoded) {
        if (e is! Map) continue;
        final map = e.map((k, v) => MapEntry(k.toString(), v));
        final r = ItemReport.fromJson(map);
        if (r.id.isEmpty || r.title.trim().isEmpty) continue;
        parsed.add(r);
      }

      parsed.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      // Auto-sanitize corrupted entries so future loads don't re-fail.
      await prefs.setString(_reportsKey, jsonEncode(parsed.map((e) => e.toJson()).toList()));
      return parsed;
    } catch (e) {
      debugPrint('Failed to load reports: $e');
      return _seedSampleReports();
    }
  }

  Future<void> clearLocalReports() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_reportsKey);
      final seeded = _seedSampleReports();
      _reportsController.add(seeded);
      await prefs.setString(_reportsKey, jsonEncode(seeded.map((e) => e.toJson()).toList()));
    } catch (e) {
      debugPrint('Failed to clear local reports: $e');
    }
  }

  List<ItemReport> _seedSampleReports() {
    final now = DateTime.now();
    return [
      ItemReport(
        id: 'seed_lost_wallet',
        type: ReportType.lost,
        title: 'Black Bi-fold Wallet',
        description: 'Slim leather wallet, small scratch near the corner. Contains a metro card.',
        category: 'Accessories',
        locationText: 'Central Mall, Food Court',
        challengeQuestion: 'What brand is the wallet?',
        createdAt: now.subtract(const Duration(hours: 6)),
        updatedAt: now.subtract(const Duration(hours: 6)),
      ),
      ItemReport(
        id: 'seed_found_wallet',
        type: ReportType.found,
        title: 'Black leather wallet',
        description: 'Found near the food court entrance. Looks like bi-fold, has a metro card.',
        category: 'Accessories',
        locationText: 'Central Mall, Food Court',
        challengeQuestion: 'What is the name on the ID inside?',
        createdAt: now.subtract(const Duration(hours: 3)),
        updatedAt: now.subtract(const Duration(hours: 3)),
      ),
      ItemReport(
        id: 'seed_lost_phone',
        type: ReportType.lost,
        title: 'iPhone 13 Pro - Blue',
        description: 'Blue iPhone with clear case. Tiny crack on bottom-left. Lock screen is a mountain photo.',
        category: 'Electronics',
        locationText: 'Liberty Park',
        challengeQuestion: 'What is the wallpaper on the phone?',
        createdAt: now.subtract(const Duration(hours: 10)),
        updatedAt: now.subtract(const Duration(hours: 10)),
      ),
      ItemReport(
        id: 'seed_found_phone',
        type: ReportType.found,
        title: 'Blue iPhone (13?)',
        description: 'Found a blue iPhone with a transparent case near the bench. Minor corner crack.',
        category: 'Electronics',
        locationText: 'Liberty Park',
        challengeQuestion: 'Which app is pinned in the dock?',
        createdAt: now.subtract(const Duration(hours: 7)),
        updatedAt: now.subtract(const Duration(hours: 7)),
      ),
    ];
  }
}
