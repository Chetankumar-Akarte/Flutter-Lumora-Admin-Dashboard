import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_lumora/main.dart';
import 'package:flutter_lumora/core/theme/theme_provider.dart';
import 'package:flutter_lumora/features/dashboard/viewmodel/dashboard_providers.dart';

void main() {
  testWidgets('Lumora App loads dashboard with KPI titles and navigation',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const ProviderScope(
        child: LumoraApp(),
      ),
    );

    await tester.pumpAndSettle();

    // Verify Brand Title & Page Header
    expect(find.text('Lumora'), findsOneWidget);
    expect(find.text('Dashboard'), findsWidgets);
    expect(find.text('Total Revenue'), findsOneWidget);
    expect(find.text('\$284,521'), findsOneWidget);
    expect(find.text('New Customers'), findsOneWidget);
    expect(find.text('1,842'), findsOneWidget);
    expect(find.text('Active Projects'), findsOneWidget);
    expect(find.text('38'), findsOneWidget);
    expect(find.text('Pending Tasks'), findsOneWidget);
    expect(find.text('127'), findsOneWidget);

    // Verify Top Products
    expect(find.text('Top Products'), findsOneWidget);
    expect(find.text('Wireless Earbuds Pro'), findsWidgets);
    expect(find.text('Lumora Canvas Tote'), findsOneWidget);
    expect(find.text('Smart Fitness Band'), findsOneWidget);
    expect(find.text('Artisan Coffee Blend'), findsOneWidget);
    expect(find.text('Minimalist Notebook'), findsOneWidget);
    expect(find.text('Pro Gaming Mouse'), findsOneWidget);
  });

  testWidgets('Theme toggle switches between light and dark themes',
      (WidgetTester tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(themeModeProvider), ThemeMode.light);

    container.read(themeModeProvider.notifier).toggleTheme();
    expect(container.read(themeModeProvider), ThemeMode.dark);

    container.read(themeModeProvider.notifier).toggleTheme();
    expect(container.read(themeModeProvider), ThemeMode.light);
  });

  test('Dashboard ViewModel updates timeframe correctly', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final vm = container.read(dashboardViewModelProvider.notifier);
    expect(container.read(dashboardViewModelProvider).selectedTimeframe, 'Year');

    vm.setTimeframe('Month');
    expect(container.read(dashboardViewModelProvider).selectedTimeframe, 'Month');
    expect(container.read(dashboardViewModelProvider).visitSalesData.length, 4);

    vm.setTimeframe('Week');
    expect(container.read(dashboardViewModelProvider).selectedTimeframe, 'Week');
    expect(container.read(dashboardViewModelProvider).visitSalesData.length, 7);
  });
}
