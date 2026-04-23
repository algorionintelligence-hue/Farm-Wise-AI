import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/sizes.dart';
import '../../../core/widgets/AppScaffoldBgBasic.dart';
import '../../../l10n/app_localizations.dart';

class InventoryInputsScreen extends ConsumerStatefulWidget {
  const InventoryInputsScreen({super.key});

  @override
  ConsumerState<InventoryInputsScreen> createState() =>
      _InventoryInputsScreenState();
}

class _InventoryInputsScreenState extends ConsumerState<InventoryInputsScreen> {
  final TextEditingController _itemNameCtrl = TextEditingController();
  final TextEditingController _reorderLevelCtrl = TextEditingController();
  final TextEditingController _overstockLevelCtrl = TextEditingController();
  final TextEditingController _transactionItemCtrl = TextEditingController();
  final TextEditingController _transactionQtyCtrl = TextEditingController();
  final TextEditingController _searchCtrl = TextEditingController();

  DateTime? _transactionDate;
  String? _category;
  String? _unit;
  String? _transactionType;
  _InventoryTab _selectedTab = _InventoryTab.list;
  String _selectedFilter = 'All';

  final List<String> _categories = <String>[
    'Feed',
    'Medicine',
    'Minerals',
    'Seeds',
    'Equipment',
    'Other',
  ];

  final List<String> _units = <String>['kg', 'litre', 'bag', 'piece', 'unit'];

  final List<_InventoryItem> _items = const <_InventoryItem>[
    _InventoryItem(
      name: 'Wheat bran',
      category: 'Feed',
      quantity: '205',
      unit: 'kg',
      coverDays: 21,
      status: _InventoryStatus.inStock,
      icon: Icons.grass_rounded,
    ),
    _InventoryItem(
      name: 'Oxytetracycline',
      category: 'Medicine',
      quantity: '3',
      unit: 'bottles',
      coverDays: 8,
      status: _InventoryStatus.low,
      icon: Icons.medication_liquid_rounded,
    ),
    _InventoryItem(
      name: 'Milking machine oil',
      category: 'Equipment',
      quantity: '0',
      unit: 'L',
      coverDays: 0,
      status: _InventoryStatus.out,
      icon: Icons.opacity_rounded,
    ),
    _InventoryItem(
      name: 'Mineral mix',
      category: 'Minerals',
      quantity: '18',
      unit: 'kg',
      coverDays: 34,
      status: _InventoryStatus.inStock,
      icon: Icons.scatter_plot_rounded,
    ),
    _InventoryItem(
      name: 'Disinfectant spray',
      category: 'Other',
      quantity: '11',
      unit: 'pieces',
      coverDays: 27,
      status: _InventoryStatus.inStock,
      icon: Icons.cleaning_services_rounded,
    ),
    _InventoryItem(
      name: 'Seed mix',
      category: 'Seeds',
      quantity: '2',
      unit: 'bags',
      coverDays: 5,
      status: _InventoryStatus.low,
      icon: Icons.spa_rounded,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _itemNameCtrl.addListener(_refresh);
    _reorderLevelCtrl.addListener(_refresh);
    _overstockLevelCtrl.addListener(_refresh);
    _transactionItemCtrl.addListener(_refresh);
    _transactionQtyCtrl.addListener(_refresh);
    _searchCtrl.addListener(_refresh);
  }

  @override
  void dispose() {
    _itemNameCtrl.removeListener(_refresh);
    _reorderLevelCtrl.removeListener(_refresh);
    _overstockLevelCtrl.removeListener(_refresh);
    _transactionItemCtrl.removeListener(_refresh);
    _transactionQtyCtrl.removeListener(_refresh);
    _searchCtrl.removeListener(_refresh);
    _itemNameCtrl.dispose();
    _reorderLevelCtrl.dispose();
    _overstockLevelCtrl.dispose();
    _transactionItemCtrl.dispose();
    _transactionQtyCtrl.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void _showSavedMessage(String text) {
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(text),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'dd/mm/yyyy';
    final String day = date.day.toString().padLeft(2, '0');
    final String month = date.month.toString().padLeft(2, '0');
    final String year = date.year.toString();
    return '$day/$month/$year';
  }

  int get _attentionCount {
    return _items
        .where((item) => item.status == _InventoryStatus.low || item.status == _InventoryStatus.out)
        .length;
  }

  List<_InventoryItem> get _filteredItems {
    final String query = _searchCtrl.text.trim().toLowerCase();

    return _items.where((item) {
      final bool matchesSearch = query.isEmpty ||
          item.name.toLowerCase().contains(query) ||
          item.category.toLowerCase().contains(query);

      bool matchesFilter = true;
      if (_selectedFilter == 'Feed' ||
          _selectedFilter == 'Medicine' ||
          _selectedFilter == 'Equipment') {
        matchesFilter = item.category == _selectedFilter;
      } else if (_selectedFilter == 'Out') {
        matchesFilter = item.status == _InventoryStatus.out;
      } else if (_selectedFilter == 'Low') {
        matchesFilter = item.status == _InventoryStatus.low;
      }

      return matchesSearch && matchesFilter;
    }).toList();
  }

  _InventoryItem? get _matchedTransactionItem {
    final String query = _transactionItemCtrl.text.trim().toLowerCase();
    if (query.isEmpty) return null;

    for (final _InventoryItem item in _items) {
      if (item.name.toLowerCase().contains(query)) {
        return item;
      }
    }
    return null;
  }

  String get _headerTitle {
    switch (_selectedTab) {
      case _InventoryTab.list:
        return 'Inventory';
      case _InventoryTab.addItem:
        return 'Add Item';
      case _InventoryTab.addTransaction:
        return 'Add Transaction';
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    return AppScaffoldBgBasic(
      showBackButton: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: sizes.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTopTabs(),
            const SizedBox(height: sizes.md),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: UColors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: UColors.borderPrimary),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildHeaderBar(context, l10n),
                  Padding(
                    padding: const EdgeInsets.all(sizes.md),
                    child: _buildCurrentView(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopTabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: UColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: UColors.borderPrimary),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _TopTabButton(
              label: 'Inventory List',
              isActive: _selectedTab == _InventoryTab.list,
              onTap: () {
                setState(() => _selectedTab = _InventoryTab.list);
              },
            ),
          ),
          Expanded(
            child: _TopTabButton(
              label: 'Add Item',
              isActive: _selectedTab == _InventoryTab.addItem,
              onTap: () {
                setState(() => _selectedTab = _InventoryTab.addItem);
              },
            ),
          ),
          Expanded(
            child: _TopTabButton(
              label: 'Add Transaction',
              isActive: _selectedTab == _InventoryTab.addTransaction,
              onTap: () {
                setState(() => _selectedTab = _InventoryTab.addTransaction);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderBar(BuildContext context, AppLocalizations l10n) {
    final bool showAction = _selectedTab == _InventoryTab.list;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: sizes.md, vertical: 12),
      decoration: const BoxDecoration(
        color: UColors.colorPrimary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(18),
            child: Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.24)),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 14,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: sizes.sm),
          Expanded(
            child: Text(
              showAction ? l10n.inventory : _headerTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: sizes.fontSizeMd,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(
            width: 92,
            child: showAction
                ? Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _selectedTab = _InventoryTab.addItem);
                      },
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.14),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white.withOpacity(0.14)),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.add, size: 14, color: Colors.white),
                              SizedBox(width: 4),
                              Text(
                                'Add item',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentView() {
    switch (_selectedTab) {
      case _InventoryTab.list:
        return _buildInventoryList();
      case _InventoryTab.addItem:
        return _buildAddItem();
      case _InventoryTab.addTransaction:
        return _buildAddTransaction();
    }
  }

  Widget _buildInventoryList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Inventory List',
          style: TextStyle(
            fontSize: sizes.fontSizeHeadings,
            fontWeight: FontWeight.w800,
            color: UColors.primary,
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          'INVENTORY_ITEMS + STOCK_LEVELS',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: UColors.textSecondary,
          ),
        ),
        const SizedBox(height: sizes.md),
        Row(
          children: <Widget>[
            Expanded(
              child: _StatCard(
                value: '${_items.length}',
                label: 'Total items',
                color: UColors.gradientBarGreen1,
              ),
            ),
            const SizedBox(width: sizes.sm),
            Expanded(
              child: _StatCard(
                value: '$_attentionCount',
                label: 'Need attention',
                color: UColors.error,
              ),
            ),
            const SizedBox(width: sizes.sm),
            const Expanded(
              child: _StatCard(
                value: '43d',
                label: 'Avg cover',
                color: UColors.primary1,
              ),
            ),
          ],
        ),
        const SizedBox(height: sizes.md),
        const _AlertStrip(
          title: 'Machine oil',
          detail: 'Out of stock',
          cover: '0 days cover',
          status: _InventoryStatus.out,
        ),
        const SizedBox(height: sizes.sm),
        const _AlertStrip(
          title: 'Oxytetracycline',
          detail: '3 bottles',
          cover: '8 days cover',
          status: _InventoryStatus.low,
        ),
        const SizedBox(height: sizes.md),
        _buildSearchBox(),
        const SizedBox(height: sizes.sm),
        _buildFilters(),
        const SizedBox(height: sizes.md),
        for (final _InventoryItem item in _filteredItems) _buildItemCard(item),
      ],
    );
  }

  Widget _buildAddItem() {
    final String helperText = _unit == null ? 'select unit first' : 'record in $_unit';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Add Inventory Item',
          style: TextStyle(
            fontSize: sizes.fontSizeLg,
            fontWeight: FontWeight.w800,
            color: UColors.primary,
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          'INVENTORY_ITEMS table',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: UColors.textSecondary,
          ),
        ),
        const SizedBox(height: sizes.md),
        _buildInputField(
          label: 'item_name *',
          hintText: 'e.g. Wheat bran, Tetracycline...',
          controller: _itemNameCtrl,
        ),
        const SizedBox(height: sizes.sm),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _buildDropdownField(
                label: 'category *',
                value: _category,
                options: _categories,
                onChanged: (value) {
                  setState(() => _category = value);
                },
              ),
            ),
            const SizedBox(width: sizes.sm),
            Expanded(
              child: _buildDropdownField(
                label: 'unit_of_measure *',
                value: _unit,
                options: _units,
                onChanged: (value) {
                  setState(() => _unit = value);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: sizes.sm),
        const Divider(color: UColors.borderSecondary, height: 1),
        const SizedBox(height: sizes.sm),
        const _InlineLabel(
          color: UColors.warning,
          text: 'Stock thresholds',
        ),
        const SizedBox(height: sizes.sm),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildInputField(
                    label: 'reorder_level',
                    hintText: '0',
                    controller: _reorderLevelCtrl,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '- $helperText',
                    style: const TextStyle(
                      fontSize: 11,
                      color: UColors.colorPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: sizes.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildInputField(
                    label: 'overstock_level',
                    hintText: '0',
                    controller: _overstockLevelCtrl,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '- $helperText',
                    style: const TextStyle(
                      fontSize: 11,
                      color: UColors.colorPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: sizes.md),
        _buildPreviewCard(
          title: _itemNameCtrl.text.trim().isEmpty ? 'Item preview' : _itemNameCtrl.text.trim(),
          subtitle:
              '${_category ?? 'Select category'} • ${_unit ?? 'Select unit'} • reorder ${_reorderLevelCtrl.text.trim().isEmpty ? '-' : _reorderLevelCtrl.text.trim()}',
        ),
        const SizedBox(height: sizes.md),
        _buildActionButton(
          label: 'Save item',
          onTap: () => _showSavedMessage('Item saved successfully.'),
        ),
      ],
    );
  }

  Widget _buildAddTransaction() {
    final _InventoryItem? matchedItem = _matchedTransactionItem;
    final String availableStock = matchedItem == null
        ? 'select item'
        : '${matchedItem.quantity} ${matchedItem.unit}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Add Transaction',
          style: TextStyle(
            fontSize: sizes.fontSizeLg,
            fontWeight: FontWeight.w800,
            color: UColors.primary,
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          'INVENTORY_TRANSACTIONS table',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: UColors.textSecondary,
          ),
        ),
        const SizedBox(height: sizes.md),
        _buildInputField(
          label: 'item_id (select item) *',
          hintText: 'Search or select item',
          controller: _transactionItemCtrl,
        ),
        const SizedBox(height: sizes.sm),
        const Text(
          'txn_type *',
          style: TextStyle(
            fontSize: sizes.fontSizeSm,
            fontWeight: FontWeight.w700,
            color: UColors.colorPrimary,
          ),
        ),
        const SizedBox(height: sizes.xs),
        Row(
          children: <Widget>[
            Expanded(
              child: _TransactionChip(
                label: 'Purchase',
                isSelected: _transactionType == 'Purchase',
                onTap: () {
                  setState(() => _transactionType = 'Purchase');
                },
              ),
            ),
            const SizedBox(width: sizes.xs),
            Expanded(
              child: _TransactionChip(
                label: 'Consume',
                isSelected: _transactionType == 'Issue',
                onTap: () {
                  setState(() => _transactionType = 'Issue');
                },
              ),
            ),
            const SizedBox(width: sizes.xs),
            Expanded(
              child: _TransactionChip(
                label: 'Adjust',
                isSelected: _transactionType == 'Adjustment',
                onTap: () {
                  setState(() => _transactionType = 'Adjustment');
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: sizes.sm),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: sizes.md, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F9E7),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFA4CD63)),
          ),
          child: Row(
            children: <Widget>[
              const Text(
                'Available stock',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: UColors.colorPrimary,
                ),
              ),
              const Spacer(),
              Text(
                availableStock,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: UColors.colorPrimary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: sizes.sm),
        _buildDateField(),
        const SizedBox(height: sizes.sm),
        _buildInputField(
          label: 'quantity *',
          hintText: '0',
          controller: _transactionQtyCtrl,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
        const SizedBox(height: sizes.md),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: sizes.md, vertical: 12),
          decoration: BoxDecoration(
            color: UColors.primary,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: <Widget>[
              const Text(
                'total_movement',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Colors.white70,
                ),
              ),
              const Spacer(),
              Flexible(
                child: Text(
                  _transactionSummary(),
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: sizes.fontSizeMd,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: sizes.md),
        _buildActionButton(
          label: 'Save transaction',
          onTap: () => _showSavedMessage('Transaction saved successfully.'),
        ),
      ],
    );
  }

  String _transactionSummary() {
    final String item = _transactionItemCtrl.text.trim().isEmpty
        ? 'No item'
        : _transactionItemCtrl.text.trim();
    final String type = _transactionType ?? 'No type';
    final String quantity = _transactionQtyCtrl.text.trim().isEmpty
        ? '0'
        : _transactionQtyCtrl.text.trim();
    return '$item • $type • $quantity';
  }

  Widget _buildSearchBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Search',
          style: TextStyle(
            fontSize: sizes.fontSizeSm,
            fontWeight: FontWeight.w700,
            color: UColors.colorPrimary,
          ),
        ),
        const SizedBox(height: sizes.xs),
        TextField(
          controller: _searchCtrl,
          decoration: InputDecoration(
            hintText: 'Search item_name...',
            prefixIcon: const Icon(Icons.search_rounded, color: UColors.darkGrey),
            filled: true,
            fillColor: UColors.inputBg,
            contentPadding: const EdgeInsets.symmetric(horizontal: sizes.md, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: UColors.borderPrimary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: UColors.borderPrimary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: UColors.colorPrimary, width: 1.2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilters() {
    final List<String> filters = <String>['All', 'Feed', 'Medicine', 'Equipment', 'Out', 'Low'];

    return Wrap(
      spacing: sizes.xs,
      runSpacing: sizes.xs,
      children: filters.map((String filter) {
        Color tint = UColors.colorPrimary;
        if (filter == 'Out') tint = UColors.error;
        if (filter == 'Low') tint = UColors.warning;

        String label = filter;
        if (filter == 'All') label = 'All (${_items.length})';
        if (filter == 'Out') {
          label = 'Out (${_items.where((item) => item.status == _InventoryStatus.out).length})';
        }
        if (filter == 'Low') {
          label = 'Low (${_items.where((item) => item.status == _InventoryStatus.low).length})';
        }

        return _FilterChip(
          label: label,
          isActive: _selectedFilter == filter,
          tint: tint,
          onTap: () {
            setState(() => _selectedFilter = filter);
          },
        );
      }).toList(),
    );
  }

  Widget _buildItemCard(_InventoryItem item) {
    final Color accent = _statusColor(item.status);
    final Color background = _statusBackground(item.status);

    return Container(
      margin: const EdgeInsets.only(bottom: sizes.sm),
      padding: const EdgeInsets.all(sizes.smmd),
      decoration: BoxDecoration(
        color: UColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accent.withOpacity(0.5)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(item.icon, size: 18, color: accent),
          ),
          const SizedBox(width: sizes.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: sizes.fontSizeSm,
                    fontWeight: FontWeight.w800,
                    color: UColors.primary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${item.category} · ${item.unit}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: UColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${item.coverDays} days cover',
                  style: const TextStyle(
                    fontSize: 11,
                    color: UColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: sizes.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.w800,
                    fontSize: sizes.fontSizeMd,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: item.quantity),
                    TextSpan(
                      text: ' ${item.unit}',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: sizes.xs),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: sizes.sm, vertical: 4),
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _statusText(item.status),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: accent,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontSize: sizes.fontSizeSm,
            fontWeight: FontWeight.w700,
            color: UColors.colorPrimary,
          ),
        ),
        const SizedBox(height: sizes.xs),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: UColors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: sizes.md, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: UColors.borderPrimary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: UColors.borderPrimary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: UColors.colorPrimary, width: 1.2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontSize: sizes.fontSizeSm,
            fontWeight: FontWeight.w700,
            color: UColors.colorPrimary,
          ),
        ),
        const SizedBox(height: sizes.xs),
        DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: 'Select',
            filled: true,
            fillColor: UColors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: sizes.md, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: UColors.borderPrimary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: UColors.borderPrimary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: UColors.colorPrimary, width: 1.2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'txn_date *',
          style: TextStyle(
            fontSize: sizes.fontSizeSm,
            fontWeight: FontWeight.w700,
            color: UColors.colorPrimary,
          ),
        ),
        const SizedBox(height: sizes.xs),
        InkWell(
          onTap: () async {
            FocusScope.of(context).unfocus();
            final DateTime? picked = await showDatePicker(
              context: context,
              firstDate: DateTime(2020),
              lastDate: DateTime(2035),
              initialDate: _transactionDate ?? DateTime.now(),
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: UColors.colorPrimary,
                      onPrimary: Colors.white,
                      surface: Colors.white,
                      onSurface: UColors.primary,
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (picked != null) {
              setState(() => _transactionDate = picked);
            }
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: sizes.md, vertical: 14),
            decoration: BoxDecoration(
              color: UColors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: UColors.borderPrimary),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _formatDate(_transactionDate),
                    style: TextStyle(
                      fontSize: sizes.fontSizeSm,
                      fontWeight: _transactionDate == null ? FontWeight.w400 : FontWeight.w600,
                      color: _transactionDate == null ? UColors.darkGrey : UColors.primary,
                    ),
                  ),
                ),
                const Icon(
                  Icons.calendar_today_rounded,
                  size: 18,
                  color: UColors.primary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPreviewCard({
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(sizes.md),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6F1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: UColors.borderSecondary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: sizes.fontSizeMd,
              fontWeight: FontWeight.w800,
              color: UColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: UColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: UColors.primary,
          side: const BorderSide(color: UColors.borderPrimary),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: sizes.fontSizeMd,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Color _statusColor(_InventoryStatus status) {
    switch (status) {
      case _InventoryStatus.inStock:
        return UColors.gradientBarGreen1;
      case _InventoryStatus.low:
        return UColors.warning;
      case _InventoryStatus.out:
        return UColors.error;
    }
  }

  Color _statusBackground(_InventoryStatus status) {
    switch (status) {
      case _InventoryStatus.inStock:
        return const Color(0xFFEAF4DF);
      case _InventoryStatus.low:
        return const Color(0xFFFFF2DE);
      case _InventoryStatus.out:
        return const Color(0xFFFFECEB);
    }
  }

  String _statusText(_InventoryStatus status) {
    switch (status) {
      case _InventoryStatus.inStock:
        return 'In stock';
      case _InventoryStatus.low:
        return 'Low stock';
      case _InventoryStatus.out:
        return 'Out of stock';
    }
  }
}

enum _InventoryTab { list, addItem, addTransaction }

enum _InventoryStatus { inStock, low, out }

class _InventoryItem {
  const _InventoryItem({
    required this.name,
    required this.category,
    required this.quantity,
    required this.unit,
    required this.coverDays,
    required this.status,
    required this.icon,
  });

  final String name;
  final String category;
  final String quantity;
  final String unit;
  final int coverDays;
  final _InventoryStatus status;
  final IconData icon;
}

class _TopTabButton extends StatelessWidget {
  const _TopTabButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? UColors.colorPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: isActive ? Colors.white : UColors.primary,
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    required this.color,
  });

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(sizes.smmd),
      decoration: BoxDecoration(
        color: UColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: UColors.borderPrimary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: UColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _AlertStrip extends StatelessWidget {
  const _AlertStrip({
    required this.title,
    required this.detail,
    required this.cover,
    required this.status,
  });

  final String title;
  final String detail;
  final String cover;
  final _InventoryStatus status;

  @override
  Widget build(BuildContext context) {
    Color color = UColors.gradientBarGreen1;
    Color background = const Color(0xFFEAF4DF);

    if (status == _InventoryStatus.low) {
      color = UColors.warning;
      background = const Color(0xFFFFF4E4);
    }
    if (status == _InventoryStatus.out) {
      color = UColors.error;
      background = const Color(0xFFFFECEB);
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: sizes.md, vertical: 12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.45)),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.error_outline_rounded, size: 18, color: color),
          const SizedBox(width: sizes.sm),
          Expanded(
            child: Text(
              '$title - $detail - $cover',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isActive,
    required this.tint,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final Color tint;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? tint.withOpacity(0.12) : UColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? tint : UColors.borderPrimary,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: isActive ? tint : UColors.primary,
          ),
        ),
      ),
    );
  }
}

class _InlineLabel extends StatelessWidget {
  const _InlineLabel({
    required this.color,
    required this.text,
  });

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        const SizedBox(width: sizes.xs),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _TransactionChip extends StatelessWidget {
  const _TransactionChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF1F6FF) : UColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF6FA3E8) : UColors.borderPrimary,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: isSelected ? const Color(0xFF255EAA) : UColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
