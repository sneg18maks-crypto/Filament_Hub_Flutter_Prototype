
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(const FilamentHubApp());

const bg = Color(0xFF0B1015);
const panel = Color(0xFF141C24);
const panel2 = Color(0xFF1B2631);
const accent = Color(0xFF36D6B0);
const muted = Color(0xFF91A0AE);
const orange = Color(0xFFFFB454);

class FilamentHubApp extends StatelessWidget {
  const FilamentHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filament Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: const ColorScheme.dark(
          primary: accent, secondary: orange, surface: panel,
        ),
        fontFamily: 'Roboto',
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: panel2, contentTextStyle: TextStyle(color: Colors.white),
        ),
      ),
      home: const AppShell(),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int index = 0;
  final pages = const [
    OverviewPage(),
    PrinterPage(),
    FilamentPage(),
    CatalogPage(),
    SettingsPage(),
  ];
  final titles = ['Обзор', 'Принтер', 'Филамент', 'Каталог', 'Настройки'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        titleSpacing: 20,
        title: Row(children: [
          Container(
            width: 34, height: 34,
            decoration: BoxDecoration(color: accent.withOpacity(.13), borderRadius: BorderRadius.circular(11)),
            child: const Icon(Icons.view_in_ar_rounded, color: accent, size: 21),
          ),
          const SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('FILAMENT HUB', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 1.4)),
            Text(titles[index].toUpperCase(), style: const TextStyle(fontSize: 9, color: muted, letterSpacing: 1.6)),
          ]),
        ]),
        actions: [
          IconButton(
            tooltip: 'Уведомления',
            onPressed: () => toast(context, 'Уведомления пока демонстрационные'),
            icon: const Icon(Icons.notifications_none_rounded, color: muted),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: NavigationBar(
        height: 72,
        backgroundColor: const Color(0xFF10171E),
        indicatorColor: accent.withOpacity(.15),
        selectedIndex: index,
        onDestinationSelected: (v) => setState(() => index = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.grid_view_rounded), selectedIcon: Icon(Icons.grid_view_rounded), label: 'Обзор'),
          NavigationDestination(icon: Icon(Icons.print_rounded), label: 'Принтер'),
          NavigationDestination(icon: Icon(Icons.inventory_2_outlined), label: 'Филамент'),
          NavigationDestination(icon: Icon(Icons.explore_outlined), label: 'Модели'),
          NavigationDestination(icon: Icon(Icons.tune_rounded), label: 'Ещё'),
        ],
      ),
    );
  }
}

void toast(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), behavior: SnackBarBehavior.floating));
}

class PageBody extends StatelessWidget {
  final Widget child;
  const PageBody({super.key, required this.child});
  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    child: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 26),
      child: child,
    ),
  );
}

class SectionTitle extends StatelessWidget {
  final String title;
  final String? trailing;
  final VoidCallback? onTap;
  const SectionTitle(this.title, {super.key, this.trailing, this.onTap});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 22, bottom: 12),
    child: Row(children: [
      Expanded(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800))),
      if (trailing != null)
        GestureDetector(onTap: onTap, child: Text(trailing!, style: const TextStyle(color: accent, fontSize: 12, fontWeight: FontWeight.w700))),
    ]),
  );
}

class Surface extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  const Surface({super.key, required this.child, this.padding = const EdgeInsets.all(16), this.onTap});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: panel,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

class StatusPill extends StatelessWidget {
  final String text;
  final Color color;
  const StatusPill(this.text, {super.key, this.color = accent});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(color: color.withOpacity(.12), borderRadius: BorderRadius.circular(30)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 6),
      Text(text, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w800)),
    ]),
  );
}

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});
  @override
  Widget build(BuildContext context) {
    return PageBody(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Surface(
        padding: const EdgeInsets.all(19),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
            Text('ТВОЯ МАСТЕРСКАЯ', style: TextStyle(color: muted, fontSize: 10, letterSpacing: 1.5, fontWeight: FontWeight.w800)),
            StatusPill('ДЕМО-РЕЖИМ', color: orange),
          ]),
          const SizedBox(height: 16),
          const Text('Всё под контролем.', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, height: 1.1)),
          const SizedBox(height: 7),
          const Text('Состояние принтера, катушки и печати — на одном экране.', style: TextStyle(color: muted, height: 1.4, fontSize: 12)),
          const SizedBox(height: 18),
          Row(children: [
            Expanded(child: _quickMetric(Icons.print_rounded, 'Принтер', 'Не подключён', orange)),
            const SizedBox(width: 10),
            Expanded(child: _quickMetric(Icons.rss_feed_rounded, 'RFID', 'Ожидание', muted)),
          ]),
        ]),
      ),
      const SectionTitle('Текущая катушка', trailing: 'Подробнее'),
      Surface(child: Column(children: [
        Row(children: [
          Container(width: 56, height: 56, decoration: BoxDecoration(color: const Color(0xFF3D8FEA).withOpacity(.16), borderRadius: BorderRadius.circular(15)), child: const Icon(Icons.circle, color: Color(0xFF3D8FEA), size: 34)),
          const SizedBox(width: 13),
          const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('PLA · Ocean Blue', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
            SizedBox(height: 4),
            Text('RFID: FH-PLA-000184', style: TextStyle(color: muted, fontSize: 10)),
          ])),
          const StatusPill('АКТИВНА'),
        ]),
        const SizedBox(height: 18),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
          Text('Остаток материала', style: TextStyle(color: muted, fontSize: 11)),
          Text('684 г / 1000 г', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
        ]),
        const SizedBox(height: 9),
        ClipRRect(borderRadius: BorderRadius.circular(20), child: const LinearProgressIndicator(value: .684, minHeight: 8, backgroundColor: panel2, color: accent)),
        const SizedBox(height: 13),
        Row(children: const [
          Expanded(child: _smallInfo('Влажность', '32%', Icons.water_drop_outlined)),
          Expanded(child: _smallInfo('Температура', '22 °C', Icons.thermostat_outlined)),
          Expanded(child: _smallInfo('Материал', 'PLA', Icons.layers_outlined)),
        ]),
      ])),
      const SectionTitle('Принтер'),
      Surface(child: Row(children: [
        Container(width: 46, height: 46, decoration: BoxDecoration(color: orange.withOpacity(.12), borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.print_outlined, color: orange)),
        const SizedBox(width: 12),
        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Мой 3D-принтер', style: TextStyle(fontWeight: FontWeight.w800)),
          SizedBox(height: 4),
          Text('Добавь устройство по Wi-Fi', style: TextStyle(color: muted, fontSize: 11)),
        ])),
        const Icon(Icons.chevron_right, color: muted),
      ]), onTap: () => toast(context, 'Открой вкладку «Принтер» для подключения')),
      const SectionTitle('Быстрые действия'),
      Row(children: [
        Expanded(child: _actionTile(context, Icons.add_link_rounded, 'Добавить RFID', 'Привязка катушки')),
        const SizedBox(width: 10),
        Expanded(child: _actionTile(context, Icons.folder_open_rounded, 'Мои файлы', 'G-code и проекты')),
      ]),
    ]));
  }

  static Widget _quickMetric(IconData icon, String label, String value, Color c) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(13)),
    child: Row(children: [
      Icon(icon, color: c, size: 19), const SizedBox(width: 8),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(color: muted, fontSize: 10)),
        const SizedBox(height: 3),
        Text(value, style: TextStyle(color: c, fontSize: 11, fontWeight: FontWeight.w800)),
      ])),
    ]),
  );

  static Widget _actionTile(BuildContext context, IconData icon, String title, String sub) => Surface(
    onTap: () => toast(context, 'Функция будет подключена на следующем этапе'),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, color: accent, size: 22), const SizedBox(height: 13),
      Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
      const SizedBox(height: 4),
      Text(sub, style: const TextStyle(color: muted, fontSize: 10)),
    ]),
  );
}

class _smallInfo extends StatelessWidget {
  final String label, value;
  final IconData icon;
  const _smallInfo(this.label, this.value, this.icon);
  @override
  Widget build(BuildContext context) => Row(children: [
    Icon(icon, size: 15, color: muted), const SizedBox(width: 5),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(color: muted, fontSize: 9)),
      const SizedBox(height: 3),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
    ])),
  ]);
}

class PrinterPage extends StatelessWidget {
  const PrinterPage({super.key});
  @override
  Widget build(BuildContext context) {
    return PageBody(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
        Text('Управление', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900)),
        StatusPill('OFFLINE', color: orange),
      ]),
      const SizedBox(height: 5),
      const Text('Подключи принтер, чтобы получить телеметрию и управлять печатью.', style: TextStyle(color: muted, fontSize: 11)),
      const SectionTitle('Камера принтера'),
      Container(
        height: 205, width: double.infinity,
        decoration: BoxDecoration(color: const Color(0xFF05090D), borderRadius: BorderRadius.circular(18), border: Border.all(color: panel2)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
          Icon(Icons.videocam_off_outlined, color: muted, size: 38),
          SizedBox(height: 10),
          Text('КАМЕРА НЕ ПОДКЛЮЧЕНА', style: TextStyle(color: muted, fontWeight: FontWeight.w800, fontSize: 11, letterSpacing: 1)),
          SizedBox(height: 5),
          Text('Видеопоток появится после подключения', style: TextStyle(color: Color(0xFF596775), fontSize: 10)),
        ]),
      ),
      const SectionTitle('Температуры', trailing: '°C'),
      Surface(child: Column(children: const [
        _temperatureRow('Сопло', '— °C', 'Цель: — °C', Icons.local_fire_department_outlined),
        Divider(color: panel2, height: 22),
        _temperatureRow('Стол', '— °C', 'Цель: — °C', Icons.grid_4x4_rounded),
        Divider(color: panel2, height: 22),
        _temperatureRow('Камера', '— °C', 'Нет датчика', Icons.thermostat_outlined),
      ])),
      const SectionTitle('Текущая задача'),
      Surface(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
          Text('Печать не запущена', style: TextStyle(fontWeight: FontWeight.w800)),
          Text('0%', style: TextStyle(color: accent, fontWeight: FontWeight.w900)),
        ]),
        const SizedBox(height: 12),
        ClipRRect(borderRadius: BorderRadius.circular(10), child: const LinearProgressIndicator(value: 0, minHeight: 7, backgroundColor: panel2, color: accent)),
        const SizedBox(height: 13),
        Row(children: const [
          Expanded(child: _jobStat('Осталось', '—')),
          Expanded(child: _jobStat('Слой', '— / —')),
          Expanded(child: _jobStat('Время', '—')),
        ]),
      ])),
      const SectionTitle('Управление печатью'),
      Row(children: [
        Expanded(child: _controlButton(context, Icons.play_arrow_rounded, 'Запустить', accent)),
        const SizedBox(width: 9),
        Expanded(child: _controlButton(context, Icons.pause_rounded, 'Пауза', orange)),
        const SizedBox(width: 9),
        Expanded(child: _controlButton(context, Icons.stop_rounded, 'Остановить', const Color(0xFFFF6B6B))),
      ]),
      const SectionTitle('Перемещение и обслуживание'),
      Surface(child: Wrap(spacing: 8, runSpacing: 8, children: [
        _chipAction(context, 'Домой', Icons.home_outlined),
        _chipAction(context, 'Подогрев', Icons.thermostat),
        _chipAction(context, 'Освещение', Icons.lightbulb_outline),
        _chipAction(context, 'Калибровка', Icons.tune),
      ])),
    ]));
  }

  static Widget _controlButton(BuildContext c, IconData i, String t, Color color) => FilledButton.tonal(
    style: FilledButton.styleFrom(backgroundColor: color.withOpacity(.13), foregroundColor: color, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13))),
    onPressed: () => toast(c, 'Принтер не подключён — команда не отправлена'),
    child: Column(children: [Icon(i, size: 21), const SizedBox(height: 4), Text(t, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800))]),
  );

  static Widget _chipAction(BuildContext c, String t, IconData i) => ActionChip(
    avatar: Icon(i, size: 16, color: accent), label: Text(t, style: const TextStyle(fontSize: 11)),
    backgroundColor: panel2, side: BorderSide.none,
    onPressed: () => toast(c, 'Подключи принтер, чтобы использовать эту функцию'),
  );
}

class _temperatureRow extends StatelessWidget {
  final String title, value, subtitle;
  final IconData icon;
  const _temperatureRow(this.title, this.value, this.subtitle, this.icon);
  @override
  Widget build(BuildContext context) => Row(children: [
    Container(width: 37, height: 37, decoration: BoxDecoration(color: orange.withOpacity(.12), borderRadius: BorderRadius.circular(11)), child: Icon(icon, color: orange, size: 19)),
    const SizedBox(width: 11),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
      const SizedBox(height: 3), Text(subtitle, style: const TextStyle(color: muted, fontSize: 10)),
    ])),
    Text(value, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
  ]);
}

class _jobStat extends StatelessWidget {
  final String label, value;
  const _jobStat(this.label, this.value);
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(label, style: const TextStyle(color: muted, fontSize: 9)),
    const SizedBox(height: 4), Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
  ]);
}

class FilamentPage extends StatelessWidget {
  const FilamentPage({super.key});
  @override
  Widget build(BuildContext context) {
    return PageBody(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Библиотека филамента', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
      const SizedBox(height: 5),
      const Text('Данные катушки считываются с RFID-метки.', style: TextStyle(color: muted, fontSize: 11)),
      const SectionTitle('RFID-катушка · активная'),
      Surface(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(width: 62, height: 62, decoration: BoxDecoration(color: const Color(0xFF3D8FEA).withOpacity(.16), borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.album_rounded, color: Color(0xFF3D8FEA), size: 43)),
          const SizedBox(width: 13),
          const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Ocean Blue', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
            SizedBox(height: 4), Text('Generic · PLA 1.75 mm', style: TextStyle(color: muted, fontSize: 11)),
            SizedBox(height: 6), StatusPill('МЕТКА СЧИТАНА'),
          ])),
        ]),
        const SizedBox(height: 20),
        const _dataRow('Тип пластика', 'PLA'),
        const _dataRow('Цвет пластика', 'Ocean Blue · #2878D0'),
        const _dataRow('Влажность', '32% RH'),
        const _dataRow('Вес остатка', '684 г'),
        const _dataRow('Температура катушки', '22 °C'),
        const _dataRow('Диаметр нити', '1.75 мм'),
        const _dataRow('Рекомендуемая температура сопла', '200–220 °C'),
        const _dataRow('Температура стола', '50–60 °C', last: true),
      ])),
      const SectionTitle('Состояние материала'),
      Surface(child: Row(children: [
        Expanded(child: _qualityIndicator('Влажность', 'Норма', '32%', accent)),
        Container(width: 1, height: 48, color: panel2),
        Expanded(child: _qualityIndicator('Остаток', 'Достаточно', '68%', accent)),
      ])),
      const SectionTitle('Действия с RFID'),
      Surface(child: Column(children: [
        _settingLine(context, Icons.nfc_rounded, 'Считать метку', 'Имитация чтения RFID'),
        const Divider(color: panel2, height: 1),
        _settingLine(context, Icons.edit_outlined, 'Изменить данные', 'Редактирование карточки катушки'),
        const Divider(color: panel2, height: 1),
        _settingLine(context, Icons.add_circle_outline, 'Добавить катушку', 'Создать новую запись'),
      ])),
      const SizedBox(height: 12),
      const Text('Показатели в этой версии демонстрационные. Для реальных значений понадобится RFID-считыватель и датчики.', style: TextStyle(color: muted, fontSize: 10, height: 1.5)),
    ]));
  }

  static Widget _qualityIndicator(String title, String state, String value, Color c) => Padding(
    padding: const EdgeInsets.all(8),
    child: Column(children: [
      Text(title, style: const TextStyle(color: muted, fontSize: 10)),
      const SizedBox(height: 7), Text(value, style: TextStyle(color: c, fontSize: 22, fontWeight: FontWeight.w900)),
      const SizedBox(height: 3), Text(state, style: TextStyle(color: c, fontSize: 10, fontWeight: FontWeight.w700)),
    ]),
  );

  static Widget _settingLine(BuildContext c, IconData i, String title, String sub) => ListTile(
    contentPadding: EdgeInsets.zero, leading: Icon(i, color: accent), title: Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
    subtitle: Text(sub, style: const TextStyle(color: muted, fontSize: 10)), trailing: const Icon(Icons.chevron_right, color: muted, size: 19),
    onTap: () => toast(c, 'Действие пока работает в демонстрационном режиме'),
  );
}

class _dataRow extends StatelessWidget {
  final String label, value;
  final bool last;
  const _dataRow(this.label, this.value, {this.last = false});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 11),
    decoration: BoxDecoration(border: last ? null : const Border(bottom: BorderSide(color: panel2))),
    child: Row(children: [
      Expanded(child: Text(label, style: const TextStyle(color: muted, fontSize: 11))),
      const SizedBox(width: 8),
      Flexible(child: Text(value, textAlign: TextAlign.right, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800))),
    ]),
  );
}

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});
  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  late final WebViewController controller;
  String selected = 'Printables';
  bool loading = true;
  final sites = {
    'Printables': 'https://www.printables.com/',
    'Thingiverse': 'https://www.thingiverse.com/',
  };

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (_) => setState(() => loading = true),
        onPageFinished: (_) => setState(() => loading = false),
        onWebResourceError: (_) => setState(() => loading = false),
      ))
      ..loadRequest(Uri.parse(sites[selected]!));
  }

  void changeSite(String name) {
    setState(() { selected = name; loading = true; });
    controller.loadRequest(Uri.parse(sites[name]!));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 12),
        child: Row(children: [
          const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Каталог моделей', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900)),
            SizedBox(height: 4), Text('Ищи модели на популярных площадках', style: TextStyle(color: muted, fontSize: 10)),
          ])),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(12)),
            child: DropdownButtonHideUnderline(child: DropdownButton<String>(
              value: selected, dropdownColor: panel2, style: const TextStyle(color: Colors.white, fontSize: 11),
              items: sites.keys.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (v) { if (v != null) changeSite(v); },
            )),
          ),
        ]),
      ),
      if (loading) const LinearProgressIndicator(minHeight: 2, color: accent, backgroundColor: panel),
      Expanded(child: WebViewWidget(controller: controller)),
    ]);
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final ip = TextEditingController(text: '192.168.1.100');
  final port = TextEditingController(text: '7125');
  bool autoConnect = false;
  @override
  void dispose() { ip.dispose(); port.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return PageBody(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Подключения и настройки', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
      const SizedBox(height: 5),
      const Text('Настрой связь с принтером и параметры приложения.', style: TextStyle(color: muted, fontSize: 11)),
      const SectionTitle('Подключение принтера по Wi-Fi'),
      Surface(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(children: [
          Icon(Icons.wifi_rounded, color: accent), SizedBox(width: 9),
          Text('Локальная сеть', style: TextStyle(fontWeight: FontWeight.w800)),
          Spacer(), StatusPill('НЕ ПОДКЛЮЧЕНО', color: orange),
        ]),
        const SizedBox(height: 17),
        const Text('IP-адрес принтера', style: TextStyle(color: muted, fontSize: 10)),
        const SizedBox(height: 7),
        TextField(controller: ip, keyboardType: TextInputType.number, decoration: const InputDecoration(hintText: 'Например, 192.168.1.100', prefixIcon: Icon(Icons.router_outlined))),
        const SizedBox(height: 12),
        const Text('Порт', style: TextStyle(color: muted, fontSize: 10)),
        const SizedBox(height: 7),
        TextField(controller: port, keyboardType: TextInputType.number, decoration: const InputDecoration(prefixIcon: Icon(Icons.settings_ethernet_rounded))),
        const SizedBox(height: 12),
        SwitchListTile(
          contentPadding: EdgeInsets.zero, value: autoConnect, activeColor: accent,
          title: const Text('Автоподключение', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
          subtitle: const Text('Пробовать подключаться при запуске', style: TextStyle(color: muted, fontSize: 10)),
          onChanged: (v) => setState(() => autoConnect = v),
        ),
        SizedBox(width: double.infinity, child: FilledButton.icon(
          onPressed: () => toast(context, 'Демо: соединение с ${ip.text}:${port.text} пока не выполняется'),
          icon: const Icon(Icons.link_rounded), label: const Text('Подключить принтер'),
          style: FilledButton.styleFrom(backgroundColor: accent, foregroundColor: bg, padding: const EdgeInsets.symmetric(vertical: 14)),
        )),
      ])),
      const SectionTitle('RFID и датчики'),
      Surface(child: Column(children: const [
        _settingInfo(Icons.nfc_rounded, 'RFID-считыватель', 'Не обнаружен'),
        Divider(color: panel2, height: 20),
        _settingInfo(Icons.water_drop_outlined, 'Датчик влажности', 'Не подключён'),
        Divider(color: panel2, height: 20),
        _settingInfo(Icons.thermostat_outlined, 'Датчик температуры катушки', 'Не подключён'),
      ])),
      const SectionTitle('Удалённый доступ'),
      Surface(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
        StatusPill('НЕ НАСТРОЕН', color: orange),
        SizedBox(height: 10),
        Text('Чтобы управлять принтером не из домашней сети, понадобится защищённый удалённый канал: например, VPN или облачный сервер с авторизацией.', style: TextStyle(color: muted, fontSize: 11, height: 1.5)),
      ])),
      const SectionTitle('Приложение'),
      Surface(child: Column(children: [
        const _settingInfo(Icons.info_outline, 'Filament Hub', 'Версия прототипа 0.1.0'),
        const Divider(color: panel2, height: 20),
        _settingInfo(Icons.code_rounded, 'Экспорт G-code', 'В планах следующего этапа'),
        const Divider(color: panel2, height: 20),
        _settingInfo(Icons.shield_outlined, 'Безопасность', 'Команды принтеру пока отключены'),
      ])),
    ]));
  }
}

class _settingInfo extends StatelessWidget {
  final IconData icon;
  final String title, value;
  const _settingInfo(this.icon, this.title, this.value);
  @override
  Widget build(BuildContext context) => Row(children: [
    Icon(icon, color: accent, size: 19), const SizedBox(width: 11),
    Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11))),
    Text(value, style: const TextStyle(color: muted, fontSize: 10)),
  ]);
}

