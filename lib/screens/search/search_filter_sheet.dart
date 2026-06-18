import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

// ── Thumb dark mode: біле кільце → синє заповнення → біла точка ─────────────
class _DarkThumbShape extends RangeSliderThumbShape {
  const _DarkThumbShape();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => const Size(22, 22);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool isOnTop = false,
    required SliderThemeData sliderTheme,
    TextDirection textDirection = TextDirection.ltr,
    Thumb thumb = Thumb.start,
    bool isPressed = false,
  }) {
    final canvas = context.canvas;
    canvas.drawCircle(center, 11, Paint()..color = Colors.white);
    canvas.drawCircle(center, 9, Paint()..color = AppColors.primary);
    canvas.drawCircle(center, 3.5, Paint()..color = Colors.white);
  }
}

// ── Thumb light mode: біле заповнення → синій outline ───────────────────────
class _LightThumbShape extends RangeSliderThumbShape {
  const _LightThumbShape();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => const Size(22, 22);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool isOnTop = false,
    required SliderThemeData sliderTheme,
    TextDirection textDirection = TextDirection.ltr,
    Thumb thumb = Thumb.start,
    bool isPressed = false,
  }) {
    final canvas = context.canvas;
    // Тінь
    canvas.drawCircle(
      center,
      11,
      Paint()
        ..color = AppColors.primary.withValues(alpha: 0.15)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
    // Біле заповнення
    canvas.drawCircle(center, 10, Paint()..color = Colors.white);
    // Синій outline
    canvas.drawCircle(
      center,
      9,
      Paint()
        ..color = AppColors.primary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0,
    );
  }
}

// ── Bottom sheet ─────────────────────────────────────────────────────────────
class SearchFilterSheet extends StatefulWidget {
  const SearchFilterSheet({super.key});

  @override
  State<SearchFilterSheet> createState() => _SearchFilterSheetState();
}

class _SearchFilterSheetState extends State<SearchFilterSheet> {
  final List<String> _categories = [
    'Design',
    'Painting',
    'Coding',
    'Music',
    'Visual identiy',
    'Mathmatics',
  ];
  final Set<String> _selectedCategories = {'Design', 'Coding'};

  RangeValues _priceRange = const RangeValues(90, 200);
  static const double _priceMin = 0;
  static const double _priceMax = 500;

  final List<String> _durations = [
    '3-8 Hours',
    '8-14 Hours',
    '14-20 Hours',
    '20-24 Hours',
    '24-30 Hours',
  ];
  final Set<String> _selectedDurations = {'3-8 Hours'};

  void _clear() => setState(() {
    _selectedCategories.clear();
    _selectedDurations.clear();
    _priceRange = const RangeValues(90, 200);
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // ── Кольори ──────────────────────────────────────────────────────────────
    final Color bg = isDark ? const Color(0xFF1E1E35) : Colors.white;
    final Color titleColor = isDark ? Colors.white : const Color(0xFF1A1A2E);
    final Color sectionColor = isDark ? Colors.white : const Color(0xFF1A1A2E);
    // Dark chips — темно-синюваті; Light chips — дуже світло-сірі
    final Color chipBg = isDark
        ? const Color(0xFF383855)
        : const Color(0xFFF0F0FA);
    const Color chipText = AppColors.greyText;
    final Color trackInactive = isDark
        ? const Color(0xFF3A3A55)
        : const Color(0xFFDDDDEE);

    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          SizedBox(height: 10.h),
          Container(
            width: 40.w, height: 4.h,
            decoration: BoxDecoration(
              color: chipText.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 6.h),

          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Header ─────────────────────────────────────────────────
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: SizedBox(width: 36.w, height: 36.h,
                          child: Icon(Icons.close, size: 20.w, color: titleColor),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Search Filter',
                            style: AppTextStyles.s16w500.copyWith(
                              fontWeight: FontWeight.w700,
                              color: titleColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 36.w),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  // ── Categories ─────────────────────────────────────────────
                  _SectionTitle(title: 'Categories', color: sectionColor),
                  SizedBox(height: 14.h),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _categories.map((cat) {
                      final sel = _selectedCategories.contains(cat);
                      return _Chip(
                        label: cat,
                        selected: sel,
                        chipBg: chipBg,
                        chipText: chipText,
                        onTap: () => setState(
                          () => sel
                              ? _selectedCategories.remove(cat)
                              : _selectedCategories.add(cat),
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: 28.h),

                  // ── Price ──────────────────────────────────────────────────
                  _SectionTitle(title: 'Price', color: sectionColor),
                  SizedBox(height: 8.h),

                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 2.5,
                      activeTrackColor: AppColors.primary,
                      inactiveTrackColor: trackInactive,
                      overlayColor: Colors.transparent,
                      rangeThumbShape: isDark
                          ? const _DarkThumbShape()
                          : const _LightThumbShape(),
                    ),
                    child: RangeSlider(
                      values: _priceRange,
                      min: _priceMin,
                      max: _priceMax,
                      onChanged: (v) => setState(() => _priceRange = v),
                    ),
                  ),

                  // Лейбли під повзунками
                  SizedBox(height: 28.h,

                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        const double thumbRadius = 11;

                        final leftPos =
                            ((_priceRange.start - _priceMin) /
                                (_priceMax - _priceMin)) *
                            (constraints.maxWidth - thumbRadius * 2);

                        final rightPos =
                            ((_priceRange.end - _priceMin) /
                                (_priceMax - _priceMin)) *
                            (constraints.maxWidth - thumbRadius * 2);

                        return Stack(
                          children: [
                            Positioned(
                              left: (leftPos - 5).clamp(
                                0.0,
                                constraints.maxWidth - 40,
                              ),

                              child: SizedBox(width: 40.w,

                                child: Center(
                                  child: _PriceLabel(
                                    value: _priceRange.start,
                                    color: chipText,
                                  ),
                                ),
                              ),
                            ),

                            Positioned(
                              left: (rightPos - 15).clamp(
                                0.0,
                                constraints.maxWidth - 40,
                              ),

                              child: SizedBox(width: 40.w,

                                child: Center(
                                  child: _PriceLabel(
                                    value: _priceRange.end,
                                    color: chipText,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 28.h),

                  // ── Duration ───────────────────────────────────────────────
                  _SectionTitle(title: 'Duration', color: sectionColor),
                  SizedBox(height: 14.h),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _durations.map((dur) {
                      final sel = _selectedDurations.contains(dur);
                      return _Chip(
                        label: dur,
                        selected: sel,
                        chipBg: chipBg,
                        chipText: chipText,
                        onTap: () => setState(
                          () => sel
                              ? _selectedDurations.remove(dur)
                              : _selectedDurations.add(dur),
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),

          // ── Кнопки ────────────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(
              24,
              0,
              24,
              24 + MediaQuery.of(context).padding.bottom,
            ),
            child: Row(
              children: [
                SizedBox(width: 90.w, height: 44.h,

                  child: OutlinedButton(
                    onPressed: _clear,

                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: AppColors.primary, width: 1.w,
                      ),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),

                      backgroundColor: isDark
                          ? const Color(0xFF858597)
                          : const Color(0xFFF4F3FD),
                    ),

                    child: Text(
                      'Clear',

                      style: AppTextStyles.s14w400.copyWith(
                        color: isDark ? Colors.white : AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 14.w),

                Expanded(
                  child: SizedBox(height: 50.h,

                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),

                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        elevation: 0,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),

                      child: Text(
                        'Apply Filter',

                        style: AppTextStyles.s14w400.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Допоміжні віджети ────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.color});
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) => Text(
    title,
    style: AppTextStyles.s14w400.copyWith(
      fontSize: 16.sp,
      fontWeight: FontWeight.w700,
      color: color,
    ),
  );
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.chipText,
    required this.chipBg,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color chipText;
  final Color chipBg;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8),

        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary
              : (isDark ? const Color(0xFF858597) : const Color(0xFFF4F3FD)),

          borderRadius: BorderRadius.circular(10.r),
        ),

        child: Text(
          label,

          style: TextStyle(
            fontSize: 14.sp,

            color: selected
                ? Colors.white
                : (isDark ? Colors.white : AppColors.greyText),
          ),
        ),
      ),
    );
  }
}

class _PriceLabel extends StatelessWidget {
  const _PriceLabel({required this.value, required this.color});

  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      '\$${value.round()}',
      textAlign: TextAlign.center,

      style: AppTextStyles.s12w400.copyWith(fontSize: 13.sp, color: color),
    );
  }
}
