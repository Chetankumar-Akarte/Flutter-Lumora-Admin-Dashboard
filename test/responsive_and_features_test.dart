import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_lumora/main.dart';
import 'package:flutter_lumora/core/utils/responsive_layout.dart';
import 'package:flutter_lumora/features/navigation/viewmodel/navigation_provider.dart';

void main() {
  testWidgets('ResponsiveLayout detects screen sizes correctly',
      (WidgetTester tester) async {
    // Mobile Viewport
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ResponsiveLayout(
            mobile: Text('Mobile View'),
            tablet: Text('Tablet View'),
            desktop: Text('Desktop View'),
          ),
        ),
      ),
    );

    expect(find.text('Mobile View'), findsOneWidget);
    expect(find.text('Desktop View'), findsNothing);

    // Tablet Viewport
    tester.view.physicalSize = const Size(900, 1000);
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ResponsiveLayout(
            mobile: Text('Mobile View'),
            tablet: Text('Tablet View'),
            desktop: Text('Desktop View'),
          ),
        ),
      ),
    );
    expect(find.text('Tablet View'), findsOneWidget);

    // Desktop Viewport
    tester.view.physicalSize = const Size(1440, 900);
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ResponsiveLayout(
            mobile: Text('Mobile View'),
            tablet: Text('Tablet View'),
            desktop: Text('Desktop View'),
          ),
        ),
      ),
    );
    expect(find.text('Desktop View'), findsOneWidget);
  });

  testWidgets('Navigation Notifier expands and collapses menus',
      (WidgetTester tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final navNotifier = container.read(navigationProvider.notifier);
    expect(container.read(navigationProvider).isSidebarCollapsed, false);

    navNotifier.toggleSidebar();
    expect(container.read(navigationProvider).isSidebarCollapsed, true);

    navNotifier.toggleSidebar();
    expect(container.read(navigationProvider).isSidebarCollapsed, false);

    // Submenu expansion
    expect(container.read(navigationProvider).expandedMenus.contains('apps'), false);
    navNotifier.toggleSubmenu('apps');
    expect(container.read(navigationProvider).expandedMenus.contains('apps'), true);
    navNotifier.toggleSubmenu('apps');
    expect(container.read(navigationProvider).expandedMenus.contains('apps'), false);
  });

  testWidgets('Lumora Mobile drawer can be triggered',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const ProviderScope(
        child: LumoraApp(),
      ),
    );
    await tester.pumpAndSettle();

    // In mobile view, find the menu button and tap it
    final menuButton = find.byTooltip('Toggle Navigation');
    expect(menuButton, findsOneWidget);

    await tester.tap(menuButton);
    await tester.pumpAndSettle();

    // Drawer should open showing brand text
    expect(find.text('MAIN'), findsOneWidget);
    expect(find.text('Home'), findsWidgets);
  });

  testWidgets('Collapsed sidebar opens flyout submenu when tapped',
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

    // Collapse sidebar
    final collapseBtn = find.byTooltip('Collapse sidebar');
    expect(collapseBtn, findsOneWidget);
    await tester.tap(collapseBtn);
    await tester.pumpAndSettle();

    // In collapsed mode, tap on Dashboards expandable item
    final dashboardsItem = find.byTooltip('Dashboards');
    expect(dashboardsItem, findsOneWidget);
    await tester.tap(dashboardsItem);
    await tester.pumpAndSettle();

    // Flyout menu should show sub items like Analytics, E-commerce, CRM
    expect(find.text('Analytics'), findsOneWidget);
    expect(find.text('E-commerce'), findsOneWidget);
    expect(find.text('CRM'), findsOneWidget);

    // Tap Analytics
    await tester.tap(find.text('Analytics'));
    await tester.pumpAndSettle();
  });
}

