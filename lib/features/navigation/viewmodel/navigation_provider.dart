import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationState {
  final String selectedPage;
  final bool isSidebarCollapsed;
  final Set<String> expandedMenus;

  const NavigationState({
    this.selectedPage = 'dashboard',
    this.isSidebarCollapsed = false,
    this.expandedMenus = const {},
  });

  NavigationState copyWith({
    String? selectedPage,
    bool? isSidebarCollapsed,
    Set<String>? expandedMenus,
  }) {
    return NavigationState(
      selectedPage: selectedPage ?? this.selectedPage,
      isSidebarCollapsed: isSidebarCollapsed ?? this.isSidebarCollapsed,
      expandedMenus: expandedMenus ?? this.expandedMenus,
    );
  }
}

class NavigationNotifier extends StateNotifier<NavigationState> {
  NavigationNotifier() : super(const NavigationState());

  void selectPage(String page) {
    state = state.copyWith(selectedPage: page);
  }

  void toggleSidebar() {
    state = state.copyWith(isSidebarCollapsed: !state.isSidebarCollapsed);
  }

  void setSidebarCollapsed(bool collapsed) {
    state = state.copyWith(isSidebarCollapsed: collapsed);
  }

  void toggleSubmenu(String menuKey) {
    final updated = Set<String>.from(state.expandedMenus);
    if (updated.contains(menuKey)) {
      updated.remove(menuKey);
    } else {
      updated.add(menuKey);
    }
    state = state.copyWith(expandedMenus: updated);
  }
}

final navigationProvider =
    StateNotifierProvider<NavigationNotifier, NavigationState>((ref) {
  return NavigationNotifier();
});
