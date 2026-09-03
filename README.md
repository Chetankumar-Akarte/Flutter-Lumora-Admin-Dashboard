# Flutter Lumora

<p align="center">
  <img src="demo/Flutter%20Lumora%20Dashbaord.png" alt="Flutter Lumora Dashboard Preview" width="100%" />
</p>

<p align="center">
  <strong>The Ultimate Enterprise-Grade Flutter Admin Dashboard UI Kit</strong><br>
  A modern, responsive, and token-driven administrative dashboard built with Flutter & Riverpod.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/Riverpod-2.6.1-%23377CFB.svg?style=for-the-badge" alt="Riverpod" />
  <img src="https://img.shields.io/badge/Platform-Web%20%7C%20macOS%20%7C%20Windows%20%7C%20Linux%20%7C%20iOS%20%7C%20Android-green?style=for-the-badge" alt="Platforms" />
  <img src="https://img.shields.io/badge/License-MIT-blue?style=for-the-badge" alt="License" />
</p>

---

## 🌟 Why Flutter Lumora

**Flutter Lumora** brings the design excellence of modern enterprise web dashboards to Flutter's cross-platform ecosystem. Inspired by the **[Lumora Bootstrap Admin Dashboard](https://github.com/Chetankumar-Akarte/lumora)**, this project translates rich desktop-class web ergonomics into high-performance, native-compiling Flutter applications for **Web, Desktop (macOS, Windows, Linux), and Mobile (iOS, Android)**.

### Key Highlights
- 🚀 **Zero Compromise Cross-Platform**: Pixel-perfect rendering across Web, macOS, Windows, Linux, Tablets, and Mobile.
- 🎨 **Token-Driven Design System**: Centralized design tokens for colors, typography, elevation, spacing, and border radii.
- 🌓 **Adaptive Light & Dark Themes**: Comprehensive support for theme switching with instant reactivity across all widgets.
- 📊 **Rich Interactive Visualizations**: Powered by `fl_chart` with interactive tooltips, sparklines, donuts, and grouped bar charts.
- 🧩 **Modular Clean Architecture**: Feature-first structure coupled with Riverpod state management for high testability and maintainability.

---

## 🎨 Design Principles

1. **Information Density with Visual Clarity**  
   Designed for operational and analytics workloads where data density is crucial, without cluttering the user interface.
2. **Token-Driven Design Tokens**  
   Every color, shadow, spacing step, border radius, and typography variant is driven by standardized theme tokens (`AppColors`, `AppTypography`, `AppSpacing`, `AppRadius`, `AppShadows`).
3. **Adaptive Responsiveness**  
   Fluid transitions across break points:
   - **Desktop / Wide Screens (≥ 1200px)**: Persistent full sidebar, multi-column dashboard grid.
   - **Tablet / Medium Screens (768px – 1199px)**: Collapsible icon rail sidebar, stacked widget arrangements.
   - **Mobile (< 768px)**: Off-canvas navigation drawer, single-column responsive views.
4. **Micro-Interactions & Hover Polish**  
   Smooth cursor feedback, elevation elevation shifts, custom tooltips, and animated state toggles tailored for mouse and touch interactions.

---

## 🏗️ Project Structure

The project follows a clean, feature-driven architecture ensuring clear separation of concerns:

```text
flutter-lumora/
├── demo/                                # Visual assets, recordings & screenshots
│   ├── Flutter Lumora Dashbaord.png
│   └── Flutter Lumora Dashbaord.mov
├── lib/
│   ├── core/                            # Core foundation & reusable components
│   │   ├── constants/                   # Design system tokens
│   │   │   ├── app_colors.dart          # Light & Dark color palettes
│   │   │   ├── app_radius.dart          # Corner radius definitions
│   │   │   ├── app_shadows.dart         # Elevation and shadow layers
│   │   │   ├── app_spacing.dart         # Standard spacing scale
│   │   │   └── app_typography.dart      # Google Fonts (Inter) typography scale
│   │   ├── theme/                       # ThemeData builder and ThemeProvider
│   │   │   ├── app_theme.dart
│   │   │   └── theme_provider.dart
│   │   ├── utils/                       # Breakpoint listeners & formatters
│   │   │   └── responsive_utils.dart
│   │   └── widgets/                     # Generic reusable UI primitives
│   │       ├── app_button.dart          # Outlined, Solid, Soft, Ghost variants
│   │       ├── app_card.dart            # Styled container card with header actions
│   │       ├── avatar_badge.dart        # Avatar component with status dots
│   │       ├── dashed_border_container.dart
│   │       ├── segmented_control.dart   # Interactive tab/pill switches
│   │       ├── sparkline_painter.dart   # Custom canvas sparkline renderer
│   │       └── status_badge.dart        # Soft status indicators (Active, Pending, etc.)
│   ├── features/                        # Domain & business features
│   │   ├── dashboard/                   # Main Analytics Dashboard
│   │   │   ├── data/                    # Models & mock repositories
│   │   │   ├── viewmodel/               # Dashboard state & controller logic
│   │   │   └── views/
│   │   │       ├── dashboard_screen.dart
│   │   │       └── widgets/             # Dashboard specific cards & charts
│   │   │           ├── gradient_kpi_strip.dart
│   │   │           ├── q2_goals_card.dart
│   │   │           ├── recent_activity_card.dart
│   │   │           ├── recent_orders_card.dart
│   │   │           ├── sales_by_channel_card.dart
│   │   │           ├── team_members_card.dart
│   │   │           ├── top_products_card.dart
│   │   │           ├── traffic_sources_card.dart
│   │   │           ├── visits_sales_chart_card.dart
│   │   │           └── weekly_stats_row.dart
│   │   └── navigation/                  # Shell, Topbar, Sidebar & Footer
│   │       ├── viewmodel/               # Navigation & menu expansion states
│   │       └── views/
│   │           ├── app_footer.dart      # Sticky / bottom footer with quick links
│   │           ├── app_shell.dart       # Responsive parent layout container
│   │           ├── app_sidebar.dart     # Collapsible hierarchical navigation menu
│   │           └── app_topbar.dart      # Header with search, actions, profile & theme toggle
│   └── main.dart                        # Application entrypoint
└── pubspec.yaml                         # Project dependencies & configurations
```

---

## ⚡ Core Features

### 1. Foundation & App Shell
- **Responsive Navigation Shell**: Fluid drawer/rail/sidebar transitions with memory for expanded accordion menus.
- **Interactive Top Header**: Global search bar, notifications modal, message drawer, quick action shortcuts, and profile menu.
- **Dynamic Theme Switcher**: Toggle smoothly between sleek Dark Mode and clean Light Mode.
- **Adaptive Breakpoints**: Custom layout calculations reacting to screen width changes in real time.

### 2. Main Executive Dashboard
- **Gradient KPI Metrics Strip**: Key indicators featuring revenue, new orders, visitor growth, and active subscribers with mini sparklines.
- **Visits & Sales Analytics**: Multi-series bar chart powered by `fl_chart` with timeframe filtering (Day, Week, Month, Year).
- **Sales by Channel**: Doughnut visualization representing Organic, Direct, Referral, and Social acquisition.
- **Recent Orders Data Table**: Paginated transaction logs with customer avatars, payment indicators, status badges, and action menus.
- **Top Performing Products**: Product performance metrics with stock progress bars, sales velocity, and revenue impact.
- **Traffic & Activity Timelines**: Live event streams and referral sources breakdown.
- **Team Collaborators & Goal Tracking**: Q2 milestone progress indicators and real-time team status list.

---

## 💻 Technology Stack

| Layer | Technologies / Packages |
| :--- | :--- |
| **Framework** | [Flutter](https://flutter.dev) (Channel stable, Dart 3.12+) |
| **State Management** | [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) `^2.6.1` |
| **Typography & Icons** | [google_fonts](https://pub.dev/packages/google_fonts) (Inter), [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter), [cupertino_icons](https://pub.dev/packages/cupertino_icons) |
| **Charts & Data Viz** | [fl_chart](https://pub.dev/packages/fl_chart) `^1.2.0`, Custom Canvas Sparklines |
| **Utilities & Localization** | [intl](https://pub.dev/packages/intl) `^0.20.3` |
| **Linting & Quality** | `flutter_lints` `^6.0.0` |

---

## 📸 Screenshots & Demos

### Dashboard Overview
![Flutter Lumora Dashboard](demo/Flutter%20Lumora%20Dashbaord.png)

### Video Walkthrough
A screen recording demo is available in the [`demo/`](demo/) folder:
- 🎬 [Watch Demo Video (`demo/Flutter Lumora Dashbaord.mov`)](demo/Flutter%20Lumora%20Dashbaord.mov)

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (version `>=3.12.0`)
- Dart SDK `>=3.12.0`
- Chrome (for Web) or macOS/Windows/Linux desktop build tools

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Chetankumar-Akarte/flutter-lumora.git
   cd flutter-lumora
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run on your preferred platform**:

   - **Chrome / Web**:
     ```bash
     flutter run -d chrome
     ```

   - **macOS Desktop**:
     ```bash
     flutter run -d macos
     ```

   - **Windows Desktop**:
     ```bash
     flutter run -d windows
     ```

   - **Mobile Simulator / Device**:
     ```bash
     flutter run
     ```

4. **Build for Release (Web)**:
   ```bash
   flutter build web --release
   ```

---

## 🗺️ Development Roadmap

Following the complete roadmap of the **[Lumora UI Kit Ecosystem](https://github.com/Chetankumar-Akarte/lumora)**, screens and modules are being implemented iteratively:

### 1. Foundation & Layout Shell
- [x] Responsive App Shell (`AppShell`)
- [x] Collapsible / Expandable Sidebar with nested categories (`AppSidebar`)
- [x] Interactive Top Header with Search, Actions & Profile Menu (`AppTopbar`)
- [x] Light & Dark Theme System (`AppTheme`, `AppColors`, `ThemeProvider`)
- [x] Core Design Tokens (Typography, Spacing, Radius, Shadows)
- [x] Reusable Primitives (`AppButton`, `AppCard`, `AvatarBadge`, `StatusBadge`, `SegmentedControl`)
- [x] Responsive Layout Utilities & Breakpoints
- [x] App Footer with Quick Links & System Status (`AppFooter`)

---

### 2. Dashboards Suite
- [x] **Analytics / Executive Overview Dashboard** *(Current Live Dashboard)*
- [ ] **E-Commerce Dashboard** (Sales KPIs, orders chart, category breakdown, abandoned carts)
- [ ] **CRM Dashboard** (Lead funnels, deals pipeline, customer lifetime value, conversion rates)
- [ ] **Project Management Dashboard** (Sprint velocity, task distribution, project timelines)
- [ ] **Finance & Banking Dashboard** (Cashflow, income/expense distribution, invoice statuses)
- [ ] **HRM & Workforce Dashboard** (Employee attendance, leaves, hiring pipeline, payroll)
- [ ] **SaaS & Subscription Dashboard** (MRR/ARR, churn rate, plan distribution, active cohorts)
- [ ] **Support & Helpdesk Dashboard** (Ticket resolution time, SLA compliance, agent leaderboard)
- [ ] **Warehouse & Logistics Dashboard** (Fleet status, inventory turnover, shipment tracking)
- [ ] **Operations & Cloud Monitor Dashboard** (Server health, CPU/RAM usage, uptime logs)

---

### 3. Applications & Workflow Modules
- [ ] **Chat & Team Messenger** (Channels, DM threads, media attachments, audio messages)
- [ ] **Email Client** (Inbox, sent, starred, compose drawer, email viewer with rich actions)
- [ ] **Calendar & Event Scheduler** (Month/Week/Day views, event creation modal, filters)
- [ ] **Kanban Board** (Drag-and-drop task columns, task tags, assignees, subtasks)
- [ ] **File Manager** (Folder explorer, storage quota visualization, preview modal)
- [ ] **Contacts & Address Book** (Contact cards, search/filter, vCard export)
- [ ] **Gallery & Media Manager** (Image grid, lightbox viewer, tagging, upload zones)

---

### 4. E-Commerce & Inventory
- [ ] **Product Catalog Grid & List View**
- [ ] **Product Details Screen** (Image carousel, variants, stock status, reviews)
- [ ] **Add / Edit Product Flow** (Multi-step wizard with image uploader)
- [ ] **Order Management & Data Table**
- [ ] **Order Details Page** (Tracking timeline, customer invoice, itemized list)
- [ ] **Customer Profiles & Purchase History**
- [ ] **Inventory & Stock Management**
- [ ] **Invoices List & Printable Invoice Template**

---

### 5. Data Tables & Advanced Lists
- [x] Responsive Data Table with Badges & Action Dropdowns *(In Dashboard)*
- [ ] Advanced Filterable & Sortable Data Table (Sticky headers, column toggle)
- [ ] Bulk Selection & Batch Operations (Delete, Export CSV/Excel)
- [ ] Expandable Row Details & Inline Editing

---

### 6. UI Kit & Component Library
- [x] Buttons (Solid, Outline, Soft, Ghost, Icon Buttons)
- [x] Cards & Section Containers
- [x] Avatars & Status Badges
- [x] Segmented Switchers & Tab Pills
- [ ] Form Controls (Text inputs, dropdowns, date/time pickers, tag inputs)
- [ ] Modals, Confirm Dialogs & Bottom Drawers
- [ ] Toast Notifications & Alert Banners
- [ ] Progress Indicators & Skeleton Loaders
- [ ] Sliders, Range Pickers & Steppers
- [ ] Accordions & Tree Views

---

### 7. Authentication & User Management
- [ ] Sign In / Login (Split-screen & centered variants)
- [ ] Sign Up / Registration Form
- [ ] Forgot & Reset Password Screens
- [ ] Two-Factor Authentication (OTP / 2FA verification)
- [ ] Lock Screen / Session Timeout
- [ ] User Profile & Account Settings
- [ ] Roles, Permissions & Access Control Matrix

---

### 8. Utility & Error Pages
- [ ] 404 Page Not Found
- [ ] 500 Internal Server Error
- [ ] Maintenance Mode Page
- [ ] Coming Soon Countdown Page
- [ ] Pricing & Subscription Plans
- [ ] FAQ & Knowledge Base

---

## 🤝 Contributing

Contributions, feedback, and suggestions are welcome! If you want to contribute to any pending roadmap item:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'feat: add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<p align="center">
  Crafted with ❤️ for the Flutter community by <a href="https://github.com/Chetankumar-Akarte">Chetankumar Akarte</a>.
</p>
