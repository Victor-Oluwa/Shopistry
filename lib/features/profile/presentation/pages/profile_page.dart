import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/localization/locale_cubit.dart';
import '../../../../l10n/app_localizations.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.navProfile),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileHeader(),
              SizedBox(height: 40.h),
              Text(
                l10n.settings,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.h),
              _buildLanguageSelector(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 40.r,
          backgroundColor: AppColors.primary.withOpacity(0.1),
          child: Icon(Icons.person, size: 40.sp, color: AppColors.primary),
        ),
        SizedBox(width: 20.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Guest User',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              'guest@shopistry.com',
              style: TextStyle(fontSize: 14.sp, color: AppColors.textSecondary),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLanguageSelector(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, currentLocale) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.surfaceLight),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.language, color: AppColors.primary),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Text(
                        '${l10n.language} / Èdè / Asụ̀sụ̀ / Yare',
                        style: const TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              DropdownButton<String>(
                value: currentLocale.languageCode,
                underline: const SizedBox(),
                dropdownColor: AppColors.surface,
                items: const [
                  DropdownMenuItem(
                    value: 'en',
                    child: Text('English', style: TextStyle(color: Colors.white)),
                  ),
                  DropdownMenuItem(
                    value: 'yo',
                    child: Text('Yorùbá', style: TextStyle(color: Colors.white)),
                  ),
                  DropdownMenuItem(
                    value: 'ig',
                    child: Text('Ígbò', style: TextStyle(color: Colors.white)),
                  ),
                  DropdownMenuItem(
                    value: 'ha',
                    child: Text('Hausa', style: TextStyle(color: Colors.white)),
                  ),
                ],
                onChanged: (String? code) {
                  if (code != null) {
                    context.read<LocaleCubit>().setLocale(Locale(code));
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}